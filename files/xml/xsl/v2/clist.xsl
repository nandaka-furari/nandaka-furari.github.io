<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:x="http://www.w3.org/1999/xhtml"
        xmlns:c="http://bbwtest.dip.jp/schema/2009/container2/"
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
            <colgroup>
                <col/>
                <col class="title"/>
                <xsl:if test="@author">
                </xsl:if>
                <col class="datetime"/>
                <col/>
                <col/>
                <col class="datetime"/>
            </colgroup>
            <tr>
                <th>順</th>
                <th>タイトル</th>
                <c:if test="${author ne null and author}">
                    <th>作者</th>
                </c:if>
                <c:if test="${category ne null and category}">
                    <th>カテゴリ</th>
                </c:if>
                <th>記事日時</th>
                <th>B</th>
                <th>C</th>
                <th>最終更新</th>
            </tr>
        </table>
    </xsl:template>
</xsl:stylesheet>