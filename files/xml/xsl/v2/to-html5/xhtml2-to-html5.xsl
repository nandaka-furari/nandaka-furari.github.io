<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xh2="http://www.w3.org/2002/06/xhtml2/" version="2.0">
	<xsl:output encoding="UTF-8" indent="yes" media-type="text/html" method="html" doctype-system=""/>
	
	<xsl:template match="xh2:h">
		<xsl:choose>
			<xsl:when test="@importance=6">
				<h1>
					<xsl:apply-templates></xsl:apply-templates>
				</h1>
			</xsl:when>
		</xsl:choose>		
	</xsl:template>
	
	<xsl:template match="xh2:p">
		<div class="paragraph">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="id('profile')">
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="xh2:di">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xh2:html">
		<html>
		<xsl:apply-templates></xsl:apply-templates>
		</html>
	</xsl:template>
	
	<xsl:template match="xh2:h">
		<xsl:choose>
			<xsl:when test="@importance = 6">
				<h1><xsl:apply-templates/></h1>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="xh2:l">
		<p class="line">
			<xsl:for-each select="@*">
				<xsl:if test="not(name() = 'href')">
					<xsl:attribute name="{name()}">
						<xsl:value-of select="."></xsl:value-of>
					</xsl:attribute>
				</xsl:if>
			</xsl:for-each>
			<xsl:apply-templates />
		</p>
	</xsl:template>
	
	<xsl:template match="xh2:di">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xh2:*">
		<xsl:element name="{name()}" namespace="http://www.w3.org/1999/xhtml">
			<xsl:for-each select="@*">
				<xsl:if test="not(name() = 'href')">
					<xsl:attribute name="{name()}">
						<xsl:value-of select="."></xsl:value-of>
					</xsl:attribute>
				</xsl:if>
			</xsl:for-each>
			<xsl:choose>
				<xsl:when test="@href">
					<a href="{@href}">
						<xsl:apply-templates></xsl:apply-templates>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates></xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>