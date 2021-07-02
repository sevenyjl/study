nacos集群模式一键部署文档

下载地址：[nacos.tar.gz](https://github-releases.githubusercontent.com/137451403/44561400-a993-11ea-9679-f563f3afb136?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210702%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210702T070910Z&X-Amz-Expires=300&X-Amz-Signature=d5b2f414e2c42a7fe4069d0cfe09bfa6451ed128a2802a4c009d2ff4f35cc50a&X-Amz-SignedHeaders=host&actor_id=50271500&key_id=0&repo_id=137451403&response-content-disposition=attachment%3B%20filename%3Dnacos-server-1.3.0.tar.gz&response-content-type=application%2Foctet-stream)

1.上传nacos.tar.gz

2.在nacos的解压目录nacos/的conf目录下，有配置文件cluster.conf，请每行配置成ip:port。（请配置3个或3个以上节点）