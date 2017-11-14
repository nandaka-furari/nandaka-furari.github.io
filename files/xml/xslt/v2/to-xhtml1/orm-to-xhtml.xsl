<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:orm="http://xmlns.jcp.org/xml/ns/persistence/orm"
    exclude-result-prefixes="xs orm"
    version="2.0">

    <xsl:template match="orm:entity-mappings">
    	<h1></h1>
    	<p></p>
    	<div class="container entity-mappings">
    		<div class="header"></div>
    		<div class="article main">
    			<xsl:apply-templates></xsl:apply-templates>
    		</div>
    		<div class="aside">
    			<xsl:apply-templates select="orm:entity"></xsl:apply-templates>
    		</div>
    		<div class="footer"></div>
    	</div>
    	<div>
    		<address>http://dream-netsystems.com/</address>
    	</div>
    </xsl:template>
    
    <xsl:template match="orm:persistence-unit-metadata">
    	<h2>メタデータ:</h2>
    	<xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="orm:entity">
    	<h2>クラス:<xsl:value-of select="@class"></xsl:value-of></h2>
    	<xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="orm:table">
    	<xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="orm:description">
    	<xsl:value-of select="."></xsl:value-of>
    </xsl:template>
</xsl:stylesheet>