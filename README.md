# images
一个用于下载外网镜像的仓库
使用方式：
0. 把仓库改到自己的github
1. 使用[阿里云镜像仓库](https://cr.console.aliyun.com/cn-hangzhou/instance/repositories)
2. 新建仓库
![image](https://user-images.githubusercontent.com/56342869/230811962-e2f6883d-9c54-4e0f-96f0-b96e96e1cca2.png)
3. 选择github,完成授权
![image](https://user-images.githubusercontent.com/56342869/230812097-287ee13e-27c5-44e4-a455-e7dc589e7dd9.png)
4. 修改download.sh和pullImage.sh中的路径配置项
![image](https://user-images.githubusercontent.com/56342869/230812390-0268cf3f-54a1-4ffb-a822-b8386d578879.png)
![image](https://user-images.githubusercontent.com/56342869/230812468-d3f69b90-c623-4dc3-a02b-8202502373c6.png)

5. 实际使用
```bash
bash ./commit.sh Image:tag
bash ./download.sh Image:tag
```




