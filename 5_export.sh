################################################################################################
## EXPORTING
################################################################################################
## This file runs all the scripts which geocode and process all the assembled data
## NOTE: This script requires that your setup the DATABASE_URL environment variable. 
## Directions are in the README.md.

echo 'Exporting...'
time psql $DATABASE_URL -f ./scripts_processing/export.sql
time psql $DATABASE_URL -f ./scripts_processing/export_allbeforemerging.sql
time psql $DATABASE_URL -f ./scripts_processing/export_unmapped.sql
echo 'All done!'
