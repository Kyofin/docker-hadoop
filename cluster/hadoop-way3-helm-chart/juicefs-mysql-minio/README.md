```shell
docker run -p 9100:9100 -d -e  META_URL="mysql://root:eWJmP7yvpccHCtmVb61Gxl2XLzIrRgmT@(10.119.93.158:3306)/juicefs2_meta_minio" \
-e   STORAGE="minio" \
-e   BUCKET:="http://10.119.93.158:9000/myjfs2"  \
-e   ACCESS_KEY="AKIAIOSFODNN7EXAMPLE"  \
-e   SECRET_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" juicefs-mysql-minio:1.0.0-rc2
```
