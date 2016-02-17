<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
                exclude-result-prefixes="#all">


    <xsl:param name="generate-toc" as="xs:boolean"/>

    <xsl:template match="opentopic:map[not($generate-toc)]" priority="10">
        <xsl:message terminate="no">[INFO]: TOC generation is disabled.</xsl:message>
    </xsl:template>

    <xsl:template match="opentopic:map">
        <div class="toc">
            <h1 class="toc-heading">Table of Contents</h1>
            <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]"/>
            <xsl:if test="exists(../opentopic-index:index.groups/element()) and $generate-index">
                <ul class="index">
                    <li class="toc-heading-1">
                        <a href="#index">Index</a>
                    </li>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="opentopic:map/*[contains(@class, ' bookmap/frontmatter ')]" priority="30">
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' mapgroup-d/topichead ') and @navtitle]" priority="20">
        <ul class="bookmap/part">
            <li class="toc-heading-1">
                <a href="#{@id}">
                    <xsl:apply-templates select="@navtitle"/>
                </a>
                <xsl:if test="*[contains(@class, ' map/topicref ')]">
                    <ul>
                        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]"/>
                    </ul>
                </xsl:if>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="opentopic:map/*[contains(@class, ' map/topicref ')] |
                         *[contains(@class, ' bookmap/frontmatter ')]/*[contains(@class, ' map/topicref ')]"
                  priority="10">
        <xsl:if test="dita-ot:exist-linktext(.)">
            <ul class="bookmap/part">
                <li class="toc-heading-1">
                    <a href="#{@id}">
                        <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]"/>
                    </a>
                    <xsl:if test="*[contains(@class, ' map/topicref ')]">
                        <ul>
                            <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]"/>
                        </ul>
                    </xsl:if>
                </li>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:function name="dita-ot:exist-linktext" as="xs:boolean">
        <xsl:param name="element" as="element()"/>

        <xsl:sequence
                select="exists($element/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/linktext ')])"/>
    </xsl:function>

    <xsl:template match="*[contains(@class, ' map/topicmeta ')]">
        <xsl:apply-templates select="*[contains(@class, ' map/linktext ')]"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' map/topicref ')]">
        <xsl:if test="dita-ot:exist-linktext(.)">
            <li class="toc-heading-2">
                <a href="#{@id}">
                    <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]"/>
                </a>
                <xsl:if test="*[contains(@class, ' map/topicref ')]">
                    <ul>
                        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]"/>
                    </ul>
                </xsl:if>
            </li>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' map/linktext ')]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*[@class = ('h2', 'h3')]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ot-placeholder:toc | ot-placeholder:figurelist"/>

</xsl:stylesheet>