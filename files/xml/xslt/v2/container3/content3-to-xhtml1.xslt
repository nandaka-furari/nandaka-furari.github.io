<?xml version="1.0" encoding="UTF-8"?>
<!-- XHTML2.0系の要素をXHTML1.0系の要素に変換するXSLの基本となるXSL。 他のXSLTにインクルードまたはインポートされることを前提としたスタイルシートであり、 ルートに対してのテンプレートが無いのでこれを単独で使用するのは意味が無い。 -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        exclude-result-prefixes="xsl c l"
        version="2.0">
    <xsl:output method="xhtml" omit-xml-declaration="yes"/>
    <xsl:include href="common.xslt"/>

    <xsl:template match="c:div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="c:p">
        <div class="paragraph">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="c:section">
        <div class="section">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="c:h">
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    <xsl:template match="c:seprator">
        <hr/>
    </xsl:template>
    <!-- リンク属性のない要素 -->

    <xsl:template match="c:ul|c:ol|c:dl|c:pre|c:tr">
        <xsl:element name="{name()}">
            <xsl:call-template name="common.attr.temp"></xsl:call-template>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="c:blockquote">
        <blockquote cite="{@cite}" title="{@title}">
            <xsl:apply-templates/>
            <xsl:if test="@cite">
                <p>
                    <cite>
                        <a href="{@cite}">
                            <xsl:choose>
                                <xsl:when test="@title">
                                    <xsl:value-of select="@title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@cite"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </cite>
                </p>
            </xsl:if>
        </blockquote>
    </xsl:template>

    <xsl:template match="c:di">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="c:table">
        <table summary="{c:summary}">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    <xsl:template match="c:summary"/>

    <!-- ラインタイプ要素 -->
    <xsl:template match="c:l">
        <div class="line">
            <xsl:call-template name="line.type.temp"/>
        </div>
    </xsl:template>

    <xsl:template match="c:h|c:td|c:th|c:label|c:li|c:dt|c:dd|c:caption">
        <xsl:element name="{name()}">
            <xsl:call-template name="line.type.temp"/>
        </xsl:element>
    </xsl:template>

    <!-- インラインタイプ要素 -->
    <!-- 2011-09-23 マッチするパターンの中でdfn要素が抜けていたのでこれを追加した -->
    <xsl:template match="c:dfn|c:span|c:abbr|c:strong|c:em|c:q|c:cite|c:code|c:var|c:samp|c:kbd">
        <xsl:element name="{name()}">
            <xsl:call-template name="line.type.temp"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="c:a">
        <a href="{@href}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>

    <xsl:template match="c:blockcode">
        <ol class="blockcode">
            <xsl:for-each select="c:l">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ol>
    </xsl:template>
</xsl:stylesheet>
