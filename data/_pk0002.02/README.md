<aside>
<table align="right" style="padding: 1em">
<tr><td>Paquete <big><b>pk0002.02</b></big> de <small><a target="_afacodes" title="Jurisdicción" href="https://afa.codes/UY">UY</a></small>
</td></tr>
<tr><td>
Donante: <a rel="external" target="_doador" href="https://catalogodatos.gub.uy/dataset/ide-direcciones-geograficas-del-uruguay">Administración Nacional de Correos</a>
<br/>&nbsp; <small>RUT 214130990011</small> • Wikidata <a rel="external" target="_doador" title="Enlace del descriptor Wikidata del donante" href="https://www.wikidata.org/wiki/Q5172888">Q5172888</a></small><br/>
Licencia <a rel="external" target="_doador" href="https://dl.digital-guard.org/e40a8eae6ab287564b7eddb6f56ed7ba84678e2960320565e2371f3d3ffcdaee.pdf"><b>Implied CC-BY</b></a> (by)<br/>
Obtido via <i>e-mail</i> em <b>21/07/2024</b> por:
<br/>&nbsp; Avaliação técnica: <a rel="external" target="_gitPerson" title="Usuario de Git" href="https://github.com/crebollobr">crebollobr</a>
<br/>&nbsp; Representação institucional: <a rel="external" target="_gitPerson" title="Usuario de" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="via" href="#-via"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/></a> <a title="address" href="#-address"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-address.png" alt="address" width="20"/></a> <a title="geoaddress" href="#-geoaddress"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/></a> </td></tr>

</table>
</aside>

<section>

Este repositorio de metadatos describe un paquete de archivos donados al dominio público. Está siendo conservado por Digital Guard: para obtener más detalles, consulte la [documentación sobre el proceso de registro y conservación](https://wiki.addressforall.org/doc/Documentação_Digital-guard).

Nota. Este documento README fue generado por software a partir de la información contenida en el archivo [`make_conf.yaml`](https://git.digital-guard.org/preserv-UY/blob/main/data/_pk0002.02/make_conf.yaml) en este paquete, e información adicional de los catálogos de [donantes](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) y [paquetes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Capas de datos

Los archivos contienen "capas de datos" temáticas. Los metadatos también describen cómo se evaluó cada capa y cómo se filtraron sus datos de forma estandarizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/> geoaddress

Nombre del archivo: `Direcciones_pais`<br/>*Descarga* e integridad: [bb975aced997119b9b381f0b78045fb8fe3dd322067d62e7e2cd17bb8b92d748.zip](https://dl.digital-guard.org/bb975aced997119b9b381f0b78045fb8fe3dd322067d62e7e2cd17bb8b92d748.zip)<br/>Descripción: Ejes_Y_Direcciones_IDE.zip<br/>Formato: shp<br/>SRID: 32721

#### Datos relevantes
* `numero` (hnum)

* `nombre` (via)

#### Otros datos relevantes
* `id`
* `idcalle`
* `cp`

<br/>Complementado por [address](#-address) a través de `idcalle` y `idcalle`

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-address.png" alt="address" width="20"/> address

Nombre del archivo: `Ejes_20241007_codigoISO`<br/>*Descarga* e integridad: [bb975aced997119b9b381f0b78045fb8fe3dd322067d62e7e2cd17bb8b92d748.zip](https://dl.digital-guard.org/bb975aced997119b9b381f0b78045fb8fe3dd322067d62e7e2cd17bb8b92d748.zip)<br/>Descripción: Ejes_Y_Direcciones_IDE.zip<br/>Formato: shp<br/>SRID: 32721

Complementos [geoaddress](#-geoaddress) a través de `idcalle` y `idcalle`

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/> via

Nombre del archivo: `Ejes_20241007_codigoISO`<br/>*Descarga* e integridad: [bb975aced997119b9b381f0b78045fb8fe3dd322067d62e7e2cd17bb8b92d748.zip](https://dl.digital-guard.org/bb975aced997119b9b381f0b78045fb8fe3dd322067d62e7e2cd17bb8b92d748.zip)<br/>Descripción: Ejes_Y_Direcciones_IDE.zip<br/>Formato: shp<br/>SRID: 32721

#### Datos relevantes
* `nombre` (via)

#### Otros datos relevantes
* `idcalle`
* `localidad`
* `departamento`
* `tipo_viali`
* `tipo_via_1`

# Evidencia de prueba
<img src="qgis.png" width="400"/>

</section>
<section>

# Reproducibilidad

Consulte los detalles en [reproducibility.sh](https://git.digital-guard.org/preserv-UY/blob/main/data/_pk0002.02/reproducibility.sh).

</section>

