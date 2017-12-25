<?xml version="1.0" encoding="UTF-8"?>
<!--  -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/xhtml"
        exclude-result-prefixes="xsl"
        version="2.0">

    <!--  -->
    <xsl:template name="line.type.temp">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}">
                    <xsl:if test="@hreflang">
                        <xsl:attribute name="hreflang">
                            <xsl:value-of select="@hreflang"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@hreftype">
                        <xsl:attribute name="type">
                            <xsl:value-of select="@hreftype"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="common.attr.temp"/>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  -->
    <xsl:template name="common.attr.temp">
        <xsl:if test="@title">
            <xsl:attribute name="title">
                <xsl:value-of select="@title"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@xml:base">
            <xsl:attribute name="xml:base">
                <xsl:value-of select="@xml:base"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="@xml:lang"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- standard copy template -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>