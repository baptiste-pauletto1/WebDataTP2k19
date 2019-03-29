<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="idPays" select="init"/>
	<xsl:template match="/"> 
		<html>
		<body style="background-color:white;">	
			<xsl:apply-templates select="//country[codes/cca2=$idPays]"/>
		</body> 
		</html>

	</xsl:template>

	<xsl:template match="country">
		<span>
			<xsl:value-of select="capital"/>
		</span>

		<xsl:variable name="codePays" select="codes/cca2"/>
		<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
		<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

		<span>
			<img>
				<xsl:attribute name="src">http://www.geonames.org/flags/x/<xsl:value-of select="translate($codePays, $uppercase, $lowercase)"/>.gif</xsl:attribute>
				<xsl:attribute name="alt"></xsl:attribute>
				<xsl:attribute name="height">40</xsl:attribute>
				<xsl:attribute name="width">60</xsl:attribute>
			</img>
		</span>
	</xsl:template>

</xsl:stylesheet>