IMAGES=$(docker-compose -f docker-compose.tmp.yml -f docker-compose.dev.yml images -q)
SERVICES=$(docker-compose -f docker-compose.tmp.yml -f docker-compose.dev.yml ps --services)


zip34() { while read -ra word3 <&3; do read -ra word4 <&4 ; echo $word3 $word4 ; done }

zip34 3<<<"${SERVICES}" 4<<<"${IMAGES}" > ids.txt


docker save -o ./save-test.tar $IMAGES


cat docker-compose.tmp.yml > docker-compose.yml
name=0
imageId=0
for curr in `cat ids.txt`
do
 if [[ $name = 0 ]]
 then
	name=$curr;
 else
  imageId=$curr
  sed -i "s/${name}-image-id/${imageId}/" docker-compose.yml;
  echo $name $imageId;
  name=0
 fi
done