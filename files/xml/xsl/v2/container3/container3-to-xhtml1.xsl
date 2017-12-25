<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:c="http://www.bbwtest.info/schema/2011/container2/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        xmlns:mml="http://www.w3.org/1998/Math/MathML"
        version="2.0">
    <xsl:output
            doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN"
            doctype-system="http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd"
            method="xhtml"/>

    <xsl:include href="structure3.0_xhtml1.1.xslt"/>
    <xsl:include href="content3.0.xslt"/>

    <!-- ルートに対して -->
    <xsl:template match="/">
        <html version="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN">
            <head>
                <title>
                    <xsl:value-of select="c:container/c:article/@title"/>
                </title>
                <xsl:copy-of select="document('/service/comp/meta.xml')/*"></xsl:copy-of>
            </head>
            <body>
                <div id="main-component">
                    <xsl:copy-of select="document('/service/comp/header.xml')"></xsl:copy-of>
                    <h1>コンテナ</h1>
                    <div id="main">
                        <xsl:apply-templates select="c:container"/>
                    </div>
                    <xsl:copy-of select="document('/service/comp/footer.xml')"></xsl:copy-of>
                </div>
                <xsl:copy-of select="document('/service/comp/sub-component.xml')"></xsl:copy-of>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>