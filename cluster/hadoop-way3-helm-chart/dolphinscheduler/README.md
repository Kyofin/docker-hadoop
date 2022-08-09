# 安装卸载
```shell
helm install dolphinscheduler . -n bigdata-dev  
helm uninstall dolphinscheduler  -n bigdata-dev  
```
# 调试镜像
如果想看看镜像里是否包含自己加的依赖，可以用 test-ds-lib.yaml跑一个pod，然后进去看
