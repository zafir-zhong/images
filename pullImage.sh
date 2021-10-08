#! /bin/bash

image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}


echo "will pull this image from: registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}"
docker pull registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
imageMsg=`docker images | grep ${gen_image}`
if [ -n "${imageMsg}" ];
then
  echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> download successfully!\n"
  docker tag registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} ${image}
  docker rmi registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
  echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> tags successfully!\n"
else
  echo -e ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pull fail try commit and download!\n"
  ./commit.sh ${image}
  ./download.sh ${image}
fi
