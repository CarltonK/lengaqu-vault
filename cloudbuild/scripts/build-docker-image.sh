echo
echo "***************"
echo "* Build Image *"
echo "***************"
echo

cd /workspace
docker build -f cloud-run/Dockerfile \
    -t $1-docker.pkg.dev/$2/$3/vault-server:$4