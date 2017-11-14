<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xmlns="http://www.w3.org/1999/xhtml"
        version="2.0">

    <xsl:variable name="aside">
           <div class="aside" id="sidebar">
            <h2>要素</h2>
            <ul>
                <xsl:for-each select="/xsd:schema/xsd:element">
                    <li>                
                        <a href="#{@name}">
                            <xsl:value-of select="@name"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>

            <h2>タイプ</h2>
            <ul>
                <xsl:for-each select="/xsd:schema/xsd:complexType">
                    <li>
                        <a href="#{@name}">
                            <xsl:value-of select="@name"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>

            <h2>グループ</h2>
            <ul>
                <xsl:for-each select="/xsd:schema/xsd:group">
                    <li>
                        <a href="#{@name}">
                            <xsl:value-of select="@name"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
            <h2>属性</h2>
            <ul>
                <xsl:for-each select="/xsd:schema/xsd:attribute">
                    <li>
                        <a href="#{@name}">
                            <xsl:value-of select="@name"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
            <h2>属性グループ</h2>
            <ul>
                <xsl:for-each select="/xsd:schema/xsd:attributeGroup">
                    <li>
                        <a href="#{@name}">
                            <xsl:value-of select="@name"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:variable>
    <xsl:template match="xsd:schema" mode="list">
    	<ul>
    		<xsl:for-each select=".">
    			<li><xsl:apply-templates/></li>
    		</xsl:for-each>
    	</ul>
    </xsl:template>
    
    <!-- xsd:schema -->
    <xsl:template match="xsd:schema">

        <h1>XSD</h1>
        <div id="main">
            <h2>基本設定</h2>
            <xsl:if test="attribute::*">
                <table style="margin: auto">
                    <caption>属性と値</caption>
                    <xsl:for-each select="attribute::*">
                        <tr>
                            <td>
                                <xsl:value-of select="name()"/>
                            </td>
                            <td>
                                <xsl:value-of select="."/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
        <!-- サイドバー -->

    </xsl:template>

    <xsl:template match="xsd:import">
        <h3>import</h3>
        <dl>
            <dt>schemaLocation</dt>
            <dd>
                <a href="{@schemaLocation}">
                    <xsl:value-of select="@schemaLocation"/>
                </a>
            </dd>
            <dt>namespace</dt>
            <dd>
                <xsl:value-of select="@namespace"/>
            </dd>
        </dl>
    </xsl:template>

    <xsl:template match="xsd:include">
        <h3>include</h3>
        <p>
            schemaLocation
            <a href="{@schemaLocation}">
                <xsl:value-of select="@schemaLocation"/>
            </a>
        </p>
    </xsl:template>

    <xsl:template match="xsd:redefine">
        <h3>redefine</h3>
        <p>
            schemaLocation
            <a href="{@schemaLocation}">
                <xsl:value-of select="@schemaLocation"/>
            </a>
        </p>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="xsd:element">
        <h3 id="{@name}">
            <xsl:if test="@abstract='true'">
                abstract
            </xsl:if>
            要素
            <xsl:value-of select="@name"/>
        </h3>
        <div class="section">
            <xsl:if test="@type">
                type:
                <a href="#{@type}">
                    <xsl:value-of select="@type"/>
                </a>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="/xsd:schema/xsd:complexType">
        <h3 id="{@name}">
            複合型
            <dfn>
                <xsl:value-of select="@name"/>
            </dfn>
        </h3>
        <div>
            <xsl:if test="xsd:complexContent"/>


            <xsl:if test="@abstract='true'">
                abstract
            </xsl:if>
            <xsl:if test="@mixed='true'">
                mixed
            </xsl:if>
            <xsl:if test="@final">
                final[
                <xsl:value-of select="@final"/>
                ]
            </xsl:if>
            複合型
            <dfn>
                <xsl:value-of select="@name"/>
            </dfn>
        </div>
        <xsl:if test="xsd:annotation">
            <xsl:apply-templates select="xsd:annotation"/>
        </xsl:if>
        <div class="section">
            <xsl:if test="xsd:sequence | xsd:choice | xsd:all | xsd:group">
                <h3>内容</h3>
                <pre>
                    <xsl:apply-templates select="xsd:sequence | xsd:choice | xsd:all | xsd:group"/>
                </pre>
            </xsl:if>
            <xsl:if test="xsd:attribute | xsd:attributeGroup | xsd:anyAttribute">
                <h3>属性</h3>
                <dl>
                    <xsl:for-each select="xsd:attribute | xsd:attributeGroup | xsd:anyAttribute">
                        <dt>
                            <xsl:if test="name() = 'xsd:attribute'">
                                <xsl:value-of select="@name"/>
                            </xsl:if>
                            <xsl:if test="name() = 'xsd:attributeGroup'">
                                属性グループ
                            </xsl:if>
                        </dt>
                        <dd>
                            <xsl:value-of select="@type"/>
                            <a href="#{@ref}">
                                <xsl:value-of select="@ref"/>
                            </a>
                        </dd>
                    </xsl:for-each>
                </dl>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="/xsd:schema/xsd:group">
        <h3 id="{@name}">
            グループ
            <xsl:value-of select="@name"/>
        </h3>
        <div class="section">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="/xsd:schema/xsd:simpleType">
        <h3 id="{@name}">
            単純型
            <xsl:value-of select="@name"/>
        </h3>
        <div class="section">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="xsd:attributeGroup[@name]">
        <h3>
            属性グループ
            <xsl:value-of select="@name"/>
        </h3>
        <xsl:apply-templates select="xsd:annotation"/>
        <table summary="xsd:annotation/xsd:documment">
            <caption>
                <xsl:value-of select="@name"/>
            </caption>
            <tr>
                <th>name</th>
                <th>type</th>
            </tr>
            <xsl:for-each select="*">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <tr>
                            <td>
                                <xsl:apply-templates select="."/>
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="name()='attributeGroup'">
                                        #attributeGroup
                                    </xsl:when>
                                    <xsl:otherwise>
                                        #ref
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>

                    </xsl:when>
                    <xsl:when test="@name">
                        <tr>
                            <td>
                                <xsl:value-of select="@name"/>
                            </td>
                            <td>
                                <xsl:value-of select="@type"/>
                            </td>
                        </tr>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="xsd:simpleType">
        <xsl:if test="@name">
            <h3 id="{@name}">
                <xsl:value-of select="@name"/>
            </h3>
            <div class="section">
                <xsl:apply-templates/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="xsd:element[@ref]"></xsl:template>
    <xsl:template match="xsd:element">
        <xsl:if test="@ref">
            <a href="#{@ref}">
                <xsl:value-of select="@ref"/>
            </a>
        </xsl:if>
        <xsl:if test="@name">
            <xsl:value-of select="@name"/>
        </xsl:if>
        <xsl:if test="@maxOccurs='unbounded'">
            <xsl:text>*</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="xsd:attribute">
        <xsl:if test="@name">
            <xsl:value-of select="@name"/>
            :
            <xsl:value-of select="@type"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="xsd:complexType">
        <xsl:if test="@name">
            <h3 id="{@name}">
                <xsl:value-of select="@name"/>
            </h3>
        </xsl:if>
        <div class="section">
            <xsl:if test="xsd:sequence | xsd:choice | xsd:all | xsd:group">
                <h3>内容</h3>
                <pre>
                    <xsl:apply-templates select="xsd:sequence | xsd:choice | xsd:all | xsd:group"/>
                </pre>
            </xsl:if>
            <xsl:if test="xsd:attribute | xsd:attributeGroup | xsd:anyAttribute">
                <h3>属性</h3>
                <dl>
                    <xsl:for-each select="xsd:attribute | xsd:attributeGroup | xsd:anyAttribute">
                        <dt>
                            <xsl:if test="name() = 'xsd:attribute'">
                                <xsl:value-of select="@name"/>
                            </xsl:if>
                            <xsl:if test="name() = 'xsd:attributeGroup'">
                                属性グループ
                            </xsl:if>
                        </dt>
                        <dd>
                            <xsl:value-of select="@type"/>
                            <a href="#{@ref}">
                                <xsl:value-of select="@ref"/>
                            </a>
                        </dd>
                    </xsl:for-each>
                </dl>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="xsd:group[@ref]">
        <xsl:text>%</xsl:text>
        <a href="#{@ref}">
            <xsl:value-of select="@ref"/>
        </a>
        <xsl:text>;</xsl:text>
        <xsl:if test="@maxOccurs='unbounded'">
            <xsl:text>*</xsl:text>
        </xsl:if>
    </xsl:template>


    <xsl:template match="xsd:attributeGroup[@ref]">
        <a href="#{@ref}">
            <xsl:value-of select="@ref"/>
        </a>
    </xsl:template>
    
    <xsl:template match="xsd:choice | xsd:sequence | xsd:all">
        <xsl:variable name="count" select="count(*)"/>
        <xsl:variable name="name" select="local-name()"/>
        <xsl:text>(</xsl:text>
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
            <xsl:if test="$count - position()">
                <xsl:if test="$name = 'choice'">
                    <xsl:text>|</xsl:text>
                </xsl:if>
                <xsl:if test="$name = 'sequence'">
                    <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:if test="$name = 'all'">
                    <xsl:text>&amp;</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="@maxOccurs='unbounded'">
            <xsl:text>*</xsl:text>
        </xsl:if>
        <xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="xsd:complexContent">
        複合型
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="xsd:simpleContent">
        単純型
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="xsd:restriction">
        制限 基準型：
        <a href="#{@base}">
            <xsl:value-of select="@base"/>
        </a>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="xsd:extension">
        拡張 基準型:
        <a href="#{@base}">
            <xsl:value-of select="@base"/>
        </a>
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- xsd:annotation -->
    <xsl:template match="xsd:annotation">
        <div class="annotation">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="xsd:documentation">
        <p>
            <xsl:if test="@source">
                参照：
                <a href="{@source}">
                    <xsl:value-of select="@source"/>
                </a>
                <br/>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="xsd:*">
        <xsl:element name="{local-name()}">
            <xsl:choose>
                <xsl:when test="@href">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@href"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
