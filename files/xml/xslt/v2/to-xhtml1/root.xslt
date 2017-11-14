<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml"
	version="2.0">
	<xsl:include href="xsd-to-xhtml.xslt"/>
	<xsl:include href="xhtml2-to-xhtml1.xsl"/>
	<xsl:include href="orm-to-xhtml.xsl"/>
	<xsl:include href="rdf-to-xhtml.xslt"/>
	<xsl:include href="../to-html5/xhtml2-to-html5.xsl"/>

   <!-- xsd:schema -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
