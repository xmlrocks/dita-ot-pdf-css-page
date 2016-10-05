<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all">

  <dita:extension id="xsl.pdf-css-page" 
    behavior="org.dita.dost.platform.ImportXSLAction" 
    xmlns:dita="http://dita-ot.sourceforge.net"/>
  
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <xsl:import href="dita2pdf-css-page-main.xsl"/>
    <xsl:import href="dita2pdf-css-page-toc.xsl"/>
    <xsl:import href="dita2pdf-css-page-index.xsl"/>

    <xsl:import href="xslhtml/dita2pdf-css-page-syntax-braces.xsl.xsl"/>

</xsl:stylesheet>