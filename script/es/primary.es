var head = document.getElementsByTagName("head").item(0);
var non_style = null;
var sum_style = null;
var target = null;
var commentList = null;
var head_has_sum = true;

function createNoneStyle() {
	var style = document.createElement("style");
	var css = ".commentContent {display:none}" +
			" .commentFoot {display:none}" +
			" .summary {background-color:white; font-size:small; padding: 0.25em 1em;}";
	style.appendChild(document.createTextNode(css));
	return style;
}

function createSummaryStyle() {
	var style = document.createElement("style");
	style.appendChild(document.createTextNode(".summary {display:none}"));
	return style;
}



//全てのコメントを圧縮する
function compressAll() {
	try {
		if (head_has_sum) {
			head.removeChild(sum_style);
			head_has_sum = false;
		}
		head.appendChild(none_style);
	} catch (e) {
		alert(e);
	}
}

//全てのコメントを展開する
function uncompressAll() {
	try {
		head.removeChild(none_style);
		head.appendChild(sum_style);
		head_has_sum = true;
	} catch (e) {
		alert(e);
	}
}
//
function uncompressComment(chead) {
	try {
		if (target != null) {
			var tc = target.parentNode;
			var tcsummary = target.getElementsByTagName("div").item(0);
			tcsummary.removeAttribute("style");
			var tcbody;
			var tcfoot;
			for ( var int = 0, i = 0; int < tc.childNodes.length || i < 3; int++) {
				if (tc.childNodes.item(int).nodeType == Node.ELEMENT_NODE) {
					if (i == 1) {
						tcbody = tc.childNodes.item(int);
					} else if (i == 2) {
						tcfoot = tc.childNodes.item(int);
					}
					i++;
				}
			}
			tcbody.removeAttribute("style");
			tcfoot.removeAttribute("style");
		}
		var summary = chead.getElementsByTagName("div").item(0);
		summary.setAttribute("style", "display:none");
		var com = chead.parentNode;
		var cbody;
		var cfoot;
		for ( var int = 0, i = 0; int < com.childNodes.length || i < 3; int++) {
			if (com.childNodes.item(int).nodeType == Node.ELEMENT_NODE) {
				if (i == 1) {
					cbody = com.childNodes.item(int);
				} else if (i == 2) {
					cfoot = com.childNodes.item(int);
				}
				i++;
			}
		}
		cbody.setAttribute("style", "display:block");
		cfoot.setAttribute("style", "display:block");
		target = chead;
	} catch (e) {
		alert(e);
	}
}

function firstm() {
	try {
		compressAll();
	} catch (e) {
		alert(e);
	}
}

function extractText(targetnode) {
	try {
		var str = "";
		var nodes = targetnode.childNodes;
		for ( var int = 0; int < nodes.length; int++) {
			if (nodes.item(int).nodeType == Node.TEXT_NODE) {
				str = str + nodes.item(int).data;
			} else if (nodes.item(int).nodeType == Node.ELEMENT_NODE) {
				str = str + extractText(nodes.item(int));
			}
		}
		return str;
	} catch (e) {
		alert(e);
		return null;
	}
}

function setup(body) {
	try {
		commentList = createCommentList();
		none_style = createNoneStyle();
		sum_style = createSummaryStyle();
		head.appendChild(sum_style);
		head_has_sum = true;
	} catch (e) {
		alert(e);
	}
}
function createCommentList() {
	try {
		var divlist = document.getElementsByTagName("div");
		var list = new Array();
		var j = 0;
		for (var int = 0; int < divlist.length; int++) {
			div = divlist.item(int);
			if (div.hasAttributes()) {
				classAttr = div.attributes.getNamedItem("class");
				if (classAttr != null && classAttr.nodeValue == "comment") {
					list[j++] = div;
					var cc = div.getElementsByTagName("div");
					var chead = cc.item(0);
					var cbody = cc.item(1);
					var summary = document.createElement("div");
					summary.setAttribute("class", "summary");
					
					var caption = document.createElement("div");
					caption.setAttribute("class", "summary_caption");
					var tmpstr = extractText(cbody);
					caption.appendChild(document.createTextNode("[" + tmpstr.length + "] "));
					caption.appendChild(document.createTextNode(tmpstr.substring(0, 20)));
					summary.appendChild(caption);
					chead.appendChild(summary);
				}
			}
		}
		return list;
	} catch (e) {
		alert(e);
		return null;
	}
}
