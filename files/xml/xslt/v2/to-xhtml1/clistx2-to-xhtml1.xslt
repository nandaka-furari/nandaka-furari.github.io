<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:x="http://www.w3.org/1999/xhtml"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://bbwtest.dip.jp/schema/2009/gottaniLocal/"
        version="2.0">
    <xsl:template match="/">
        <!-- TODO: Auto-generated template -->
    </xsl:template>
    <!-- standard copy template -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="c:containerList">
        <table>
            <caption>記事一覧表</caption>
            <summary></summary>
            <colgroup>
                <col/>
                <col class="title"/>
                <xsl:if test="@author">
                    <col/>
                </xsl:if>
                <xsl:if test="@category">
                    <col/>
                </xsl:if>
                <col class="datetime"/>
                <col/>
                <col/>
                <col class="datetime"/>
            </colgroup>
            <thead>
                <tr>
                    <th>順</th>
                    <th>タイトル</th>
                    <xsl:if test="@author">
                        <th>作者</th>
                    </xsl:if>
                    <xsl:if test="@category">
                        <th>カテゴリ</th>
                    </xsl:if>
                    <th>記事日時</th>
                    <th>B</th>
                    <th>C</th>
                    <th>最終更新</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="c:article">
                    <tr>
                        <td>
                            <xsl:value-of select="@title"></xsl:value-of>
                        </td>
                        <td>
                            <xsl:value-of select="c:author/@name"></xsl:value-of>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>