<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Nosferatu</title>
                <link rel="stylesheet" type="text/css" href="nosferatu-style.css"/>
            </head>
            <body>
                <header>
                    <h1 id="top">
                        <xsl:apply-templates select="root/title"/>
                    </h1>
                </header>
                
                <nav>
                    <h2>Table of Contents</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Scene Number</th>
                                <th>Locations</th>
                                <th>Camera Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select=".//act" mode="toc"/>
                        </tbody>
                    </table>
                </nav>
                
                <main id="readingView">
                    <xsl:apply-templates select="descendant::act"/>
                </main>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="act" mode="toc">
        <tr>
            <td>
                <a href="#act{@num}">
                    Act <xsl:value-of select="@num"/>: 
                    <xsl:apply-templates select="child::title[1]" mode="toc"/>
                </a>
                <p>
                    <xsl:apply-templates select="scene" mode="toc"/>
                </p>
            </td>
            <td>
                <xsl:value-of select="string-join(distinct-values(.//loc), ', ')"/>
            </td>
            <td>
                <xsl:value-of select="string-join(distinct-values(.//cam), ', ')"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="scene" mode="toc">
        <a href="#Sn{@num}">Scene <xsl:value-of select="@num"/></a>
        <xsl:if test="position() != last()">, </xsl:if>
    </xsl:template>
    
    <xsl:template match="act">
        <section id="act{@num}">
            <h1>
                Act <xsl:value-of select="@num"/>: 
                <xsl:apply-templates select="title"/>
            </h1>
            <xsl:apply-templates select="scene"/>
        </section>
    </xsl:template>

    <xsl:template match="scene">
        <div id="Sn{@num}" class="scene">
            <h2>Scene <xsl:value-of select="@num"/></h2>
            <p><strong>Locations:</strong> 
                <xsl:value-of select="string-join(distinct-values(loc), ', ')"/>
            </p>
            <p><strong>Camera Notes:</strong> 
                <xsl:value-of select="string-join(distinct-values(cam), ', ')"/>
            </p>
            <div class="scene-content">
                <xsl:apply-templates/>
            </div>
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
