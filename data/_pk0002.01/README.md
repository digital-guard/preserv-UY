<aside>
<table align="right" style="padding: 1em">
<tr><td>Paquete <a target="_git" title="Enlace canónico a git para este paquete." href="http://git.digital-guard.org/preserv-UY/blob/main/data/_pk0002.01"><big><b>pk0002.01</b></big></a> de <small><a target="_osmcodes" title="Jurisdicción" href="https://osm.codes/UY">UY</a></small>
</td></tr>
<tr><td>
Donante: <a rel="external" target="_doador" href="https://catalogodatos.gub.uy/dataset/ide-direcciones-geograficas-del-uruguay">Correo Uruguayo</a><br/>
<small>vatid:</small> • Wikidata <a rel="external" target="_doador" title="Enlace del descriptor Wikidata del donante" href="https://www.wikidata.org/wiki/Q5172888">Q5172888</a></small><br/>
Licencia <a rel="external" target="_doador" href="http://www.opendefinition.org/licenses/odc-odbl"><b>ODbL-1.0</b></a> (odbl <a title="SHA256 http://web.archive.org/web/20220418172356/https://opendatacommons.org/licenses/odbl/" href="http://web.archive.org/web/20220418172356/https://opendatacommons.org/licenses/odbl/"><code>webarchive</code></a>)
Obtido via <i>email;site</i> em <b>1900-01-01</b> por:<br/>
 Avaliação técnica: <a rel="external" target="_gitPerson" title="Usuario de Git" href="https://github.com/luisfelipebr">luisfelipebr</a><br/>
 Representação institucional: <a rel="external" target="_gitPerson" title="Usuario de" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="geoaddress" href="#-geoaddress"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-UY2021/tree/main/data/_pk0002.01">Datos publicados</a></td></tr>
</table>
</aside>

<section>

Este repositorio de metadatos describe un paquete de archivos donados al dominio público. Está siendo conservado por Digital Guard: para obtener más detalles, consulte la [documentación sobre el proceso de registro y conservación](https://git.digital-guard.org/preserv/tree/main/docs).

Nota. Este documento README fue generado por software a partir de la información contenida en el archivo [`make_conf.yaml`](make_conf.yaml) en este paquete, e información adicional de los catálogos de [donantes](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) y [paquetes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Capas de datos

Los archivos contienen "capas de datos" temáticas. Los metadatos también describen cómo se evaluó cada capa y cómo se filtraron sus datos de forma estandarizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/> geoaddress

Nombre del archivo: `uniao`.<br/>*Descarga* e integridad: [2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip](http://dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip)<br/>Descripción: arquivos.zip<br/>Formato: csv<br/>SRID: 4326

#### Datos relevantes
* `concat(num_puerta, ' ', letra_puerta)` (hnum)

* `nombre_via` (via)

* `localidad` (city_name)

#### Otros datos relevantes
* `punto_wkb`
* `km`
* `manzana`
* `solar`
* `nombre_inmueble`
* `codigo_localidad`
* `departamento`

#### Datos publicados
[http://git.digital-guard.org/preservCutGeo-UY2021/tree/main/data/_pk0002.01/geoaddress](http://git.digital-guard.org/preservCutGeo-UY2021/tree/main/data/_pk0002.01/geoaddress)<br/>51549815 bytes (49.16 <abbr title="mebibyte">MiB</abbr>)<br/>958576 pontos<br/>densidad media de 900.55 pontos/km²

# Evidencia de prueba
<img src="evidencia.png" width="400"/>

</section>
<section>

# Reproducibilidad

```bash

geoaddress:
rm -rf /tmp/sandbox/_pk85800000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk85800000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
psql $(pg_uri_db) -c "DROP FOREIGN TABLE IF EXISTS pk85800000201101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk85800000201_001; 7z  x -y /var/www/dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip "*uniao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk85800000201_001/uniao.csv', 'pk85800000201101_p1_geoaddress' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk85800000201101_p1_geoaddress AS SELECT row_number() OVER () AS gid, \
punto_wkb,codigo_postal,codigo_via,nombre_via as via, \
concat(num_puerta, ' ', letra_puerta) as hnum, \
km,manzana,solar,nombre_inmueble,localidad as city_name, codigo_localidad, departamento, \
ST_SetSRID(ST_MakePoint(longitud::float,latitud::float),$(srid)) as geom \
FROM $(tabname)"
psql $(pg_uri_db) -c "SELECT ingest.any_load('csv2sql','$(sandbox)/uniao.csv','geoaddress_full','vw1_pk85800000201101_p1_geoaddress','85800000201101','2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk85800000201101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk85800000201101_p1_geoaddress"
rm -f "/tmp/sandbox/_pk85800000201_001/*uniao.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk85800000201101_p1_geoaddress CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('geoaddress','UY','/var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress

```
</section>

