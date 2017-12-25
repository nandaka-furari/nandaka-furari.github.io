<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:nf="https://nandaka-furari.github.io/">
    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:value-of select="nf:helloworld()"/>
    </xsl:template>
    <xsl:function name="nf:helloworld" as="xs:string">
        <xsl:text>Hello World</xsl:text>
    </xsl:function>
</xsl:stylesheet>