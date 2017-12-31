
var sourceLocation;
(function(){
	var hash = new URI(document.location).hash();
	if(hash !== null && hash.length !== 0) {
		sourceLocation = hash.substring(1);
	} else {
		sourceLocation = document.location.pathname;
	}
	console.log(sourceLocation);
})();

var XSLT_NAMESPACE = "http://www.w3.org/1999/XSL/Transform";

var onSaxonLoad;
var vue = {
	el:"#framexs-panel",
	data: {
		version: 0.0,
		sourceLocation: sourceLocation,
		stylesheet: null,
		saxonce_loaded: false
	},
	methods: {
		transform: function(event) {
			console.log(event);
			var xsltElem = jQuery('#root-template stylesheet')[0];
			var importElem = jQuery(document.createElementNS("http://www.w3.org/1999/XSL/Transform","import")).attr("href",this.$stylesheet);
			xsltElem.first().before(importElem);
			console.log(xsltElem);

			Saxon.run({
				stylesheet: xsltElem,
				source: this.$sourceLocation,
				success: function() {
					console.log("testtest");
				}
			});
		},
		load: function(event) {
			console.log(event);
			jQuery.ajax({
				url: this.sourceLocation,
				dataType: "xml",
				type: "GET",
				success: function(response) {
					console.log(response);
					jQuery("#main-panel").empty().append(jQuery(response.documentElement));
				}
			});
		}
	}
}
var framexsPanel

if(jQuery('#saxonce').length > 0) {
	onSaxonLoad = function() {
		console.log("test");
		framexsPanel = new Vue(vue);
		framexsPanel.saxonce_loaded = true;
	};
} else {
	window.addEventListener('load',function(){
		framexsPanel = new Vue(vue);
	},false);
}





function distance(a,b) {
}

function getQunitPanel() {
	return jQuery('#qunit-panel');
}

function qunit_toggle(e) {
	console.log(e);
	jQuery('#qunit-panel').toggle();
}

QUnit.test("test", function() {
	QUnit.ok(1 === 1, "passed");
	//ok(getTarget() !== null, "s");
});
