<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/2002/06/xhtml2/"
        xmlns:c="http://www.bbwtest.info/schema/2011/container2/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        xmlns:mml="http://www.w3.org/1998/Math/MathML"
        version="2.0">
    <xsl:output
            version="1.0"
            encoding="UTF-8"
            method="xml"/>

    <xsl:include href="structure3.0_xhtml2.0.xslt"/>

    <!-- ルートに対して -->
    <xsl:template match="/">
        <!-- http://www.w3.org/2002/06/xhtml2/ -->
        <!-- http://www.w3.org/1999/xhtml -->
        <!-- http://www.w3.org/MarkUp/SCHEMA/xhtml2.xsd -->
        <html version="-//W3C//DTD XHTML 2.0//EN"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://www.w3.org/2002/06/xhtml2/ http://www.w3.org/MarkUp/SCHEMA/xhtml2.xsd">
            <head>
                <title>
                    <xsl:value-of select="c:container/c:article/@title"/>
                </title>
                <xsl:copy-of select="document('/service/comp/meta.xml')/*"></xsl:copy-of>
            </head>
            <body>
                <section id="main-component">
                    <xsl:copy-of select="document('/service/comp/header.xml')"></xsl:copy-of>
                    <h>コンテナ</h>
                    <section id="main">
                        <xsl:apply-templates select="c:container"/>
                    </section>
                    <xsl:copy-of select="document('/service/comp/footer.xml')"></xsl:copy-of>
                </section>
                <section id="sub-component">
                    <xsl:copy-of select="document('/service/comp/sidebar.xml')"></xsl:copy-of>
                </section>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>