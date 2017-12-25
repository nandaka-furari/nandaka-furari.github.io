<?xml version="1.0" encoding="UTF-8"?>
<!-- containerのrubyモジュールをXHTML Modに変換する -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        version="2.0">

    <xsl:include href="common.xslt"/>

    <xsl:template match="c:ruby|c:rp">
        <xsl:element name="{name()}">
            <xsl:call-template name="common.attr.temp"></xsl:call-template>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="c:rb|c:rt">
        <xsl:element name="{name()}">
            <xsl:call-template name="line.type.temp"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>