<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- 	<xsl:param name="filename" as="source"></xsl:param>
        <xsl:variable name="source" select="document($source)"></xsl:variable>
        <xsl:variable name="template" select="document('source/template.xhtml', /)"></xsl:variable>
     -->
    <xsl:template match="/">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="title">

    </xsl:template>
</xsl:stylesheet>