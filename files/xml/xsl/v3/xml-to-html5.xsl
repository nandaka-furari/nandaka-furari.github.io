<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xh2="http://www.w3.org/2002/06/xhtml2/" version="3.0">
	<xsl:output encoding="UTF-8" indent="yes" media-type="text/html" method="html" doctype-system=""/>
	<xsl:variable name="source_xslt" select="document('')"></xsl:variable>
	<xsl:template match="/">
		<html>
			<head>
				<title>変換</title>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<meta name="keywords" content=""/>
				<meta name="description" content=""/>
				<meta property="og:title" content="title" />
				<meta property="og:type" content="article" />
				<meta property="og:decription" content="description"/>
				
				<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.js"></script>
				
				<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
				
				<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.26/vue.js"></script>
				
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/qunit/2.0.1/qunit.css"/>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/qunit/2.0.1/qunit.js"></script>
				
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.css" />
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.css"/>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.js"></script>
				
				<!-- Global site tag (gtag.js) - Google Analytics -->
				<script async="async" src="https://www.googletagmanager.com/gtag/js?id=UA-54947811-5"></script>
				<script>
				  window.dataLayer = window.dataLayer || [];
				  function gtag(){dataLayer.push(arguments);}
				  gtag('js', new Date());
				
				  gtag('config', 'UA-54947811-5');
				</script>
				<style>
			.element &gt; .element:hover, article &gt; .element:hover {box-shadow: 3px 3px gray}
        	article {}
        	.element &gt; .element,article &gt; .element  {border-style: solid; border-color: blue; border-width: 1px 0 0 1px; margin: 10px 0 10px 10px; padding:10px}
        	.attr &gt; .name {color: #E8351E}
        	.attr &gt; .value {color: #1E6BE6}
        	.row {dislpay: table-row}
        	footer &gt; .col {border-style: solid; border-color: aqua; border-width: 1px 0 0 1px; box-shadow: 1px 1px aquq; display: table-cell}
        	.panel-heading {margin:0}
 		</style>
				
				<xsl:for-each select="processing-instruction('css-location')">
					<link rel="stylesheet" href="{.}"/>
				</xsl:for-each>
				
				<xsl:for-each select="processing-instruction('js-location')">
					<script src="{.}">
						<xsl:text/>
					</script>
				</xsl:for-each>
				<xsl:for-each select="processing-instruction('js')">
					<script>
						<xsl:value-of select="."></xsl:value-of>
					</script>
				</xsl:for-each>
			
			</head>
			<body class="container">
				
				<header id="header" class="row">
					<h1 class="col-md-2">変換</h1>
					<section class="col-md-10">
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="640" height="180" stroke="black" fill="rgb(124,150,236)" viewBox="0 0 640 380" style="border: solid 1px black">
								<defs>
									<circle id="black-circle" r="120" fill="rgb(0,0,0)" />
									<rect id="blue-rect" width="300" height="200" fill="blue" />
									<path id="test-path"/>
								</defs>
								<use xlink:href="#black-circle" x="20" y="10"/>
								<use xlink:href="#blue-rect" x="130" y="130"/>
							</svg>
						</div>
						<div>
							<p class="col-sm-10">XSLTで変換した</p>
						</div>
					</section>
					<section class="col"></section>
				</header>
				
				<div class="row">
					<aside class="col-md-4">
						<p>aside</p>
						<button class="btn btn-default" onclick="large(this);">qunit</button>
						<div>
							<div id="qunit"></div>
							<div id="qunit-fixture"></div>
						</div>
					</aside>
					<div class="col-md-8">
						
						<h2 class="row">変換</h2>
						<article>
							<h3>変換対象のXMLの情報</h3>
							<p></p>
							<h3>変換したXML</h3>
							<section>
								<xsl:apply-templates></xsl:apply-templates>
							</section>
						</article>
						<h2 class="row">元</h2>
						<div id="basedoc">
							<xsl:copy-of select="."></xsl:copy-of>
						</div>
					</div>
				</div>
				<footer class="row">
					<div class="col-md-4">
						<div class="panel panel-default">
							<h3 class="panel-heading">XSLT作者の情報</h3>
							<p>ナンダカフラリ</p>
							<ul class="panel-body list-group">
								<li class="list-group-item">
									<a href="https://twitter.com/nandaka_furari">twitter</a>
								</li>
								<li class="list-group-item">
									<a href="https://github.com/nandaka-furari/files">ぎっとはぶ</a>
								</li>
								<li class="list-group-item">
									<a href="https://nandaka-furari.github.io/">website</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-md-4">
						<div class="panel panel-default">
							<h3 class="panel-heading">XSLT</h3>
							<ul class="panel-body">
								<li>
									<a href="https://www.w3.org/TR/xslt20/">XSL Transformations (XSLT) Version 2.0</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-md-4">
						<div class="panel panel-default">
							<h3 class="panel-heading">リンク</h3>
							<ul class="panel-body">
								<li>
									<a href="https://jquery.com/">jQuery</a>
								</li>
								<li>
									<a href="https://cdnjs.com/">cdnjs</a>
								</li>
							</ul>
						</div>
					</div>
				</footer>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="*">
		<div class="element {name()}">
			<p>
				<span class="glyphicon glyphicon-tree-deciduous">
					<xsl:value-of select="name()"></xsl:value-of>
				</span>
				<xsl:if test="@*">
					<xsl:text>&#160;&#160;</xsl:text>
					<span class="glyphicon glyphicon-leaf">
						<xsl:for-each select="@*">
							<span class="attr">
								<span class="name">
									<xsl:value-of select="name()"/>
								</span>
								<xsl:text>=</xsl:text>
								<span class="value">
									<xsl:value-of select="."/>
								</span>
							</span>
							<xsl:text>&#160;</xsl:text>
						</xsl:for-each>
					</span>
				</xsl:if>
			
			</p>
			<xsl:apply-templates></xsl:apply-templates>
		</div>
	</xsl:template>
</xsl:stylesheet>