<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2002/06/xhtml2/">
	<xsl:output method="text" indent="no"/>
	<xsl:param name="hoge"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="id('profile')">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="h">
		<xsl:apply-templates></xsl:apply-templates>
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="@href">
		<xsl:if test="href">
			<xsl:apply-templates mode="href"/>
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="href">
		<xsl:value-of select="href"/>
	</xsl:template>
</xsl:stylesheet>
