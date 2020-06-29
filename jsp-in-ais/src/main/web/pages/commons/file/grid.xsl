<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/table">
		<center>
		<h2><xsl:value-of select="@title" /></h2>
			<table border="0" class="ListTable">
			<xsl:apply-templates select="define"/>
			<xsl:apply-templates select="data"/>
			</table>
		</center>
	</xsl:template>

	<xsl:template match="define">
	<tr>
		<xsl:for-each select="/table/define/field">
         		<td><xsl:value-of select="current()"/></td>
      	</xsl:for-each>
    </tr>
	</xsl:template>
	
	<xsl:template match="data">
	
		<xsl:for-each select="rec">
			<tr class="ListTableTr1">
         		<xsl:for-each select="field">
         		<td class="listtabletr2"><xsl:value-of select="current()"/></td>
         		</xsl:for-each>
         	</tr>
      	</xsl:for-each>
    
	</xsl:template>

</xsl:stylesheet>
