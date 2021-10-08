#! /bin/bash

image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}
baseDirForScriptSelf=$(cd "$(dirname "$0")"; pwd)
cd ${baseDirForScriptSelf}
git checkout .
git pull
thisTag=`git tag --list | grep 'release-v${gen_image}'`
if [ "${thisTag}" != "" ];
then
  echo -e "\n*************************************************"
  echo ">>> already tag , go on <<< "
  echo -e "*************************************************\n"
  exit 0
fi
echo "From ${image}" > Dockerfile
echo -e "\n*************************************************"
echo ">>> Dockerfile has changed to :【"`cat Dockerfile`"】<<< "
echo -e ">>> start to commit change for image: "${image}" <<<"
echo -e "*************************************************\n"
git add .
git commit -m "add images '${image}'"
git tag release-v${gen_image}
git push --tags
echo -e "\n*************************************************"
echo -e ">>> commit successfully! <<"
echo -e "You can download image by following command:\n"
echo -e ${baseDirForScriptSelf}"/download.sh ${image}\n"
echo "If download failed after a long time, please submit a issue at: https://github.com/zafir-zhong/images/issues"
echo -e "*************************************************\n"
