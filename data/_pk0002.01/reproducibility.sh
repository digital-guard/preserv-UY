#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk85800000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk85800000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk85800000201101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk85800000201_001; 7z  x -y /var/www/dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip "*uniao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk85800000201_001/uniao.csv', 'pk85800000201101_p1_geoaddress' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk85800000201101_p1_geoaddress AS SELECT row_number() OVER () AS gid, \
punto_wkb,codigo_postal AS postcode,codigo_via,nombre_via as via, \
concat(num_puerta, ' ', letra_puerta) as hnum, \
km,manzana,solar,nombre_inmueble,localidad as city_name, codigo_localidad, departamento, \
ST_SetSRID(ST_MakePoint(longitud::float,latitud::float),$(srid)) as geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/uniao.csv','geoaddress_full','vw1_pk85800000201101_p1_geoaddress','85800000201101','2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk85800000201101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk85800000201101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk85800000201_001/*uniao.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','UY','/var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress -type f -exec chmod 664 {} \;







