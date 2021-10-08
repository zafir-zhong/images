#! /bin/bash

image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}
baseDirForScriptSelf=$(cd "$(dirname "$0")"; pwd)
echo "now in: "${baseDirForScriptSelf}
echo -e "\n*************************************************"
echo -e ">>> will pull this image from: registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} <<<"
echo -e "*************************************************\n"
docker pull registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
imageMsg=`docker images | grep ${gen_image}`
if [ -n "${imageMsg}" ];
then
  echo -e "\n*************************************************"
  echo -e ">>> download successfully! <<<"
  echo -e "*************************************************\n"
  docker tag registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} ${image}
  docker rmi registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
  echo -e "\n*************************************************"
  echo -e ">>>tags successfully! <<<"
  echo -e "*************************************************\n"
else
  echo -e "\n*************************************************"
  echo -e ">>> pull fail try commit and download! <<<"
  echo -e "*************************************************\n"
  ${baseDirForScriptSelf}/commit.sh ${image}
  for((i=1;i<=10;i++));
         do   
           echo -e "\n*************************************************"
           echo -e ">>> wait 10s to download! <<<"
           echo -e "*************************************************\n"
           sleep 10s
           ${baseDirForScriptSelf}/download.sh ${image} 2>&1
           imageMsg=`docker images | grep ${gen_image}`
           if [ "${imageMsg}" != "" ]; 
           then
             echo -e "\n*************************************************"
             echo -e ">>> download successfully! <<<"
             echo -e "*************************************************\n"
             break;
           else 
             echo -e "\n*************************************************"
             echo -e ">>> download fail, will try it again! <<<"
             echo -e "*************************************************\n"
           fi
         done
  if [ "${imageMsg}" != "" ]; 
  then
    echo -e "\n*************************************************"
    echo -e ">>> download fail, please wait a minute ! <<<"
    echo -e "*************************************************\n"
  fi
fi
