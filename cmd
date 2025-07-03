CONVERTED_RESOURCES=TF_OUTPUT_FILE

docker run --rm -it --workdir=/convert \
--volume=$(pwd):/convert \
$DM_CONVERT_IMAGE \
--config my_deployment.yaml \
--output_format TF \
--output_file TF_OUTPUT_FILE \
--output_tf_import_file TF_OUTPUT_IMPORT_FILE \
--deployment_name test_deployment \
--project_id $PROJECT_ID