<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="nosfer1" as="document-node()+" select="doc('workspace-xml/nosferatuPart1.xml')"/>
    <xsl:variable name="nosfer2" as="document-node()+" select="doc('workspace-xml/nosferatuPart2.xml')"/>
    <xsl:variable name="nosfer3" as="document-node()+" select="doc('workspace-xml/nosferatuPart3.xml')"/>
    
    <xsl:variable name="workspaceColl" as="document-node()+" select="($nosfer1, $nosfer2, $nosfer3)"/>
    
  
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">
       href="nosferatu_schema.rnc" 
       type="application/relax-ng-compact-syntax"
  </xsl:processing-instruction>
        <root>
            <script>
      <xsl:apply-templates select="$nosfer1//head"/> 
                
        <xsl:apply-templates select="$workspaceColl//act"/>      
        
        
            </script>
        </root>
    </xsl:template>
    
</xsl:stylesheet>