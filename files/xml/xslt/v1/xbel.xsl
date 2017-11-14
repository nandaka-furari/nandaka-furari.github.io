<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xb="http://www.python.org/topics/xml/xbel/"
	xmlns="http://www.w3.org/1999/xhtml"
	version="1.0">
	<xsl:param name="comx" select="/processing-instruction('comx')"/>
   <!-- xsd:schema -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="xb:xbel">
		<html>
			<head>
				<title>bookmark</title>
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			</head>
			<body class="container">
				<xsl:choose>
					<xsl:when test="$comx">
						<div class="row">
							<div class="col-md-4">
								<xsl:apply-templates select="xb:root" mode="comx"/>
							</div>
							<div class="col-md-8">
								<xsl:for-each select="xb:bookmarks/xb:*">
									<div><xsl:value-of select="@uri"/></div>
								</xsl:for-each>
							</div>
						</div>
					</xsl:when>
					<xsl:otherwise><xsl:apply-templates mode="export"/></xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="xb:root" mode="comx">
		<xsl:apply-templates mode="comx"/>
	</xsl:template>
	
	<xsl:template match="xb:folder" mode="comx">
		<div>
			<div><xsl:value-of select="@name"/></div>
			<xsl:apply-templates mode="comx"/>
		</div>
	</xsl:template>
	
	<xsl:template match="xb:root" mode="export">
		<dl>          
			<dt><xsl:apply-templates/></dt>
		</dl>
	</xsl:template>
	
	<xsl:template match="xb:folder" mode="export">
		<h3><xsl:value-of select="@name"/></h3>
		<dl>
			<dt><xsl:apply-templates/></dt>
		</dl>
	</xsl:template>
	
	<xsl:template match="xb:ref" mode="export">
		<a href="{text()}"><xsl:value-of select="key('bookmarks', text())"/></a>
	</xsl:template>
	
	<xsl:key match="/xb:xbel/xb:bookmarks/xb:bookmark" name="bookmarks" use="@uri"/>
	
	<xsl:template match="xb:bookmarks" mode="export"></xsl:template>
</xsl:stylesheet>
