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
		
		<hr></hr>
		<p>
			Pays ayant plus de 6 voisins : 
			<xsl:for-each select = "//borders[count(neighbour)=6]/../name">
				<xsl:value-of select="common"/>
			<xsl:if test="position() != last()">,
			</xsl:if>
			</xsl:for-each>
		</p>
		
		<p>
			Pays avec le plus court nom :
			<xsl:for-each select="//name">
				<xsl:sort select="string-length(common)" data-type="number" order="ascending"/>
				<xsl:if test="position()=1">
					<xsl:copy-of select="common"/>
				</xsl:if>
			</xsl:for-each>
		</p>
		<hr></hr>
		
		<xsl:apply-templates select="//infosContinent[not(preceding::continent = continent)]/continent"/>
		
 	</body> 
	</html> 
	</xsl:template>

	<xsl:template match="metadonnees">
 	<p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
 	</p><hr/>
	</xsl:template>
	
	<xsl:template match="continent">
		<xsl:variable name="Continent" select ="."/>
		<h3>
			Pays du continent : <xsl:value-of select="."/> par sous-régions : <br/>
		</h3>
		<xsl:apply-templates select="//infosContinent[not(preceding::subregion = subregion) and continent = $Continent]/subregion"/>
		
	</xsl:template>
	
	<xsl:template match="subregion">
		<xsl:variable name="Subregion" select ="."/>
		<h4>
		<xsl:value-of select="."/>
		(<xsl:value-of select="count(//country[infosContinent/subregion = $Subregion])"/> pays)
		</h4>
		
		<table  border="3" width="100%" align="center">
			<tr>
				<th>
					N°
				</th>
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
				<th>
					Drapeau
				</th>
			</tr>
			<xsl:apply-templates select="//country[infosContinent/subregion = $Subregion]"/>
	</table> 
	</xsl:template>

	<xsl:template match="country">
		<tr>
			<td>
				<xsl:value-of select="position()"/>
			</td>
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
				<xsl:variable name="codePays2" select="codes/cca2"/>
				<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
				<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
				<img>
					<xsl:attribute name="src">
						http://www.geonames.org/flags/x/<xsl:value-of select="translate($codePays2, $uppercase, $lowercase)"/>.gif
					</xsl:attribute>
					<xsl:attribute name="alt"></xsl:attribute>
					<xsl:attribute name="height">40</xsl:attribute>
					<xsl:attribute name="width">60</xsl:attribute>
				</img>
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>


