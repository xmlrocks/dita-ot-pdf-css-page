<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
                xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
                exclude-result-prefixes="#all">


    <xsl:param name="generate-index" as="xs:boolean"/>

    <xsl:template
            match="*[contains(@class, ' topic/title ') and following-sibling::*[contains(@class, ' topic/prolog ')]]">
        <xsl:apply-templates select="following-sibling::*[contains(@class, ' topic/prolog ')]" mode="create-anchor"/>
        <xsl:next-match/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/prolog ')]" mode="create-anchor">
        <xsl:apply-templates select="*[contains(@class, ' topic/metadata ')]//
                                     *[contains(@class, ' topic/keywords ')]//
                                     opentopic-index:index.entry//
                                     opentopic-index:refID"
                             mode="create-anchor"/>
    </xsl:template>

    <xsl:template mode="create-anchor"
                  match="*[contains(@class, ' topic/metadata ')]//
                         *[contains(@class, ' topic/keywords ')]//
                         opentopic-index:index.entry//
                         opentopic-index:refID">
        <a id="{concat(@value, generate-id())}"/>
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
                <xsl:call-template name="generate-links"/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="opentopic-index:index.group/opentopic-index:index.entry" priority="10">
        <li>
            <xsl:call-template name="generate-links"/>
        </li>
    </xsl:template>

    <xsl:key name="index-refid" match="opentopic-index:refID" use="@value"/>

    <xsl:template name="generate-links">
        <p class="index-entry">
            <xsl:apply-templates select="opentopic-index:formatted-value"/>
            <xsl:text>: </xsl:text>
            <xsl:variable name="context-ref-id" select="opentopic-index:refID/@value"/>
            <xsl:for-each select="key('index-refid', $context-ref-id)[position() ne last()]">
                <a href="#{concat($context-ref-id, generate-id())}"/>
                <xsl:if test="position() ne last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </p>
        <xsl:apply-templates select="opentopic-index:index.entry"/>
    </xsl:template>

    <xsl:template match="opentopic-index:formatted-value">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="opentopic-index:refID | ot-placeholder:indexlist"/>

</xsl:stylesheet>