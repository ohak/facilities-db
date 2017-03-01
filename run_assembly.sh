################################################################################################
## ASSEMBLY
################################################################################################
## This script runs all the scripts which match up the desired fields to the FacDB schema and
## recodes variables. NOTE: This script requires that you setup the DATABASE_URL environment variable. 
## Directions are in the README.md.

# STEP 1
# load all datasets from sources using civic data loader
# https://github.com/NYCPlanning/civic-data-loader

# # open_datasets - PULLING FROM OPEN DATA
echo 'Loading open source datasets...'
# 	# Data you probably already have loaded
# 	node loader.js install dcp_mappluto
# 	node loader.js install doitt_buildingfootprints
# 	node loader.js install dpr_parksproperties
# 	# Data you probably don't have loaded
	# node loader.js install bic_facilities_tradewaste
	# node loader.js install dca_facilities_operatingbusinesses
	# node loader.js install dcla_facilities_culturalinstitutions
	# node loader.js install dcp_facilities_sfpsd
	# node loader.js install dhs_facilities_shelters
	# node loader.js install dfta_facilities_contracts
	# node loader.js install doe_facilities_busroutesgarages
	# node loader.js install doe_facilities_universalprek
	# node loader.js install dohmh_facilities_daycare
	# node loader.js install hhc_facilities_hospitals
	# node loader.js install nycha_facilities_policeservice
	# node loader.js install nysdec_facilities_lands
	# node loader.js install nysdec_facilities_solidwaste
	# node loader.js install nysdoh_facilities_healthfacilities
	# node loader.js install nysdoh_nursinghomebedcensus
	# node loader.js install nysomh_facilities_mentalhealth
	# node loader.js install nysopwdd_facilities_providers
	# node loader.js install nysparks_facilities_historicplaces
	# node loader.js install nysparks_facilities_parks
	# node loader.js install usdot_facilities_airports # script didn't work
	# node loader.js install usdot_facilities_ports # script didn't work
	# node loader.js install usnps_facilities_parks
echo 'Done loading open source datasets. Moving on to "other" datasets...'
# # other_datasets - PULLING FROM FTP SITE
	# node loader.js install acs_facilities_daycareheadstart
# 	node loader.js install dcas_facilities_colp
# 	node loader.js install doe_facilities_schoolsbluebook
# 	node loader.js install dot_facilities_pedplazas
# 	node loader.js install dot_facilities_publicparking ##Kind of open, need to see if url can be worked out
# 	node loader.js install dsny_facilities_mtsgaragemaintenance
# 	node loader.js install facilities_togeocode ##Addresses copied and pasted from websites
# 	node loader.js install foodbankny_facilities_foodbanks
# 	node loader.js install hhs_facilities_acceleratorall ##Actually is open but need to ask about url
	# node loader.js install nysoasas_facilities_programs ##Being shared with us monthly by email in xlsx
	# node loader.js install nysed_facilities_activeinstitutions ##Actually is open but need to figue out url
# 	node loader.js install nysed_nonpublicenrollment ##Actually is open but in xlsx that needs to be formatted
# 	node loader.js install omb_facilities_libraryvisits
echo 'Done loading other source datasets'

# STEP 2
# create empty master table with facilities db schema

echo 'Creating empty facilities table...'
psql $DATABASE_URL -f ./scripts_assembly/create.sql
echo 'Done creating empty facilities table'

# STEP 3
# configure (transform) each dataset and insert into master table

echo 'Transforming and inserting records from source data'
psql $DATABASE_URL -f ./scripts_assembly/config_acs_facilities_daycareheadstart.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_bic_facilities_tradewaste.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dca_facilities_operatingbusinesses.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_dcas_facilities_colp.sql ##Needs to be joined to geom
psql $DATABASE_URL -f ./scripts_assembly/config_dcla_facilities_culturalinstitutions.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_dcp_facilities_sfpsd.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dhs_facilities_shelters.sql
psql $DATABASE_URL -f ./scripts_assembly/config_dfta_facilities_contracts.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_doe_facilities_busroutesgarages.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_doe_facilities_universalprek.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_doe_facilities_schoolsbluebook.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dohmh_facilities_daycare.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_dot_facilities_pedplazas.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dot_facilities_bridgehouses.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dot_facilities_ferryterminalslandings.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dot_facilities_mannedfacilities.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dot_facilities_parkingfacilities.sql ##OK
# psql $DATABASE_URL -f ./scripts_assembly/config_dot_facilities_publicparking.sql ##Superceded by new data from DOT but may be used for supplmental capacity #s
psql $DATABASE_URL -f ./scripts_assembly/config_dpr_facilities_parksproperties.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dsny_facilities_mtsgaragemaintenance.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_dycd_facilities_compass.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_dycd_facilities_otherprograms.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_foodbankny_facilities_foodbanks.sql ##OK
# psql $DATABASE_URL -f ./scripts_assembly/config_hhc_facilities_hospitals.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_hhs_facilities_acceleratorall.sql ##OK need to review facility categories
psql $DATABASE_URL -f ./scripts_assembly/config_hra_facilities_centers.sql
# psql $DATABASE_URL -f ./scripts_assembly/config_nycha_facilities_communitycenters.sql ##Not using yet - Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_nycha_facilities_policeservice.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysoasas_facilities_programs.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_nysdec_facilities_lands.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysdec_facilities_solidwaste.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysdoh_facilities_healthfacilities_joinnursingbeds.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysed_facilities_activeinstitutions.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysomh_facilities_mentalhealth.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysopwdd_facilities_providers.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysparks_facilities_historicplaces.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_nysparks_facilities_parks.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_omb_facilities_libraryvisits.sql
psql $DATABASE_URL -f ./scripts_assembly/config_sbs_facilities_workforce1.sql ##Needs to be geocoded
psql $DATABASE_URL -f ./scripts_assembly/config_usdot_facilities_airports.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_usdot_facilities_ports.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_usnps_facilities_parks.sql ##OK
psql $DATABASE_URL -f ./scripts_assembly/config_facilities_togeocode.sql ##Needs to be geocoded
echo 'Done transforming and inserting records from source data'

## STEP 4 
## Joining on source data info and standardizing capitalization
psql $DATABASE_URL -f ./scripts_assembly/join_sourcedatainfo.sql
echo 'Cleaning up capitalization, standardizing values, and adding agency tags in arrays...'
psql $DATABASE_URL -f ./scripts_assembly/standardize_fixallcaps.sql
psql $DATABASE_URL -f ./scripts_assembly/standardize_capacity.sql
psql $DATABASE_URL -f ./scripts_assembly/standardize_oversightlevel.sql
psql $DATABASE_URL -f ./scripts_assembly/standardize_agencytag.sql
psql $DATABASE_URL -f ./scripts_assembly/standardize_trim.sql
psql $DATABASE_URL -f ./scripts_assembly/standardize_factypes.sql
## Standardizing borough and assigning borough code
psql $DATABASE_URL -f ./scripts_assembly/standardize_borough.sql
## Switching One to 1 for geocoding and removing invalid (string) address numbers
psql $DATABASE_URL -f ./scripts_assembly/standardize_address.sql

## STEP 5
## Fill in the uid for all new records in the database
psql $DATABASE_URL -f ./scripts_assembly/create_uid.sql


