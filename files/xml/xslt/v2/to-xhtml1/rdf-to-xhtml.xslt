<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
        xmlns="http://www.w3.org/1999/xhtml"
        version="2.0">
    <!-- このXSLTスタイルシートはRSS0.9、1.0に対しても使えるがRDFではないRSS0.9、2.0には使えない。 -->
    <!-- ルートに対して -->
    
    <xsl:template match="rdf:RDF">
        <h2>名前空間情報</h2>
        <p>ルート要素で宣言されている名前空間の一覧表。ルート要素以外で宣言されている名前空間は入らない。</p>
        <table>
            <tr>
                <th>接頭辞</th>
                <th>名前空間</th>
            </tr>
            <xsl:for-each select="namespace::*">
                <tr>
                    <td>
                        <xsl:value-of select="name()"/>
                    </td>
                    <td>
                        <xsl:value-of select="."/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="rdf:Description">
        <h3>解説</h3>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="*[@rdf:about]">
        <div class="section">
            <h2 id="{@rdf:about}">
                <xsl:value-of select="name()"/> :
                <xsl:value-of select="@rdf:about"/>
            </h2>
            <div class="section">
                <table>
                    <tr>
                        <th>プロパティ</th>
                        <th>バリュー</th>
                    </tr>
                    <xsl:for-each select="*">
                        <tr>
                            <td>
                                <xsl:value-of select="name()"/>
                            </td>
                            <td>
                                <xsl:apply-templates/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="rdf:Seq">
        <ol>
            <xsl:apply-templates select="rdf:li"/>
        </ol>
    </xsl:template>
    <xsl:template match="rdf:Bag">
        <ul>
            <xsl:apply-templates select="rdf:li"/>
        </ul>
    </xsl:template>
    <xsl:template match="rdf:Alt">
        <ul>
            <xsl:apply-templates select="rdf:li"/>
        </ul>
    </xsl:template>
    <xsl:template match="rdf:li">
        <li>
            <xsl:apply-templates/>
            <xsl:if test="@rdf:resource">
                <a href="#{@rdf:resource}">
                    <xsl:value-of select="name()"/>
                    :
                    <xsl:value-of select="@rdf:resource"/>
                </a>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="@rdf:resource">
        <a href="#{.}">
            <xsl:value-of select="name()"/> :
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
</xsl:stylesheet>