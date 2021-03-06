################################################################################################
## EXPORTING
################################################################################################
## NOTE: This script requires that your setup the DATABASE_URL environment variable. 
## Directions are in the README.md.

time psql -d capdb -U dbadmin -f ./5_export/censor.sql
echo 'Exporting FacDB tables...'
time psql -d capdb -U dbadmin -f ./5_export/export.sql
time psql -d capdb -U dbadmin -f ./5_export/export_allbeforemerging.sql
time psql -d capdb -U dbadmin -f ./5_export/export_unmapped.sql
time psql -d capdb -U dbadmin -f ./5_export/export_datasources.sql
time psql -d capdb -U dbadmin -f ./5_export/export_uid_key.sql
echo 'Exporting tables for mkdocs...'
time psql -d capdb -U dbadmin -f ./5_export/mkdocs_datasources.sql
echo 'All done!'