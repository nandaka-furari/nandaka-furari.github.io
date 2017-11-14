function readcsv() {
    console.log(d3.select("p"));
    var svg = d3.select("#tweet-activity").append("svg");
    console.log(svg);
    svg.attr("width",500).attr("height",50);
    d3.csv("../../../../../csv/twitter-activity/tweet_activity_metrics_nandaka_furari_20160701_20160901_ja.csv", function(data) {
    	svg.selectAll("rect")
    		.data(data)
    		.enter()
    		.append("rect")
    		.attr("fill", "black")
    		.attr("x",function(d,i) {
    			return i * 21;
    		})
    		.attr("y", 0)
    		.attr("width",20)
    		.attr("height", function(d) {
    		console.log(d);
    			return d['インプレッション'];
    		});
    });
    };