##
## Template file reference: preserv-BR/data/RS/PortoAlegre/_pk0018.01
## tplId: 027a
##
tplInputSchema_id = 027a

## BASIC CONFIG
srid              = 4326
pg_io             = /tmp/pg_io
orig              = /var/www/dl.digital-guard.org
pg_uri            = postgres://postgres@localhost
pg_db             = ingest1
sandbox_root      = /tmp/sandbox
sandbox           = $(sandbox_root)/_pk85800000201_001
need_commands     = 7z v16+; psql v12+; shp2pgsql v3+; 

## COMPOSED VARS
pg_uri_db         = $(pg_uri)/$(pg_db)


all:
	@echo "=== Resumo deste makefile de recuperação de dados preservados ==="
	@printf "Targets para a geração de layers:\n\tall_layers geoaddress \n"
	@printf "Demais targets implementados:\n\tmakedirs clean clean_sandbox wget_files me readme delete_file\n"
# 	@echo "A geração de layers requer os seguintes comandos e versões:\n\t$(need_commands)"
	@printf "Targets de publicação de layers:\n"
	@printf "\tpublicating_geojsons_geoaddress audit-geojsons_geoaddress change_parameters_geoaddress\n"
	@printf "EXPERIMENTAL: target para publicar todos layers não cadastrais no cutGeo:\n\tall_publications\n"
	@printf "EXPERIMENTAL: target para gerar e subir na nuvem os filtrados de todos layers não cadastrais:\n\tall_filtered\n"

all_layers: geoaddress 
	@echo "-- ALL LAYERS --"
all_publications: publicating_geojsons_geoaddress 
	@echo "-- ALL PUBLICATIONS --"

all_filtered:
	@echo "-- Generate all filtered files --"
	@echo "Usage: make all_filtered pg_db=<ingest> packtpl_id=<packtpl_id>"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	@[ "${pg_db}" ] && bash -c "source $(preservSrc)/generateFiles.sh && gen_all $(pg_db) 85800000201 true" || ( echo "Unknown pg_db.")
	@echo "-- ALL FILTERED --"

## ## ## ## ## ## ## ## ##
## Make targets of the Project Digital Preservation
## Sponsored by Project AddressForAll






geoaddress: tabname = pk85800000201101_p1_geoaddress
geoaddress: makedirs
	@# pk0002.01_p1 - ETL extrating to PostgreSQL/PostGIS the geoaddress datatype
	@echo
	@echo "------------------------------------------"
	@echo "------ UY  ------"
	@echo "------ Layer tipo geoaddress_full  ------"
	@echo "-- Incluindo dados do arquivo-1 do package-85800000201101 na base $(pg_db) --"
	@echo " Nome-hash do arquivo-1: 2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip"
	@echo " Tabela do layer: pk85800000201101_p1_geoaddress"
	@echo " Sub-arquivos do arquivo-1 com o conteúdo alvo: *uniao*"
	@echo " Tema dos sub-arquivos: arquivos.zip"
	@echo "Run with tmux and sudo! (DANGER: seems not idempotent on psql)"
	@whoami
	@echo "Above user is root? If not, you have permissions for all paths?"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif

ifeq (,$(wildcard $(orig)/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip))
	@echo " File 2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip not exists in orig=$(orig)"
	@echo " Download file 2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip to $(orig) from dl.digital-guard.org?"
	@echo " If it doesn't download, inform the correct value of the orig variable."
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to download or Ctrl+C to quit or inform orig]" _press_enter_
endif
	@echo " Downloading file..."
	wget -P $(orig) http://dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
	@echo " Fix permissions ..."
	sudo chown postgres:www-data $(orig)/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
	@echo " Download completed."
endif

	psql $(pg_uri_db) -c "DROP FOREIGN TABLE IF EXISTS pk85800000201101_p1_geoaddress CASCADE"
	@tput bold
	@echo Extracting ....
	@tput sgr0
	cd $(sandbox); 7z  x -y $(orig)/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip "*uniao*" ; chmod -R a+rwx . > /dev/null
	@echo "Conferindo se SRID 4326 está configurado:"
	@psql $(pg_uri_db) -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	@echo Executando csv2sql ...
	psql $(pg_uri_db) -c "SELECT ingest.fdw_generate_direct_csv( '$(sandbox)/uniao.csv', 'pk85800000201101_p1_geoaddress' )"

	psql $(pg_uri_db) -c "CREATE VIEW vw1_pk85800000201101_p1_geoaddress AS SELECT row_number() OVER () AS gid, \
punto_wkb,codigo_postal AS postcode,codigo_via,nombre_via as via, \
concat(num_puerta, ' ', letra_puerta) as hnum, \
km,manzana,solar,nombre_inmueble,localidad as city_name, codigo_localidad, departamento, \
ST_SetSRID(ST_MakePoint(longitud::float,latitud::float),$(srid)) as geom \
FROM $(tabname)"
	
	psql $(pg_uri_db) -c "SELECT ingest.any_load('csv2sql','$(sandbox)/uniao.csv','geoaddress_full','vw1_pk85800000201101_p1_geoaddress','85800000201101','2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip',array[]::text[],1,1)"
	psql $(pg_uri_db) -c "DROP VIEW vw1_pk85800000201101_p1_geoaddress"
	@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
	psql $(pg_uri_db) -c "DROP FOREIGN TABLE IF EXISTS pk85800000201101_p1_geoaddress CASCADE"
	@echo FIM.

