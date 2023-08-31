echo "Building ruby $1 and proj $2"
docker build --build-arg PROJ_VERSION=$2 --build-arg RUBY_VERSION=$1 -t aeroscan/ruby-proj:$1_$2-fullstaq .
docker push aeroscan/ruby-proj:$1_$2-fullstaq
