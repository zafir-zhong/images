#! /bin/bash

image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}

echo -e "*************************************************"
echo -e ">>> will pull this image from: registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} <<<"
echo -e "*************************************************\n"
docker pull registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
imageMsg=`docker images | grep ${gen_image}`
if [ -n "${imageMsg}" ];
then
  echo -e "*************************************************"
  echo -e ">>> download successfully! <<<"
  echo -e "*************************************************\n"
  docker tag registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} ${image}
  docker rmi registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
  echo -e "*************************************************"
  echo -e ">>>tags successfully! <<<"
  echo -e "*************************************************\n"
else
  echo -e "*************************************************"
  echo -e ">>> pull fail try commit and download! <<<"
  echo -e "*************************************************\n"
  ./commit.sh ${image}
  for((i=1;i<=30;i++));
         do   
           echo -e "*************************************************"
           echo -e ">>> wait 10s to download! <<<"
           echo -e "*************************************************\n"
           sleep 10s
           ./download.sh ${image} 2>&1
           imageMsg=`docker images | grep ${gen_image}`
           if [ "${imageMsg}" != "" ]; 
           then
             echo -e "*************************************************"
             echo -e ">>> download successfully! <<<"
             echo -e "*************************************************\n"
             break;
           fi
         done
fi
