<?xml version="1.0"?>

<xsl:stylesheet version  ="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/"> 
		<html>
		<body style="background-color:white;">
			<xsl:param name="NomPays" select"ValeurInitiale"/>
			<xsl:apply-templates select="//country"/>
		</body> 
		</html> 
	</xsl:template>
		
	<xsl:template match="country">
		<p>
			<xsl:if test="$NomPays = name/common">
				<xsl:value-of select="name/official"/>
				<xsl:value-of select="capital"/>
			</xsl:if>
		</p>
</xsl:stylesheet>