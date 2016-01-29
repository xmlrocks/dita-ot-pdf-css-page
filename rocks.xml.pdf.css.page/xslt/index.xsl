<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
                exclude-result-prefixes="#all">


    <xsl:param name="generate-index" as="xs:boolean"/>

    <xsl:template match="//reference//prolog">
        <xsl:apply-templates mode="create-anchor"/>
    </xsl:template>

    <xsl:template match="metadata//keywords//opentopic-index:refID" mode="create-anchor">
        <p id="{@value}"/>
    </xsl:template>

    <xsl:template match="opentopic-index:index.groups"/>

    <xsl:template match="opentopic-index:index.groups[element()]" priority="10">
        <div class="index">
            <h1 id="index">Index</h1>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="opentopic-index:index.groups[not($generate-index)]" priority="20">
        <xsl:message terminate="no">[INFO]: Index generation is disabled</xsl:message>
    </xsl:template>

    <xsl:template match="opentopic-index:index.group">
        <ul class="index-group">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="opentopic-index:label">
        <li>
            <h3 id="index-entry{text()}">
                <xsl:apply-templates/>
            </h3>
        </li>
    </xsl:template>

    <xsl:template match="opentopic-index:index.entry">
        <ul>
            <li>
                <xsl:apply-templates/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="opentopic-index:index.group/opentopic-index:index.entry" priority="10">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="opentopic-index:formatted-value">
        <p class="index-entry">
            <xsl:apply-templates/>
            <xsl:text>: </xsl:text>
            <a href="#{following-sibling::opentopic-index:refID/@value}"/>
        </p>
    </xsl:template>

    <xsl:template match="opentopic-index:refID"/>

</xsl:stylesheet>