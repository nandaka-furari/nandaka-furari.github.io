use strict;
/*
 * 1.4:2010-09
 * 1.5:2011-10-07
 * 新設計のXHTML構造に対応したスクリプト
 * container-managerからcontainer-controllerへ名前を変更
 * コンテナの大枠の構成
 *	div.container
 *		div.article
 *			dl.head
 *			ul.pages
 *				li.page
 *					dl.head
 *					div.content
 *			ul.foot
 *		div.commentBox
 *			dl.head
 *			ul.childComments
 *				li.comment
 *			ul.foot
 *
 * コメントの構成
 * li#{number}.comment
 *	dl.head
 *		dt
 *			$参照
 *		dd.number
 *		dt
 *			$関係
 *		dd
 *		dt
 *			$番号
 *		dd.number
 *		dt
 *			$日時
 *		dd.datetime
 *		dt
 *			$名前
 *		dd.authorName
 *		dt
 *			$状態
 *		dd
 *	ul.comment-controller
 * 	div."content paragraph"
 * 	ul.foot
 * 	ul.childComments
 */
/**
 * @type HTMLDocument
 */
var doc = document;
/**
 * @type String
 */
var xhtmlns = doc.documentElement.namespaceURI;
/**
 * @type Element
 */
var article;
/**
 * @type Element
 */
var commentBox;
/**
 * コメントのコンテントをコメント番号をキーに収めるマップ
 */
var contentMap = new Object();
/**
 * コメントの圧縮テキストをコメント番号をキーに収めるマップ
 */
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

/**
 * @param {Element}
 *            childComments
 * @param {Boolean}
 *            openChildNodes
 */
function openChildComments(childComments) {
	var childCommentList = childComments.childNodes;
	for ( var int = 0; int < childCommentList.length; int++) {
		if (childCommentList.item(int).nodeType == Node.ELEMENT_NODE) {
			openComment(childCommentList.item(int), true);
		}
	}
}

/**
 * @param {Element}
 *            childComments
 * @param {Boolean}
 *            closeChildNodes
 */
function closeChildComments(childComments) {
	var childCommentList = childComments.childNodes;
	for ( var int = 0; int < childCommentList.length; int++) {
		if (childCommentList.item(int).nodeType == Node.ELEMENT_NODE) {
			closeComment(childCommentList.item(int), true);
		}
	}
}

/**
 * @param {Element}
 *            childComments
 * @param {Boolean}
 *            compressChildNodes
 */
function compressChildComments(childComments) {
	var childCommentList = childComments.childNodes;
	for ( var int = 0; int < childCommentList.length; int++) {
		if (childCommentList.item(int).nodeType == Node.ELEMENT_NODE) {
			compressComment(childCommentList.item(int), true);
		}
	}
}

/**
 * @param {Element}
 *            childComments ul.childComments
 * @param {Boolean}
 *            compressChildNodes
 */
