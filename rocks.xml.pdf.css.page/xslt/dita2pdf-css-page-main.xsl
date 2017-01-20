<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
                exclude-result-prefixes="#all">



    <xsl:template match="*[contains(@class, ' map/map ')]">
        <xsl:apply-templates select="." mode="root_element"/>
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
                <xsl:call-template name="gen-book-title"/>
            </h1>
        </div>
    </xsl:template>


    <xsl:template name="gen-book-title">
        <xsl:variable name="maintitle">
            <xsl:apply-templates select="/*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"
                                 mode="text-only"/>
        </xsl:variable>
        <xsl:variable name="ditamaintitle">
            <xsl:apply-templates
                    select="opentopic:map/*[contains(@class, ' topic/title ')]"
                    mode="text-only"/>
        </xsl:variable>
        <xsl:variable name="maptitle">
            <xsl:apply-templates
                    select="/*[contains(@class, ' map/map ')]/@title"
                    mode="text-only"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($maintitle) > 0">
                <xsl:value-of select="normalize-space($maintitle)"/>
            </xsl:when>
            <xsl:when test="string-length($ditamaintitle) > 0">
                <xsl:value-of select="normalize-space($ditamaintitle)"/>
            </xsl:when>
            <xsl:when test="string-length($maptitle) > 0">
                <xsl:value-of select="normalize-space($maptitle)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>***</xsl:text>
                <xsl:apply-templates select="." mode="ditamsg:no-title-for-topic"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="generateChapterTitle">
        <!-- Title processing - special handling for short descriptions -->
        <title>
            <xsl:call-template name="gen-user-panel-title-pfx"/> <!-- hook for a user-XSL title prefix -->
            <xsl:call-template name="gen-book-title"/>
        </title>
        <xsl:value-of select="$newline"/>
    </xsl:template>


    <xsl:template match="*" mode="addContentToHtmlBodyElement">
        <main role="main">
            <article role="article">
                <xsl:attribute name="aria-labelledby">
                    <xsl:apply-templates select="*[contains(@class,' topic/title ')] |
                                       self::dita/*[1]/*[contains(@class,' topic/title ')]" mode="return-aria-label-id"/>
                </xsl:attribute>
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>

                <xsl:apply-templates select="opentopic:map"/>

                <div id="body-content">
                    <xsl:apply-templates select="* except opentopic:map"/>
                </div>

                <!-- this will include all things within topic; therefore, -->
                <!-- title content will appear here by fall-through -->
                <!-- followed by prolog (but no fall-through is permitted for it) -->
                <!-- followed by body content, again by fall-through in document order -->
                <!-- followed by related links -->
                <!-- followed by child topics by fall-through -->
                <xsl:call-template name="gen-endnotes"/>    <!-- include footnote-endnotes -->
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
            </article>
        </main>
    </xsl:template>


    <xsl:template match="attribute() | node()" mode="create-id">
        <xsl:copy>
            <xsl:apply-templates select="attribute() | node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>