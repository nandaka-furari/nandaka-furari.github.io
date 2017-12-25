<?xml version="1.0" encoding="UTF-8"?>
<!-- XHTML2.0系の要素をXHTML1.0系の要素に変換するXSLの基本となるXSL。 他のXSLTにインクルードまたはインポートされることを前提としたスタイルシートであり、 ルートに対してのテンプレートが無いのでこれを単独で使用するのは意味が無い。 -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/2002/06/xhtml2/"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        version="2.0">

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
