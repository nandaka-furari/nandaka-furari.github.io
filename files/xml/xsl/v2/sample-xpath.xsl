<?xml version="1.1" encoding="UTF-8"?>
<?xml-stylesheet type="text/css" href="../../../css/ns/xslt.css"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="hoge">test</xsl:param>

	<xsl:variable name="fuga" select="document('../../xframes/layout.xframes.xml')"/>

	<xsl:template match="/">
		<xsl:message>test</xsl:message>
	</xsl:template>

	<xsl:template match="*">
		&lt;<xsl:value-of select="name()"/>&gt;
		<xsl:for-each select="@*">
			<xsl:if test="not(name() = 'href')">
			<xsl:variable name="name" select="name()"></xsl:variable>
			<xsl:value-of select="name()"/>
		 	<xsl:text>="</xsl:text>
		 	<xsl:value-of select="current()"/>
		 	<xsl:text>" </xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:choose>
          <xsl:when test="@href">
            <a href="">
				<xsl:apply-templates></xsl:apply-templates>
			</a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates></xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
		
		<xsl:apply-templates select="@*"  mode="att"></xsl:apply-templates>
		<xsl:apply-templates></xsl:apply-templates>
		&lt;/<xsl:value-of select="name()"/>&gt;
	</xsl:template>
</xsl:stylesheet>
