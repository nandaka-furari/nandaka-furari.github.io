<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pom="http://maven.apache.org/POM/4.0.0"
                version="2.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="descendant::pom:dependencies"/>
    </xsl:template>
    <xsl:template match="pom:dependencies">
        dependencies {
        <xsl:apply-templates/>
        }
    </xsl:template>
    <xsl:template match="pom:dependency">
        <xsl:text>compile </xsl:text>
        <xsl:call-template name="libraryIdentifer"/>
    </xsl:template>
    <xsl:template match="pom:dependency[scope=test]">
        <xsl:text>testCompile </xsl:text>
        <xsl:call-template name="libraryIdentifer"/>
    </xsl:template>
    <xsl:template name="libraryIdentifer">
        <xsl:text>group:'</xsl:text>
        <xsl:text><xsl:value-of select="pom:groupId"/></xsl:text>
        <xsl:text>', name:'</xsl:text>
        <xsl:text><xsl:value-of select="pom:artifactId"/></xsl:text>
        <xsl:text>', version:'</xsl:text>
        <xsl:text><xsl:value-of select="pom:version"/></xsl:text>
        <xsl:text>'</xsl:text>
    </xsl:template>
</xsl:stylesheet>
