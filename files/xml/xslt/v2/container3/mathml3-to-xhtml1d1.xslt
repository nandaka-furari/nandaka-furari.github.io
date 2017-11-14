<?xml version="1.0" encoding="UTF-8"?>
<!-- mathml -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:mml="http://www.w3.org/1998/Math/MathML"
        version="2.0">

    <xsl:template match="mml:math">
        <math xmlns="http://www.w3.org/1998/Math/MathML">
            <xsl:apply-templates/>
        </math>
    </xsl:template>

    <xsl:template match="mml:*">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
