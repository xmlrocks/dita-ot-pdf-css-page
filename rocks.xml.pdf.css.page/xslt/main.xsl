<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
                exclude-result-prefixes="#all">


    <xsl:template match="*[contains(@class, ' map/map ')]">
        <xsl:apply-templates select="." mode="root_element"/>
    </xsl:template>

    <xsl:template name="generateChapterTitle">
        <!-- Title processing - special handling for short descriptions -->
        <title>
            <xsl:call-template name="gen-user-panel-title-pfx"/> <!-- hook for a user-XSL title prefix -->
            <xsl:variable name="maintitle">
                <xsl:apply-templates select="/*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"
                                     mode="text-only"/>
            </xsl:variable>
            <xsl:variable name="ditamaintitle">
                <xsl:apply-templates
                        select="opentopic:map/*[contains(@class, ' topic/title ')]"
                        mode="text-only"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="string-length($maintitle) > 0">
                    <xsl:value-of select="normalize-space($maintitle)"/>
                </xsl:when>
                <xsl:when test="string-length($ditamaintitle) > 0">
                    <xsl:value-of select="normalize-space($ditamaintitle)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>***</xsl:text>
                    <xsl:apply-templates select="." mode="ditamsg:no-title-for-topic"/>
                </xsl:otherwise>
            </xsl:choose>
        </title>
        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template match="*" mode="chapterBody">
        <body>
            <xsl:apply-templates select="." mode="addAttributesToHtmlBodyElement"/>
            <xsl:if test="contains(@class, ' map/map ')">
                <xsl:call-template name="create-book-title"/>
            </xsl:if>
            <xsl:call-template name="setaname"/>  <!-- For HTML4 compatibility, if needed -->
            <xsl:value-of select="$newline"/>
            <xsl:apply-templates select="." mode="addHeaderToHtmlBodyElement"/>

            <!-- Include a user's XSL call here to generate a toc based on what's a child of topic -->
            <xsl:call-template name="gen-user-sidetoc"/>

            <xsl:apply-templates select="." mode="addContentToHtmlBodyElement"/>
            <xsl:apply-templates select="." mode="addFooterToHtmlBodyElement"/>
        </body>
        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template name="create-book-title">
        <div class="book-title">
            <h1 class="title-page">
                <xsl:apply-templates mode="text-only"
                                     select="opentopic:map/*[contains(@class, ' topic/title ')]"/>
            </h1>
        </div>
    </xsl:template>

    <xsl:template match="attribute() | node()" mode="create-id">
        <xsl:copy>
            <xsl:apply-templates select="attribute() | node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>