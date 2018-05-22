## ingress-nginx安装

    这里假设你已经了解了ingress-nginx，如果你还没了解请询问搜索引擎。这篇文章只能让你快速的部署他们。

### 安装之前

安装之前需要确保你的集群正常运行或主节点再运行：
* 如果集群正常运行：你可以开始安装了。
* 如果只有master节点在运行：
    则在主节点执行`kubectl taint nodes --all node-role.kubernetes.io/master-`命令，目的是master节点同时变成worker节点
* 如果不满足上述情况，请您参考之前的文档重新部署。

### 安装ingress-nginx

所有的安装配置安装以及需要镜像我们都已经准备好了，只要你按照文档的步骤执行应该可以顺利的完成。

[下载ingress-nginx配置文件](../install/ingress-nginx/ingress-nginx-controller.yaml)，使用如下命令部署nginx-controller，命令执行后需要等一段时间（由你的网速决定），因为这需要去联网下载docker镜像。

```shell
kubectl apply -f ingress-nginx-controller.yaml
```

<font style="color:red;">如果你的网速实在太慢,请自行下载离线安装</font>

```shell
docker pull quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.15.0
docker pull reg.qiniu.com/k8s/defaultbackend-amd64:1.4
```

**查看部署状态：**`kubectl get pods -n ingress-nginx -o wide --watch`

    NAMESPACE       NAME                                       READY     STATUS     RESTARTS   IP
    ingress-nginx   default-http-backend-6f26b                 1/1       Running    0          192.168.168.154
    ingress-nginx   nginx-ingress-controller-58b48898c-gdkgk   1/1       Running    0          194.168.1.15

    当状态变为`Running`时便是部署成功了,这里你会看到两个ip：
    其中192.168.168.154是docker所在网络的ip，宿主机可以访问。
    其中194.168.1.15是宿主机的ip，至于为什么这里显示的是宿主机的ip而不是docker容器的ip，这里不必深究，学习k8s还有很长的路要走。

### 测试ingress-nginx是否安装成功

[测试教程](./test-ingress.md)