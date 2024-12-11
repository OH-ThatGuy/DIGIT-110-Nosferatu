<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Dracula</title>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/>
            </head>
            <body>
                <h1 id="top"><xsl:apply-templates select="root/title"/></h1>
                
                <!-- Table of contents. -->
                <section id="contents"> 
                    <table> 
                        <tr>
                            <th>Scene Number</th>
                            <th>Locations mentioned</th>
                            <th>Camera Notes</th>
                        </tr>
                        
                        <xsl:apply-templates select=".//act" mode="toc"/>
                        <!-- ebb: Prepare the table of contents representing each descendant chapter heading,
                   Hint: use <xsl:apply-templates with @mode here.  -->   
                        
                    </table>
                </section>
                
                <!--Reading view of the chapters here. -->
                <section id="readingView">
                    <xsl:apply-templates select="descendant::act"/>
                </section>
            </body>
        </html>
    </xsl:template>
    
    
    <!-- TOC TEMPLATES -->
    
    <xsl:template match="act" mode="toc">
        <tr>
            <td>
                <a href="#act{@num}">
                    
                    <xsl:apply-templates select="child::title[1]" mode="toc"/>
                </a>
                
                
                <p> <xsl:apply-templates select="scene" mode="toc"/></p>
                
                
            </td>
            <td>
                <xsl:apply-templates select="string-join(distinct-values(.//loc), ', ')" mode="toc"/>
            </td>
            <td>
                <xsl:apply-templates select="string-join(distinct-values(.//cam), ', ')" mode="toc"/>
            </td>
        </tr>
    </xsl:template>
    
 <xsl:template match="scene" mode="toc"> 
         <a href="#Sn{@num}">Scene <xsl:value-of select="@num"/></a>
        <xsl:if test="position() != last()">, </xsl:if>
    </xsl:template>    
    
    
    <!-- READING VIEW TEMPLATES  -->
    <xsl:template match="act">
        <section>
            <h1 id="act{@num}">
                <xsl:apply-templates select="title"/>
            </h1>
            
            <xsl:apply-templates select="scene"/>
      
        </section>
    </xsl:template>
    
    <xsl:template match="scene">
        
        <div id="Sn{@num}">
            <xsl:apply-templates/>
            
        </div>
        
    </xsl:template>
    
    

    <xsl:template match="loc">
        <span class="loc">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="cam">
        <span class="cam">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

</xsl:stylesheet>