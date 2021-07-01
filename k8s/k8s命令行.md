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
  kubectl describe pod kipf-brat-d97d77dc9-s5dkz -n del
  ```

- 

