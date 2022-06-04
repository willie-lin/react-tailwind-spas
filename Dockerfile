# 使用 node 镜像
FROM node:16 AS build
# 设置容器内的目录，通常我们会使用 app 目录
WORKDIR /app
# 项目文件拷贝到容器 /app 下
COPY . .
# 下载依赖包，并构建打包文件
RUN yarn && yarn build

# 使用 nginx 镜像
FROM nginx
# 跳转到 nginx 的 80 静态服务对应的目录
WORKDIR /usr/share/nginx/html
# 删掉里面的文件
RUN rm -rf ./*
# 将我们在 node 镜像的打包文件拷贝到这里
COPY --from=build /app/build .