geoaddress-clean:
	rm -f $(sandbox)/*uniao.* || true

publicating_geojsons_geoaddress: isolabel   = UY
publicating_geojsons_geoaddress: folder     = /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress
publicating_geojsons_geoaddress: pretty_opt = 3
publicating_geojsons_geoaddress: view       = vw1_pk85800000201101_p1_geoaddress_publicating
publicating_geojsons_geoaddress:
	mkdir -m777 -p $(folder)
	@rm -rf $(folder)/*.geojson
	@echo "--- Gerando arquivos em $(folder) ---"
	psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('geoaddress','$(isolabel)','$(folder)','1',9,'$(pretty_opt)');"
	cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh $(folder)

audit-geojsons_geoaddress: folder = /var/gits/_dg/preservCutGeo-UY2021/data/_pk0002.01/geoaddress
audit-geojsons_geoaddress:
	@ls -lS   $(folder)/*.geojson | awk 'BEGIN {print "-- MÉDIA:"} $$5 {n=n+1;s=s+$$5;} END {print "\tnum arquivos: " n; print "\ttamanho médio: " s/(1024*n) " KiB" }'
	@ls -lhS  $(folder)/*.geojson | head | awk 'BEGIN {print "-- MAIORES:"} $$5 {print $$5 " | " $$9;}'
	@ls -lhSr $(folder)/*.geojson | head | awk 'BEGIN {print "-- MENORES:"} $$5 {print $$5 " | " $$9;}'

change_parameters_geoaddress: isolabel      = UY
change_parameters_geoaddress:
	psql $(pg_uri_db) -c "UPDATE ingest.donated_packcomponent SET lineage = jsonb_set(lineage, '{hcode_distribution_parameters}', '{\"p_threshold_sum\": $(threshold_sum)}', TRUE) WHERE id = (SELECT id FROM ingest.vw03full_layer_file WHERE isolabel_ext='$(isolabel)' AND ft_info->>'class_ftname'='geoaddress');"

	make publicating_geojsons_geoaddress









## ## ## ## ## ## ## ## ##

makedirs: clean_sandbox
	@mkdir -m 777 -p $(sandbox_root)
	@mkdir -m 777 -p $(sandbox)
	@mkdir -p $(pg_io)

wget_files:
	@echo "Under construction, need to check that orig path is not /var/www! or use orig=x [ENTER if not else ^C]"
	@echo $(orig)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
	mkdir -p $(orig)
	@cd $(orig); wget http://dl.digital-guard.org/2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip && chmod o+rw 2939e7ae1ee8801dd10619301ec034afb5c37d68b440a4d3f2b8416d30c1c13b.zip
	@echo "Please, if orig not default, run 'make _target_ orig=$(orig)'"

## ## ## ## ## ## ## ## ##

clean_sandbox:
	@rm -rf $(sandbox) || true

clean: geoaddress-clean 

## ############################ ##
## SELF-GENERATE MAKE (make me) ##
## ############################ ##

mkme_input    = $(shell ls -d "${PWD}/"make_conf.yaml)
country       = $(shell ls -d "${PWD}" | cut -d'-' -f2 | cut -d'/' -f1)
baseSrc       = /var/gits/_dg
baseSrcPack   = $(shell ls -d "${PWD}")
preservSrc    = $(baseSrc)/preserv/src

mkme_input0   = $(baseSrc)/preserv-$(country)/src/maketemplates/commomFirst.yaml

ifeq ($(shell ls -d "${PWD}" | grep "-"),)
country       = INT
mkme_input0   = $(preservSrc)/maketemplates/commomFirst.yaml
endif

pg_io         = $(shell grep 'pg_io'   < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pg_uri        = $(shell grep 'pg_uri'  < $(mkme_input0) | cut -f2- -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pg_db         = $(shell grep 'pg_db'   < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
orig          = $(shell grep 'orig'    < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pack_id       = $(shell grep 'pack_id' < $(mkme_input)  | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')

pg_uri_db     = $(pg_uri)/$(pg_db)

tmpfile       = $(pg_io)/tmpfile_$(country)$(pack_id)

info:
	@echo "=== Targets ==="
	@printf "info: resumo dos targets.\n"
	@printf "me: gera makefile para ingestão de make_conf.yaml.\n"
	@printf "readme: gera README.md do pacote de dados.\n"
	@printf "insert_size: insere size bytes em files de make_conf.yaml.\n"
	@printf "insert_license: insere detalhes sobre licenças em make_conf.yaml.\n"
	@printf "delete_file: deleta layer ingestado. Uso: make delete_file id=<id do layer em ingest.donated_PackComponent> pg_db=<ingest>\n"
	@printf "generate_filtered_files: gera filtrados do layer. Uso: make generate_filtered_files id=<id do layer em ingest.donated_PackComponent> pg_db=<ingest>. \n"
	@printf "me_reproducibility: gera reproducibility.sh. Uso: make me_reproducibility pg_db=<ingest> \n"

me:
	@echo "-- Generating makefile --"
	cd $(preservSrc); make generate_makefile country=$(country) pack_id=$(pack_id) baseSrcPack=$(baseSrcPack) baseSrc=$(baseSrc) output=$(tmpfile)
	sudo chmod 777 $(tmpfile)
	@echo " Check diff, the '<' lines are the new ones. Something changed?"
	@diff $(tmpfile) ./makefile || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(tmpfile) ./makefile"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	mv $(tmpfile) ./makefile

me_reproducibility:
	@echo "-- Generating reproducibility.sh --"
	cd $(preservSrc); make generate_reproducibility country=$(country) pack_id=$(pack_id) baseSrcPack=$(baseSrcPack) baseSrc=$(baseSrc) output=$(tmpfile)
	sudo chmod 777 $(tmpfile)
	@echo " Check diff, the '<' lines are the new ones. Something changed?"
	@diff $(tmpfile) ./reproducibility.sh || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(tmpfile) ./reproducibility.sh"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	mv $(tmpfile) ./reproducibility.sh

readme:
	@echo "-- Generating README.md --"
	cd $(preservSrc); make generate_readme country=$(country) pack_id=$(pack_id) baseSrcPack=$(baseSrcPack) baseSrc=$(baseSrc) output=$(tmpfile)
	sudo chmod 777 $(tmpfile)
	@echo " Check diff, the '<' lines are the new ones. Something changed?"
	@diff $(tmpfile) ./README.md || :
	@echo "If some changes, and no error in the changes, move the readme:"
	@echo " mv $(tmpfile) ./README.md"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	mv $(tmpfile) ./README.md

insert_size:
	@echo "-- Inserting size in files of make_conf --"
	cd $(preservSrc); make insert_size country=$(country) pack_id=$(pack_id) baseSrcPack=$(baseSrcPack) baseSrc=$(baseSrc) output=$(tmpfile) orig=$(orig)
	sudo chmod 777 $(tmpfile)
	@echo " Check diff, the '<' lines are the new ones. Something changed?"
	@diff $(tmpfile) ./make_conf.yaml || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(tmpfile) ./make_conf.yaml"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	mv $(tmpfile) ./make_conf.yaml

insert_license:
	@echo "-- Inserting files_licenses in make_conf --"
	cd $(preservSrc); make insert_license country=$(country) pack_id=$(pack_id) baseSrcPack=$(baseSrcPack) baseSrc=$(baseSrc) output=$(tmpfile)
	sudo chmod 777 $(tmpfile)
	@echo " Check diff, the '<' lines are the new ones. Something changed?"
	@diff $(tmpfile) ./make_conf.yaml || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(tmpfile) ./make_conf.yaml"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	mv $(tmpfile) ./make_conf.yaml

delete_file:
	@echo "-- Deleting donated donated packcomponent --"
	@echo "Usage: make delete_file id=<id de donated_packcomponent> pg_db=<ingest>"
	@echo "id: $(id)"
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
	@[ "${id}" ] && psql $(pg_uri_db) -c "DELETE FROM ingest.donated_packcomponent WHERE id = $(id)" || ( echo "Unknown id.")

generate_filtered_files:
	@echo "-- Generate filtered files --"
	@echo "Usage: make generate_filtered_files id=<id of file in ingest.donated_PackComponent> pg_db=<ingest>"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	@[ "${id}" ] && bash -c "source $(preservSrc)/generateFiles.sh && generate_filtered_files $(pg_db) $(id) true " || ( echo "Unknown id.")
