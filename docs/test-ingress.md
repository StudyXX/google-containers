### 测试ingress-nginx/ingress-traefik服务是否正常运行

    测试ingress-controller服务是否正常运行的办法有很多，这里部署一个真实的应用来确认该服务是可以正常运行的。

**首先，部署一个应用**

创建`test-nginx.yaml`文件并输入以下内容，然后执行`kubectl apply -f test-nginx.yaml`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: test
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: test-nginx
  namespace: test
spec:
  replicas: 1
  selector:
    name: nginx-lib
  template:
    metadata:
      labels:
        name: nginx-lib
    spec:
      containers:
        - name: nginx-lib
          image: nginx:1.8
          ports:
            - containerPort: 80
```

执行`kubectl get pods -n test -o wide --watch`命令等待nginx启动完成。

**然后，创建一个Service**

创建`test-nginx-service.yaml`文件并输入以下内容，然后执行`kubectl apply -f test-nginx-service.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: test-nginx
  namespace: test
spec:
  ports:
    - name: web
      port: 80
  selector:
    name: nginx-lib
```
执行`kubectl get svc -n test`命令查看Service是否创建成功。

***最后，创建一个Ingress***

创建`test-nginx-ingress.yaml`文件并输入以下内容，然后执行`kubectl apply -f test-nginx-ingress.yaml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: test-nginx
  namespace: test
spec:
#   tls:
#     - secretName: test-nginx
  rules:
  - host: test-nginx.local
    http:
      paths:
      - path: /
        backend:
          serviceName: test-nginx
          servicePort: 80
```
执行`kubectl get ing -n test`命令查看Ingress是否创建成功。

**至此，我们已经部署了一个nginx应用，接下来验证应用有效性**

环境说明：
* 宿主机IP：194.168.1.15，也就是安装了k8s环境的机器
* 测试有效性的主机IP：194.168.1.5，一台与宿主机同局域网的机器

修改194.168.1.5这台机器的hosts，加入以下行：

```hosts
test-nginx.local      194.168.1.15
```

打开浏览器，输入`http://test-nginx.local`，就可看见nginx的欢迎页面。