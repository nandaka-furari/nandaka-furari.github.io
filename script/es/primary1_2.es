/*
 * 
 */

/**
 * 対象にしているコメント
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
var commentBox;
/**
 * @type Boolean
 */
var compressed = true;

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

function compressArticle() {
	
}

function uncompressArticle() {
	
}

function compressCommentBox() {
	
}

function uncompressCommentBox() {
	
}

/**
 * <p>全てのコメントを圧縮する</p>
 */
function compressAllComments() {
	var comments = commentBox.childNodes;
	for ( var int = 0; int < comments.length; int++) {
		var node = comments.item(int);
		if (node.nodeType == Node.ELEMENT_NODE && node.hasAttribute("class") && node.getAttribute("class") == "comment") {
			compressComment(node, true);
		}
	}
}

// 全てのコメントを展開する
function uncompressAllComments() {
	var comments = commentBox.childNodes;
	for ( var int = 0; int < comments.length; int++) {
		var node = comments.item(int);
		if (node.nodeType == Node.ELEMENT_NODE && node.hasAttribute("class") && node.getAttribute("class") == "comment") {
			uncompressComment(node);
		}
	}
}

/**
 * @param {Element} comment
 * @param {Boolean} compressChildNodes 
 */
function compressComment(comment, compressChildNodes) {
	//要素の追加や削除はfor文の中では行わないようにしなければならない
	var head;
	var content;
	var foot;
	for ( var int = 0; int < comment.childNodes.length; int++) {
		var commentChildNode = comment.childNodes.item(int);
		if (commentChildNode.nodeType == Node.ELEMENT_NODE) {
			var classAttr = commentChildNode.getAttribute("class");
			
			if (classAttr == "head") {
				//
				head = commentChildNode;
			} else if (classAttr == "content") {
				//
				content = commentChildNode;
			} else if (classAttr == "foot") {
				//
				foot = commentChildNode;
				if (!compressChildNodes) {
					break;
				}
			} else if (classAttr == "comment") {
				//
				compressComment(commentChildNode, compressChildNodes);
			}
		}
	}
	
	//
	
	/*
	 * <div class="summary">
	 * 	<div class="summaryInfo"></div>
	 * </div>
	 * */
	if (!comment.hasAttribute("compressed") || (comment.hasAttribute("compressed") && comment.getAttribute("compressed") == "false")) {
		var styleAttr = document.createAttribute("style");
		styleAttr.nodeValue = "display: none;";
		content.attributes.setNamedItem(styleAttr);
		
		var summary = document.createElementNS(xhtmlns, "div");
		summary.setAttribute("class", "summary");
		extractedText = extractText(content);
		
		var summaryInfo = document.createElementNS(xhtmlns, "div");
		summaryInfo.setAttribute("class", "summaryInfo");
		var label = document.createElementNS(xhtmlns, "span");
		label.setAttribute("class", "term");
		label.appendChild(document.createTextNode("文字数"));
		summaryInfo.appendChild(label);
		var value = document.createElementNS(xhtmlns, "span");
		value.setAttribute("class", "number");
		value.appendChild(document.createTextNode(extractedText.length));
		summaryInfo.appendChild(value);
		summary.appendChild(summaryInfo);
		
		var scontent = document.createElementNS(xhtmlns, "div");
		scontent.setAttribute("class", "text");
		scontent.appendChild(document.createTextNode(extractedText.substring(0, 20)));
		summary.appendChild(scontent);
		
		comment.insertBefore(summary, content);
		
		//
		var styleAttr = document.createAttribute("style");
		styleAttr.nodeValue = "display: none;";
		foot.attributes.setNamedItem(styleAttr);
	}
	comment.setAttribute("compressed", "true");
}

/**
 * <p>コメントを展開する。</p>
 * @param {Element} comment
 * @param {Boolean} uncompressChildNodes
 */
function uncompressComment(comment, uncompressChildNodes) {
	if (!comment.hasAttribute("compressed") ) {
		
	}
	comment.setAttribute("compressed", "false");

	//要素の追加や削除はfor文の中では行わないようにしなければならない
	var summary;
	for ( var int = 0; int < comment.childNodes.length; int++) {
		var commentChildNode = comment.childNodes.item(int);
		if (commentChildNode.nodeType == Node.ELEMENT_NODE && commentChildNode.hasAttribute("class")) {
			var classAttr = commentChildNode.getAttribute("class");
			if (classAttr == "head") {
				if (commentChildNode.hasAttribute("style")) {
					commentChildNode.removeAttribute("style");
				}
			} else if (classAttr == "content") {
				if (commentChildNode.hasAttribute("style")) {
					commentChildNode.removeAttribute("style");
				}
			} else if (classAttr == "foot") {
				if (commentChildNode.hasAttribute("style")) {
					commentChildNode.removeAttribute("style");
				}
				if (!uncompressChildNodes) {
					break;
				}
			} else if (classAttr == "summary") {
				summary = commentChildNode;
			} else if (classAttr == "comment") {
				//
				uncompressComment(commentChildNode, uncompressChildNodes);
			}
		}
	}
	if (summary != undefined) {
		comment.removeChild(summary);
	}
}

/**
 * @param {Element} comment
 */
function compunc(comment) {
	if (!comment.hasAttribute("compressed") || (comment.getAttribute("compressed") == "false")) {
		compressComment(comment, false);
	} else if (comment.getAttribute("compressed") == "true") {
		uncompressComment(comment, false);
	}
}
/**
 * @param {Element} comment
 */
function compuncAll(comment) {
	if (!comment.hasAttribute("compressed") || (comment.getAttribute("compressed") == "false")) {
		compressComment(comment, true);
	} else if (comment.getAttribute("compressed") == "true") {
		uncompressComment(comment, true);
	}
}

/**
 * @param {Node} targetNode
 * @returns {String}
 */
function extractText(targetNode) {
	var str = "";
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
 * @param {Element} body
 */
function setup(body) {
	commentBox = getCommentBox()
	var uim = document.getElementById("uimanager");
	var compressAllButton = document.createElementNS(xhtmlns, "input");
	compressAllButton.setAttribute("type", "button");
	compressAllButton.setAttribute("value", "圧縮");
	compressAllButton.setAttribute("onclick", "compressAllComments()");
	uim.appendChild(compressAllButton);
	var uncompressAllButton = document.createElementNS(xhtmlns, "input");
	uncompressAllButton.setAttribute("type", "button");
	uncompressAllButton.setAttribute("value", "展開");
	uncompressAllButton.setAttribute("onclick", "uncompressAllComments()");
	uim.appendChild(uncompressAllButton);
}