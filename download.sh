#! /bin/bash

image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}

echo -e "\n*************************************************"
echo ">>> will download this image from: registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} <<<"
echo -e "*************************************************\n"
docker pull registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
docker tag registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image} ${image}
docker rmi registry.cn-hangzhou.aliyuncs.com/zafir-zhong/images:${gen_image}
echo -e "\n*************************************************"
echo -e ">>> download shell finish! <<<"
echo -e "*************************************************\n"