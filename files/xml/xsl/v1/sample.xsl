<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:s="urn:sample" xmlns:framexs="urn:framexs">

	<xsl:output method="text" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="hoge"/>
	<xsl:param name="p1" select="."/>
	<xsl:param name="common_loc" select="processing-instruction('common')"/>
	<xsl:variable name="bar" select="/"></xsl:variable>

	<xsl:variable name="fuga">fuga fuaga</xsl:variable>

	<xsl:key match="/s:sample/s:test" name="sample" use="s:name"/>
	
	<xsl:template match="/">

		<xsl:value-of select="system-property('xsl:vendor')"/>
		<xsl:value-of select="$fuga"/>
		[key]<xsl:value-of select="key('sample','name')/s:value"/>

		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	
    <xsl:template match="*[@framexs:*]">
    	name():<xsl:value-of select="name(@framexs:*)"/>
    	<xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
	
	<xsl:template match="*[@framexs:* and starts-with('attr-',local-name(@framexs:*))]">
		attrtemp
    	<xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    

	<xsl:template name="bar">

	</xsl:template>

</xsl:stylesheet>
