URL="websphere-liberty:22.0.0.6-full-java17-openj9"
image="liberty-webprofile-22"
echo "... stop contianer"
docker stop $image
echo "... rm container"
docker rm $image
echo "... rmi image"
docker rmi $image:latest
echo "docker build ..."
#docker build --tag $image .
docker build --build-arg imageBase=$URL --tag $image .
echo "... docker run"
docker -D run -p 9080:9080 -p 7777:7777 -e JAVA_TOOL_OPTIONS="-agentlib:jdwp=transport=dt_socket,address=7777,server=y,suspend=n" --name $image $image