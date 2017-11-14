/*
 * 2010-09
 * 新設計のXHTML構造に対応したスクリプト
 */

/**
 * 対象にしているコメント
 * 
 * @type Element
 */
var target = null;
/**
 * @type String
 */
var xhtmlns = document.documentElement.namespaceURI;
/**
 * @type Element
 */
var article;
/**
 * @type Element
 */
var commentBox;

var contentMap = new Object();
var compedTextMap = new Object();

function getCommentBox() {
	var divs = document.getElementsByTagName('div');
	for ( var int = 0; int < divs.length; int++) {
		var div = divs.item(int);
		if (div.hasAttribute("class") && div.getAttribute("class") == "commentBox") {
			return div;
		}
	}
	return null;
}
function openArticle() {}
function closeArticle() {

}
function compressArticle() {
	var number = -1;
	var head;
	var content;
	var foot;
	/*
	 * 要素の追加や削除はfor文の中では行わないようにしなければならない
	 * 
	 */
	for ( var int = 0; int < article.childNodes.length; int++) {
		var articleChildNode = article.childNodes.item(int);
		if (articleChildNode.nodeType == Node.ELEMENT_NODE) {
			var classAttr = articleChildNode.getAttribute("class");

			if (classAttr == "content") {
				//
				content = articleChildNode;
				number--;
				contentMap[number.toString()] = content;
			}
		}
	}
}

function uncompressArticle() {

}

function openCommentBox() {

}

function closeCommentBox() {

}

/**
 * <p></p>
 * <pre>ul.childComments
 *     li.comment
 *     li.comment ...
 * </pre>
 * @param {Element}
 *            childComments ul.childComments
 * @param {Boolean}
 *            compressChildNodes
 */
function compressChildComments(childComments, compressChildNodes) {
	var childCommentList = childComments.childNodes;
	for ( var int = 0; int < childCommentList.length; int++) {
		if (childCommentList.item(int).nodeType == Node.ELEMENT_NODE) {
			compressComment(childCommentList.item(int), compressChildNodes);
		}
	}
}

/**
 * <p></p>
 * <pre>ul.childComments
 *     li.comment
 *     li.comment ...</pre>
 * @param {Element}
 *            childComments ul.childComments
 * @param {Boolean}
 *            compressChildNodes
 */
function uncompressChildComments(childComments, uncompressChildNodes) {
	var childCommentList = childComments.childNodes;
	for ( var int = 0; int < childCommentList.length; int++) {
		if (childCommentList.item(int).nodeType == Node.ELEMENT_NODE) {
			uncompressComment(childCommentList.item(int), uncompressChildNodes);
		}
	}
}

/**
 * <p>
 * 全てのコメントを圧縮する
 * </p>
 */
function compressCommentBox() {
	var comments = commentBox.childNodes;
	
	for ( var int = 0; int < comments.length; int++) {
		var node = comments.item(int);
		if (node.nodeType == Node.ELEMENT_NODE && node.hasAttribute("class") && node.getAttribute("class") == "childComments") {
			compressChildComments(node, true);
		}
	}
}

/**
 * 全てのコメントを展開する
 */
function uncompressCommentBox() {
	var comments = commentBox.childNodes;
	
	for ( var int = 0; int < comments.length; int++) {
		var node = comments.item(int);
		if (node.nodeType == Node.ELEMENT_NODE && node.getAttribute("class") == "childComments") {
			uncompressChildComments(node, true);
		}
	}
}

/**
 * @param {Element}
 *            comment
 * @param {Boolean}
 *            openChildNodes
 */
function openComment(comment, openChildNodes) {

}

/**
 * @param {Element}
 *            comment
 * @param {Boolean}
 *            closeChildNodes
 */
function closeComment(comment, closeChildNodes) {

}

/**
 * @param {Element}
 *            comment
 * @param {Boolean}
 *            compressChildNodes
 */
function compressComment(comment, compressChildNodes) {
	/*
	 * 要素の追加や削除はfor文の中では行わないようにしなければならない
	 * li#{number}.comment
	 * 	dl.head
	 * 		dt
	 * 			)参照
	 * 		dd.number
	 * 		dt
	 * 			)関係
	 * 		dd
	 * 		dt
	 * 			)番号
	 * 		dd.number
	 * 		dt
	 * 			日時
	 * 		dd.datetime
	 * 		dt
	 * 			)名前
	 * 		dd.authorName
	 * 		dt
	 * 			)ツール
	 * 		dd
	 * 	div.content
	 * 	div.foot
	 */
	var number = getNumber(comment);
	for ( var int = 0; int < comment.childNodes.length; int++) {
		var commentChildNode = comment.childNodes.item(int);
		
		if (commentChildNode.nodeType == Node.ELEMENT_NODE) {
			var classAttr = commentChildNode.getAttribute("class");
			if (classAttr == "head") {
				//
				var head = commentChildNode;
				var image;
				for (var int2 = 0; int2 < head.childNodes.length; int2++) {
					var item = head.childNodes.item(int2);
					if (item.nodeName == "dt" && item.nodeValue == "展開／圧縮") {
						item.nextSibling.firstChild;
					}
				}
			} else if (classAttr == "content") {
				//
				var content = commentChildNode;
				if (!contentMap[number]) {
					contentMap[number] = content;
				}
				/*
				 * <p class="compressed-text">{compressedText}</p>
				 */
				if (!comment.compressed) {
					var compressedText;
					if (compedTextMap[number]) {
						compressedText = compedTextMap[number];
					} else {
						compressedText = document.createElementNS(xhtmlns, "p");
						compressedText.setAttribute("class", "compressed-text");
						var extractedText = extractText(content);
						var compressedTextString = "[" + extractedText.length + "]" + " " + extractedText.substring(0, 20);
						compressedText.appendChild(document.createTextNode(compressedTextString));
						compedTextMap[number] = compressedText;
					}
					comment.replaceChild(compressedText, content);
					comment.compressed = true;
				}
			} else if (classAttr == "foot") {
				//
				var styleAttr = document.createAttribute("style");
				styleAttr.nodeValue = "display: none;";
				commentChildNode.attributes.setNamedItem(styleAttr);
			} else if (classAttr == "childComments" && compressChildNodes) {
				//
				compressChildComments(commentChildNode, true);
			}
		}
	}
}