function uncompressChildComments(childComments) {
	var childCommentList = childComments.childNodes;
	for ( var int = 0; int < childCommentList.length; int++) {
		if (childCommentList.item(int).nodeType == Node.ELEMENT_NODE) {
			uncompressComment(childCommentList.item(int), true);
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
			compressChildComments(node);
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
			uncompressChildComments(node);
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
	for ( var int = 0; int < comment.childNodes.length; int++) {

		if (comment.childNodes.item(int).nodeType == Node.ELEMENT_NODE) {
			/**
			 * @type {Element}
			 */
			var node = comment.childNodes.item(int);
			var classAttrName = getAttrValue(node, "class");
			if (classAttrName == "head") {

			} else if (classAttrName == "childComments") {
				node.attributes.removeNamedItem("style");
				comment.removeAttribute("style");
				if (openChildNodes) {
					openChildComments(node);
				}
			}
		}
	}
}

/**
 * @param {Element}
 *            comment
 * @param {Boolean}
 *            closeChildNodes
 */
function closeComment(comment, closeChildNodes) {
	for ( var int = 0; int < comment.childNodes.length; int++) {
		
		if (comment.childNodes.item(int).nodeType == Node.ELEMENT_NODE) {
			/**
			 * @type {Element}
			 */
			var node = comment.childNodes.item(int);
			var classAttrName = getAttrValue(node, "class");
			if (classAttrName == "head") {
				
			} else if (classAttrName == "childComments") {
				var styleAttr = doc.createAttribute("style");
				styleAttr.nodeValue = "display: none";
				node.attributes.setNamedItem(styleAttr);
				var s = doc.createAttribute("style");
				s.nodeValue = "outline: solid 3px red";
				comment.setAttributeNode(s);
				if (closeChildNodes) {
					closeChildComments(node);
				}
			}
		}
	}
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
	 */
	var number = getNumber(comment);
	for ( var int = 0; int < comment.childNodes.length; int++) {
		var commentChildNode = comment.childNodes.item(int);
		
		if (commentChildNode.nodeType == Node.ELEMENT_NODE) {
			var classAttrName = getAttrValue(commentChildNode, "class");
			if (classAttrName == "head") {
				//
				var head = commentChildNode;
				var image;
				for (var int2 = 0; int2 < head.childNodes.length; int2++) {
					var item = head.childNodes.item(int2);
					if (item.nodeName == "dt" && item.nodeValue == "展開／圧縮") {
						item.nextSibling.firstChild;
					}
				}
			} else if (classAttrName.search("content") != -1) {// contentを含んでいるなら
				//
				var content = commentChildNode;
				if (!contentMap[number]) {
					contentMap[number] = content;
				}
				/*
				 * <p class="compressed-text">{compressedText}</p>
				 */
				var compressedText;
				if (compedTextMap[number]) {
					compressedText = compedTextMap[number];
				} else {
					compressedText = document.createElementNS(xhtmlns, "p");
					compressedText.setAttribute("class", "compressed-text");
					var compressedTextString = compressText(content, 40);
					compressedText.appendChild(document.createTextNode(compressedTextString));
					compedTextMap[number] = compressedText;
				}
				comment.replaceChild(compressedText, content);
			} else if (classAttrName == "foot") {
				//
				var styleAttr = document.createAttribute("style");
				styleAttr.nodeValue = "display: none;";
				commentChildNode.attributes.setNamedItem(styleAttr);
			} else if (classAttrName == "childComments" && compressChildNodes) {
				//
				compressChildComments(commentChildNode);
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
			var classAttrName = getAttrValue(commentChildNode, "class");
			if (classAttrName == "head") {
				head = commentChildNode;
				
			} else if (classAttrName == "compressed-text") {
				comment.replaceChild(contentMap[number], commentChildNode);
			} else if (classAttrName == "foot") {
				if (commentChildNode.hasAttribute("style")) {
					commentChildNode.removeAttribute("style");
				}
			} else if (classAttrName == "childComments" && uncompressChildNodes) {// dl.chileComments
				//
				uncompressChildComments(commentChildNode);
			}
		}
	}
}

/**
 * <p>閉じているなら開く，そうでなければ閉じる</p>
 * @param {Element}
 *            comment
 */
function clopen(comment) {
	if (closed(comment)) {
		openComment(comment, false);
	} else {
		closeComment(comment, false);
	}
}

/**
 * <p>圧縮されているなら展開，そうでなければ圧縮する</p>
 * @param {Element}
 *            comment
 */
function compunc(comment) {
	if (compressed(comment)) {
		uncompressComment(comment, false);
	} else {
		compressComment(comment, false);
	}
}

/**
 * @param {Element}
 *            comment
 * @returns {Boolean}
 */
function compressed(comment) {
	var childNodes = comment.childNodes;
	for ( var int = 0; int < childNodes.length; int++) {
		var node = childNodes.item(int);
		if (node.nodeType == Node.ELEMENT_NODE) {
			var classAttr = node.getAttribute("class");
			if (classAttr == "compressed-text") {
				return true;
			} else if (classAttr == "content") {
				return false;
			}
		}
	}
}

/**
 * @param {Element}
 *            comment
 * @returns {Boolean}
 */
function closed(comment) {
	var childNodes = comment.childNodes;
	for ( var int = 0; int < childNodes.length; int++) {
		var node = childNodes.item(int);
		if (node.nodeType == Node.ELEMENT_NODE && getClassAttrValue(node) == "childComments" && node.hasAttribute("style")) {
			return true
		}
	}
	return false;
}

/**
 * idから番号を取得する
 * 
 * @param {Element}
 *            comment li.#c{number}.comment
 * @returns {String}
 */
function getNumber(comment) {
	var id = getAttrValue(comment, "id");
	return id.substring(1, id.length);
}
function getComment(number) {
	return document.getElementById("c" + number);
}
/**
 * @param {Node}
 *            targetNode
 * @returns {String} Nodeから抽出した文字列
 */
function extractText(targetNode) {
	var str = new String;
	for ( var int = 0; int < targetNode.childNodes.length; int++) {
		var node = targetNode.childNodes.item(int);
		if (node.nodeType == Node.TEXT_NODE) {
			str = str + node.nodeValue;
		} else {
			str = str + extractText(node);
		}
	}
	return str;
}

/**
 * @param {Node}
 *            targetNode
 * @param {Number} length 
 * @returns {String} Nodeから抽出した文字列
 */
function compressText(targetNode, length) {
	var extractedText = extractText(targetNode);
	return "[" + extractedText.length + "]" + " " + extractedText.substring(0, length);
}

/**
 * @param {Node} node
 * @param {String} attrName
 * 
 * @returns {String}
 */
function getAttrValue(node, attrName) {
	
	if (node.hasAttributes()) {
		var item = node.attributes.getNamedItem(attrName);
		if (item != null) {
			return item.nodeValue;
		}
	}
	return null;
}

/**
 * @param {Node} node
 * @returns {String}
 */
function getClassAttrValue(node) {
	return getAttrValue(node, "class");
}

/**
 * @param {String} name
 * @returns {String}
 * Javascript中級講座
 */
function getCookie(name) {
	var i, cookies, entry;
	cookies = document.cookie.split("; ", 0);
	for ( var int = 0; int < cookies.length; int++) {
		entry = cookies[int].split("=");
		if (entry[0] == name) {
			return decodeURIComponent(entry[1]);
		}
	}
	return null;
}

function setCCCookie(name, value, expires, domain, path, secure) {
	
}

/**
 * @param {Element} cc
 */
function createContainerController(cc) {
	
	var createDt = function(name) {
		var term = doc.createElementNS(xhtmlns, "dt");
		term.appendChild(doc.createTextNode(name));
		dl.appendChild(term);
	}

	var createButton = function (name, script, node) {
		var button = doc.createElementNS(xhtmlns, "input");
		button.setAttribute("type", "button");
		button.setAttribute("value", name);
		button.setAttribute("onclick", script);
		node.appendChild(button);
	}

	var dl = doc.createElementNS(xhtmlns, "dl");
	cc.appendChild(dl);
	
	createDt("記事");
	var coaDd = doc.createElementNS(xhtmlns, "dd");
	dl.appendChild(coaDd);
	createButton("閉じる", "closeArticle();", coaDd);
	createButton("開く", "openArticle();", coaDd);
	
	var cuaDd = doc.createElementNS(xhtmlns, "dd");
	dl.appendChild(cuaDd);
	createButton("圧縮", "compressArticle();", cuaDd);
	createButton("展開", "uncompressArticle();", cuaDd);
	
	createDt("コメントボックス");
	var cocDd = doc.createElementNS(xhtmlns, "dd");
	dl.appendChild(cocDd);
	createButton("閉じる", "closeComment(commentBox, true);", cocDd);
	createButton("開く", "openComment(commentBox, true);", cocDd);
	
	var cddd = doc.createElementNS(xhtmlns, "dd");
	dl.appendChild(cddd);
	createButton("開／閉", "clopen(commentBox);", cddd);
	
	var cucDd = doc.createElementNS(xhtmlns, "dd");
	dl.appendChild(cucDd);
	createButton("圧縮", "compressCommentBox();", cucDd);
	createButton("展開", "uncompressCommentBox();", cucDd);
	
	createDt("Cookie");
	var ckDd = doc.createElementNS(xhtmlns, "dd");
	dl.appendChild(ckDd);
	createButton("圧縮", "compressCommentBox();", ckDd);
	createButton("閉じる", "uncompressCommentBox();", ckDd);

}

/**
 * @param {Element}
 *            body
 */
function setup(body) {
	commentBox = getCommentBox();
	var cc = doc.getElementById("container-controller");
	if (cc != null) {
		createContainerController(cc);
	}
	
	var ccinit = getCookie("cc");
	if (ccinit != null) {
		var tokens = ccinit.split(" ", 0);
		for ( var int = 0; int < tokens.length; int++) {
			if (tokens[int] == "compBox") {
				compressCommentBox();
			} else if (tokens[int] == "closeBox") {
				closeComment(commentBox, true);
			}
		}
	}
}