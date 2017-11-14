<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        exclude-result-prefixes="xsl c l"
        version="2.0">

    <xsl:output method="xml" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:include href="structure3.0_xhtml1.1.xslt"/>
    <xsl:include href="content3.0.xslt"/>
    <xsl:include href="mml.xslt"/>
    <xsl:include href="cruby_xhtmlmod.xslt"/>
</xsl:stylesheet>