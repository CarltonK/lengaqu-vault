echo
echo "***********************"
echo "* Set Backend project *"
echo "***********************"
echo

gcloud config set project $1

gcloud config set run/region $2

echo
echo "*************************"
echo "* Variable subsitituion *"
echo "*************************"
echo

awk '{gsub(/<GOOGLE_PROJECT>/,"'$1'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<SERVICE_NAME>/,"'$3'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<MAX_SCALE>/,"'$4'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<MIN_SCALE>/,"'$5'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<VAULT_CONTAINER_IMAGE>/,"'$6'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<VAULT_SA>/,"'$7'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<GOOGLE_STORAGE_BUCKET>/,"'$8'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<VAULT_GCPCKMS_SEAL_KEY_RING>/,"'$9'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml
awk '{gsub(/<WORKSPACE>/,"'${10}'")}1' /workspace/service.yaml >/workspace/tmp.yaml && mv /workspace/tmp.yaml /workspace/service.yaml

echo
echo "**********"
echo "* Deploy *"
echo "**********"
echo

yes | gcloud beta run services replace service.yaml --platform=managed