<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	xmlns="http://www.w3.org/2005/Atom"
	extension-element-prefixes="str"
	exclude-result-prefixes="str"
>

<!--

This transformation generates a good Atom 1.0 representation from the XML
returned by the del.icio.us API functions at api.del.icio.us/v1/posts/*

Written by Aristotle Pagaltzis.

This code is in the public domain.

-->

<xsl:output
	method="xml"
	indent="no"
	encoding="utf-8"
/>

<xsl:template match="node()|@*">
	<xsl:apply-templates select="@*|node()"/>
</xsl:template>

<xsl:variable name="user" select="/posts/@user" />
<xsl:variable name="url" select="concat( 'http://del.icio.us/', $user )" />

<xsl:template match="post">
	<xsl:variable name="hash-url" select="concat( 'http://del.icio.us/url/', @hash )" />
	<xsl:variable name="shared" select="@shared" /> <!-- @shared = 'no' means the item is private -->
	<xsl:text>&#10;</xsl:text>
	<entry>
		<title><xsl:value-of select="@description" /></title>
		<xsl:if test="@extended">
			<summary><xsl:value-of select="@extended" /></summary>
		</xsl:if>
		<link href="{ @href }"/>
		<link rel="related" href="{ $hash-url }"/>
		<id><xsl:value-of select="$hash-url" /></id>
		<updated><xsl:value-of select="@time" /></updated>
		<xsl:for-each select="str:tokenize( @tag, ' ' )">
			<category scheme="{ $url }/" term="{.}" />
		</xsl:for-each>
	</entry>
</xsl:template>

<xsl:template match="/">
	<feed>
		<xsl:text>&#10;</xsl:text>
		<title>del.icio.us links for <xsl:value-of select="$user" /></title>
		<id><xsl:value-of select="$url" /></id>
		<link href="{$url}"/>
		<updated><xsl:value-of select="/posts/@update" /></updated>
		<author>
			<name><xsl:value-of select="$user" /></name>
			<uri><xsl:value-of select="$url" /></uri>
		</author>
		<xsl:apply-templates />
		<xsl:text>&#10;</xsl:text>
	</feed>
</xsl:template>

</xsl:stylesheet>
