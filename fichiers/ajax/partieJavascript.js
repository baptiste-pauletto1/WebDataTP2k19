//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function recupererPremierEnfantDeTypeNode(n) {
    var x = n.firstChild;
    while (x.nodeType != 1) { // Test if x is an element node (and not a text node or other)
        x = x.nextSibling;
    }
    return x;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//change le contenu de l'élement avec l'id "nom" avec la chaine de caractéres en paramètre	  
function setNom(id,nom) {
    var elementHtmlARemplir = window.document.getElementById(id);
    elementHtmlARemplir.innerHTML = nom;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//charge le fichier XML se trouvant à l'URL relative donné dans le paramètreet le retourne
function chargerHttpXML(xmlDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    //chargement du fichier XML à l'aide de XMLHttpRequest synchrone (le 3° paramètre est défini à false)
    httpAjax.open('GET', xmlDocumentUrl, false);
    httpAjax.send();

    return httpAjax.responseXML;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
// Charge le fichier JSON se trouvant à l'URL donnée en paramètre et le retourne
function chargerHttpJSON(jsonDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    // chargement du fichier JSON à l'aide de XMLHttpRequest synchrone (le 3° paramètre est défini à false)
    httpAjax.open('GET', jsonDocumentUrl, false);
    httpAjax.send();

    var responseData = eval("(" + httpAjax.responseText + ")");

    return responseData;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton1_BackgroundColor(color){
	document.body.style.background = color;
	document.getElementById("myButton1").style.color = 'white';
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton2_ResetBackgroundColor() {
	document.body.style.background = 'white';
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function Bouton3_NomPays(){
    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML("cherchePays.xsl");

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);
    xsltProcessor.setParameter(null,"nomPays",document.getElementById("nomPays").value)

    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML("countriesTP.xml");

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    // Recherche du parent (dont l'id est "here") de l'élément à remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("resultButton");
    // Premier élément fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    // Premier élément "elementName" du nouveau document (par exemple, "ul", "table"...)
    var elementAInserer = newXmlDocument.getElementsByTagName("span")[0];

    // Remplacement de l'élément
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);
	
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton4_ChargeAfficheDessin() {
    var xmlDocument = chargerHttpXML("exemple.svg");
    var xmlSerializer = new XMLSerializer();
    var textSVG = xmlSerializer.serializeToString(xmlDocument);
    document.getElementById("imageSvgFormes").innerHTML = textSVG;
}


function Bouton5_RendreCliquable() {
    var enfantsFormes = document.getElementById("imageSvgFormes").getElementsByTagName("g")[0].childNodes;
    for (var i = 0; i < enfantsFormes.length; i++){
        enfantsFormes[i].addEventListener("click",
            function(){
                document.getElementById("objectName").innerHTML=this.getAttribute("title");
            },false);
    }
}

function Bouton6_ChargeAfficheCarte(){
    var xmlDocument = chargerHttpXML("worldHigh.svg");
    var xmlSerializer = new XMLSerializer();
    var textSVG = xmlSerializer.serializeToString(xmlDocument);
    document.getElementById("imageSvgMonde").innerHTML = textSVG;
}

function Bouton7_RendreCliquable() {
    var enfantsPays = document.getElementById("imageSvgMonde").getElementsByTagName("g")[0].childNodes;
    for (var j = 0; j < enfantsPays.length; j++){
        enfantsPays[j].addEventListener("click",
            function(){
                document.getElementById("countryName").innerHTML=this.getAttribute("countryname");
            },false);
    }
}

function GetInfosParametres(param, numSpan){
    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML("chercheCapitaleDrapeau.xsl");

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);
    xsltProcessor.setParameter(null,"idPays",param);

    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML("countriesTP.xml");

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    // Premier élément "elementName" du nouveau document (par exemple, "ul", "table"...)
    var elementAInserer = newXmlDocument.getElementsByTagName("span")[numSpan];
    console.log(elementAInserer);
    return elementAInserer.innerHTML;
    
}

function Bouton8_SurvolAffichage(){
    var enfantsPays = document.getElementById("imageSvgMonde").getElementsByTagName("g")[0].childNodes;
    for (var j = 0; j < enfantsPays.length; j++){
        enfantsPays[j].addEventListener("mouseover",
            function(){
                document.getElementById("nomPaysTableau").innerHTML=this.getAttribute("countryname");
                document.getElementById("capitalePaysTableau").innerHTML=GetInfosParametres(this.getAttribute("id"),0);
                document.getElementById("drapeauPaysTableau").innerHTML=GetInfosParametres(this.getAttribute("id"),1);
                this.setAttribute("style","fill:red");
            },false);
        enfantsPays[j].addEventListener("mouseleave",
            function(){
                document.getElementById("nomPaysTableau").innerHTML=this.getAttribute("countryname");
                this.setAttribute("style","");
            },false);

    }
}

function genererCompletion(){
    document.getElementById("autocompletion").addEventListener("input",
        function(){

    },false)

}
