<?xml version="1.0" encoding="UTF-8"?>
<!-- XHTML2.0系の要素をXHTML1.0系の要素に変換するXSLの基本となるXSL。 他のXSLTにインクルードまたはインポートされることを前提としたスタイルシートであり、 ルートに対してのテンプレートが無いのでこれを単独で使用するのは意味が無い。 -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:x="http://www.w3.org/1999/xhtml"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        exclude-result-prefixes="xsl c l x"
        version="2.0">
    <xsl:output method="xhtml" omit-xml-declaration="yes"/>

    <xsl:template match="c:*">
        <xsl:element name="{name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"></xsl:apply-templates>
            <xsl:apply-templates></xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
