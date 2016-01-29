<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
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

    <xsl:template match="opentopic:map/*[contains(@class, ' map/topicref ')]" priority="10">
        <ul class="bookmap/part">
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' map/topicmeta ')]">
                    <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')],
                                                 *[contains(@class, ' map/topicref ')]"/>
                </xsl:when>
                <xsl:when test="exists(@navtitle)">
                    <li class="toc-heading-1">
                        <a href="#{@id}">
                            <xsl:value-of select="@navtitle"/>
                        </a>
                        <ul>
                            <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')],
                                                         *[contains(@class, ' map/topicref ')]"/>
                        </ul>
                    </li>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')],
                                                 *[contains(@class, ' map/topicref ')]"/>
                </xsl:otherwise>
            </xsl:choose>
        </ul>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' map/topicref ')]">
        <xsl:if test="exists(element()/*[contains(@class, ' map/linktext ')])">
            <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]"/>
            <xsl:if test="exists(*[contains(@class, ' map/topicref ')])">
                <li class="toc-heading-2">
                    <ul>
                        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]"/>
                    </ul>
                </li>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="opentopic:map/*[contains(@class, ' map/topicref ')]/*[contains(@class, ' map/topicmeta ')]"
                  priority="10">
        <li class="toc-heading-1">
            <a href="#{parent::*/@id}">
                <xsl:apply-templates select="*[contains(@class, ' map/linktext ')]"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' map/topicmeta ')]">
        <li class="toc-heading-2">
            <a href="#{parent::*/@id}">
                <xsl:apply-templates select="*[contains(@class, ' map/linktext ')]"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' map/linktext ')]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*[@class = ('h2', 'h3')]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ot-placeholder:toc"/>

</xsl:stylesheet>