<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        xmlns:mml="http://www.w3.org/1998/Math/MathML"
        exclude-result-prefixes="xsl c l"
        version="2.0">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:include href="structure3.0_xhtml2.0.xslt"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="c:*" name="remake">
        <xsl:element name="{name()}">
            <xsl:for-each select="@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="mml:*">
        <xsl:copy></xsl:copy>
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>