<?xml version="1.0"?>

<xsl:stylesheet version  ="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="nomPays" select="ValeurInitiale"/>

	<xsl:template match="/"> 
		<html>
		<body style="background-color:white;">	
			<xsl:apply-templates select="//country[$nomPays = name/common]"/>

		</body> 
		</html>

	</xsl:template>
	
	<xsl:template match="country">
		<span>
			<xsl:value-of select="name/official"/>
			et 
			<xsl:value-of select="capital"/>
		</span>
	</xsl:template>

</xsl:stylesheet>