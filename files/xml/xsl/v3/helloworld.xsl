<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="urn:function" version="3.0">
	<xsl:output />
	<xsl:template match="/">
		<xsl:value-of select=""/>
	</xsl:template>
	<xsl:function name="f:helloworld">
	</xsl:function>
</xsl:stylesheet>