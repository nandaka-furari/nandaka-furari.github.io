<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns="http://www.w3.org/1999/xhtml"
        exclude-result-prefixes="c xsl"
        version="2.0">

    <xsl:output method="xhtml" omit-xml-declaration="yes"/>

    <xsl:include href="content3.1.xslt"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="/c:p">
        <div class="paragraph" id="c-{@number}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="/c:l">
        <div class="line" id="c-{@number}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

</xsl:stylesheet>