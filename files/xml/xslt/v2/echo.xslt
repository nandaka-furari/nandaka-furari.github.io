<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xh="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" encoding="UTF-8"></xsl:output>
    <xsl:param name="sourceDir"></xsl:param>

    <xsl:template match="/">
        <echo>
            <xsl:value-of select="document-uri(.)"/>
            <xsl:value-of select="base-uri()"/>
            <xsl:message>test</xsl:message>
        </echo>
    </xsl:template>
</xsl:stylesheet>