/**
 * <p>
 * コメントを展開する。
 * </p>
 * 
 * @param {Element}
 *            comment
 * @param {Boolean}
 *            uncompressChildNodes
 */
function uncompressComment(comment, uncompressChildNodes) {
	// 要素の追加や削除はfor文の中では行わないようにしなければならない
	// 要素の交換は問題ない
	var number = getNumber(comment);
	for ( var int = 0; int < comment.childNodes.length; int++) {
		var commentChildNode = comment.childNodes.item(int);
		if (commentChildNode.nodeType == Node.ELEMENT_NODE && commentChildNode.hasAttribute("class")) {
			var classAttr = commentChildNode.getAttribute("class");
			if (classAttr == "head") {
				head = commentChildNode;
				
			} else if (classAttr == "compressed-text") {
				if (comment.compressed) {
					comment.replaceChild(contentMap[number], commentChildNode);
					comment.compressed = false;
				}
			} else if (classAttr == "foot") {
				if (commentChildNode.hasAttribute("style")) {
					commentChildNode.removeAttribute("style");
				}
			} else if (classAttr == "childCmments" && uncompressChildNodes) {//dl.chileComments
				//
				uncompressComment(commentChildNode, true);
			}
		}
	}
}

/**
 * @param {Element}
 *            comment
 */
function compunc(comment) {
	if (comment.compressed) {
		uncompressComment(comment, false);
	} else {
		compressComment(comment, false);
	}
}

/**
 * @param {Element}
 *            comment
 */
function compuncAll(comment) {
	if (!comment.hasOwnProperty("compressed") || !comment.compressed) {
		compressComment(comment, true);
	} else {
		uncompressComment(comment, true);
	}
}

/**
 * idから番号を取得する
 * @param {Element}
 *            comment li.#c{number}.comment
 * @returns {String}
 */
function getNumber(comment) {
	var id = comment.getAttribute("id");
	return id.substring(1, id.length);
}

/**
 * @param {Node}
 *            targetNode
 * @returns {String} Nodeから抽出した文字列
 */
function extractText(targetNode) {
	var str = new String;
	var nodes = targetNode.childNodes;
	for ( var int = 0; int < nodes.length; int++) {
		if (nodes.item(int).nodeType == Node.TEXT_NODE) {
			str = str + nodes.item(int).data;
		} else if (nodes.item(int).nodeType == Node.ELEMENT_NODE) {
			str = str + extractText(nodes.item(int));
		}
	}
	return str;
}

/**
 * @param {Element}
 *            body
 */
function setup(body) {
	//document = new Document();
	commentBox = getCommentBox();
	var cmHeader = document.getElementById("container-manager");
	
	var dl = document.createElementNS(xhtmlns, "dl");
	cmHeader.parentNode.insertBefore(dl, cmHeader.nextSibling);
	
	var articleTerm = document.createElementNS(xhtmlns, "dt");
	articleTerm.appendChild(document.createTextNode("記事"));
	dl.appendChild(articleTerm);
	
	var coaDd = document.createElementNS(xhtmlns, "dd");
	dl.appendChild(coaDd);
	createButton("閉じる", "closeArticle();", coaDd);
	createButton("開く", "openArticle();", coaDd);
	
	var cuaDd = document.createElementNS(xhtmlns, "dd");
	dl.appendChild(cuaDd);
	createButton("圧縮", "compressArticle();", cuaDd);
	createButton("展開", "uncompressArticle();", cuaDd);
	
	var cbTerm = document.createElementNS(xhtmlns, "dt");
	cbTerm.appendChild(document.createTextNode("コメントボックス"));
	dl.appendChild(cbTerm);
	
	var cocDd = document.createElementNS(xhtmlns, "dd");
	dl.appendChild(cocDd);
	createButton("閉じる", "compressedCommentBox();", cocDd);
	createButton("開く", "uncompressedCommentBox();", cocDd);
	
	var cucDd = document.createElementNS(xhtmlns, "dd");
	dl.appendChild(cucDd);
	createButton("圧縮", "compressCommentBox();", cucDd);
	createButton("展開", "uncompressCommentBox();", cucDd);
}

function createButton(name, script, node) {
	var button = document.createElementNS(xhtmlns, "input");
	button.setAttribute("type", "button");
	button.setAttribute("value", name);
	button.setAttribute("onclick", script);
	node.appendChild(button);
}