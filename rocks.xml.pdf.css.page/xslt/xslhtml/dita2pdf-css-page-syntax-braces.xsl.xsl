<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all">


    <xsl:template match="*[contains(@class,' pr-d/syntaxdiagram ')]">
        <div style="display: block; padding: 2pt; color: maroon; margin-bottom: 6pt;">
            <xsl:apply-templates mode="process-syntaxdiagram"/>
        </div>
    </xsl:template>

</xsl:stylesheet>