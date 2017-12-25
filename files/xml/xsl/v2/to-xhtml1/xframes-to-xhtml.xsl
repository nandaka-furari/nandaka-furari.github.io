<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="http://www.w3.org/2002/06/xframes/" xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:template match="/">
		<html>
		<xsl:apply-templates select="xf:frames/xf:head"></xsl:apply-templates>
		<body>
		<xsl:apply-templates select="xf:frames/xf:group" />
		</body>
		</html>
	</xsl:template>
	<xsl:template match="xf:head">
		<head><xsl:apply-templates></xsl:apply-templates></head>
	</xsl:template>
	<xsl:template match="xf:title">
		<xsl:variable name="name" select="name()"></xsl:variable>
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="xf:*">
	
		<xsl:variable name="name" select="name()"></xsl:variable>
		<xsl:value-of select="$name"/>
		<xsl:element name="{$name}">
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:value-of select="$name"/>
	</xsl:template>
	
	<xsl:template match="xf:group">
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="xf:frame">
		<xsl:value-of select="."/>
	</xsl:template>
</xsl:stylesheet>
