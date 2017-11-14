const = require('fs');
var val1 = "val1";
val2 = "val2";

function plus(a,b) {
	return a + b;
}
console.log(plus);
console.log(plus.prototype);
var minus = function(a,b) {
	return a - b;
}
console.log(minus);
plus.prop1 = "functionで定義したオブジェクトのプロパティ";
plus.prop2 = "test";
console.log("functionで定義したオブジェクトのプロパティ");
console.log(plus.prop2);

function callAlert() {
	alert('アラートの呼び出し');
}
function callAlertWith(param) {
	alert(param);
}
var produce = function(a,b) {

};
console.log(produce);
var div = function() {
	
};
var obj = new Object();
console.log(obj.prototype);

var jsonObj = {

};

console.log(jsonObj.prototype);

function t(i) {
	console.log(i);
	if(i === 't') {
		return null;
	}
	return t('t');
}
console.log(t('a'));

function request() {
	
}

var next = function(c,n) {
	console.log(typeof c);
	if(typeof c !== 'function' | typeof n !== 'function') {
		console.log(typeof c);
		console.log(typeof n);
		throw "not function";
	}
	if(c === null && n === null) {
		return 1;
	} else if(n === null) {
		return c();
	} else if(c === null) {
		return n();
	} else {
		return c() * n();
	}
	return next(c,n);
};
try {
	console.log(next(plus,null));
	console.log(next(plus,null));
	console.log(next(plus,minus));
} catch(e) {
	console.log(e);
}