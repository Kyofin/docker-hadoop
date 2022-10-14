
## 安装卸载
```shell
helm install volcano . -n bigdata-dev
helm uninstall volcano  -n bigdata-dev
```

## 测试添加队列和job
```shell
 kubectl apply -f test/job.yaml -n bigdata-dev
  kubectl apply -f test/queue.yaml  -n bigdata-dev 
```

## 检查队列
```shell
kubectl get queue   -n bigdata-dev   
 kubectl get queue test -oyaml -n bigdata-dev
```

## 检查podgroup
```shell
kubectl get podgroup  -n bigdata-dev
kubectl get podgroup job-1-6d144c83-7760-422e-a063-25869d671a4c  -n bigdata-dev  -oyaml       

```

## 检查job
```shell
kubectl get vcjob   -n bigdata-dev
kubectl get vcjob job-1 -oyaml -n bigdata-dev   
```