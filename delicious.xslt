<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:str="http://exslt.org/strings"
   extension-element-prefixes="str"
   exclude-result-prefixes="str"
   >

<!--

Based on code by Aristotle Pagaltzis.
This code is in the public domain.

-->
<xsl:template match="post">
   <xsl:text>&#10;</xsl:text>
   Title: <xsl:value-of select="@description" />
   <xsl:if test="@extended">
      Description: <xsl:value-of select="@extended" />
   </xsl:if>
      URL: <xsl:value-of select="@href" /> 
      When: <xsl:value-of select="@time" />
</xsl:template>

<xsl:template match="/">
   <xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>
