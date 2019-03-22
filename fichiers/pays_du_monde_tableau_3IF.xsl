<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Fri Mar 22 16:38:06 CET 2019 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="/"> 
	<html> 
 		<head> 
    			<title> 
    				Pays du monde 
  			</title> 
		 </head> 
 
 	<body style="background-color:white;">  
   		<h1>Les pays du monde</h1> 
      			Mise en forme par : Baptiste PAULETTO, Louis UNG et Fabien GELUS (g pa lu xd) (B3246)
      	<xsl:apply-templates select="//metadonnees"/>
		<table  border="3" width="100%" align="center">
			<tr>
				<th>
					Nom
				</th>
				<th>
					Capitale
				</th>
				<th>
					Voisins
				</th>
				<th>
					Coordonnées
				</th>
			</tr>
			<xsl:apply-templates select="//country"/>
		</table> 
 	</body> 
	</html> 
	</xsl:template>

	<xsl:template match="metadonnees">
 	<p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
 	</p><hr/>
	</xsl:template>

	<xsl:template match="country">
		<tr>
			<td>
				<p><span style="color:green;">
					<xsl:value-of select="name/common"/>
					</span>
					(<xsl:value-of select="name/official"/>)
				</p>
				<p style="color:brown">
					<xsl:value-of select="name/native_name[@lang='fra']/official"/>
				</p>
			</td>

			<td>
				<xsl:value-of select="capital"/>
			</td>

			<td>
				<xsl:if test="./landlocked='false' and count(borders/neighbour) = 0">
					Île
				</xsl:if>
				<xsl:if test="count(borders/neighbour) > 0">
					<xsl:for-each select="borders/neighbour">
						<xsl:variable name="codePays" select="."/>
						<xsl:value-of select="//country[codes/cca3 = $codePays]/name/common"/>
						<xsl:if test="position() != last()">,
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</td>

			<td>
				Latitude : <xsl:value-of select="coordinates/@lat"/><br/>
				Longitude : <xsl:value-of select="coordinates/@long"/>
			</td>

			<td>
				<img src="(concat(http://www.geonames.org/flags/x/fr.gif" alt="" height="40" width="60"> //A FINIR LE CONCAT
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>


