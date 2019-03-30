<?xml version="1.0"?>

<xsl:stylesheet version  ="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="premieresLettres" select="ValeurInitiale"/>

	<xsl:template match="/"> 
		<html>
		<body style="background-color:white;">	
			<span>
				<xsl:for-each select="//name[starts-with(common,$premieresLettres)]">
					<xsl:value-of select="common"/><xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</span>
		</body> 
		</html>

	</xsl:template>

</xsl:stylesheet>