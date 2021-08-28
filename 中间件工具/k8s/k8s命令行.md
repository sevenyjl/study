---
title: k8s命令行

author: seven

avatar: https://sevenpic.oss-cn-beijing.aliyuncs.com/img/seven.jpg

authorLink: yjl.cool

authorAbout: 不懂猫，更不懂开发的人

authorDesc: 

categories: 技术

comments: true

date: 2021-08-23 22:20:28

tags: 

keywords: 

description: null

photos: null

---
1.下载k8s命令行

2.常用k8s命令

- 删除所以pods

  ```shell
  kubectl get pods -n default | grep Evicted | awk '{print $1}' | xargs kubectl delete pods -n default
  # -n 指定命名空间, grep 搜索条件
  ```

- 删除所有deployment

  ```shell
  kubectl get deployment -n default | awk '{print $1}' | xargs kubectl delete deployment -n default
  # -n 指定命名空间, grep 搜索条件
  ```

- 删除pvc

  ```shell
  kubectl patch pvc kipf-pvc -p '{"metadata":{"finalizers":null}}'
  # kipf-pvc pvc名称
  ```

- 删除pv

  ```shell
  kubectl patch pv kipf-volume -p '{"metadata":{"finalizers":null}}'
  # kipf-volume pv名称
  ```

- 查看pod状况

  ```shell
  kubectl describe pod <pod-name> -n <namesapce>
  ```

- 查看服务日志

  ```shell
  kubectl logs -f --tail=100 <pod-name> -n <namesapce>
  ```

  ```shell
  kubectl logs -f --tail=100 $(kubectl get pods -n <namesapce> | grep <simple-pod-name> | awk '{print $1}') -n <namesapce>
  ```

- 查看命名空间依赖资源

  ```shell
  kubectl api-resources -o name --verbs=list --namespaced | xargs -n 1 kubectl get --show-kind --ignore-not-found -n  <namesapce>
  ```

- k8s进入pod容器

  ```
  
  ```

- 

```
kubectl cp xxx kipf/xxx:x
```

