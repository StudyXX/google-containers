## ingress-traefik安装

    这里假设你已经了解了ngress-traefik分别是什么，如果你还没了解请询问搜索引擎。这篇文章只能让你快速的部署他们。

### 安装之前

安装之前需要确保你的集群正常运行或主节点再运行：
* 如果集群正常运行：你可以开始安装了。
* 如果只有master节点在运行：
    则在主节点执行`kubectl taint nodes --all node-role.kubernetes.io/master-`命令，目的是master节点同时变成worker节点
* 如果不满足上述情况，请您参考之前的文档重新部署。

### ingress-Traefik安装

所有的安装配置安装以及需要镜像我们都已经准备好了，只要你按照文档的步骤执行应该可以顺利的完成。

**首先，生成Sceret**

生成Secret需要使用证书文件，所需的证书文件已经生成好了，你只需要下载即可使用，该证书绑定的域名是:`traefik-ui.local`

证书：[traefik-ui.pem](../install/ingress-traefik/traefik-ui.pem)
秘钥：[traefik-ui-key.pem](../install/ingress-traefik/traefik-ui-key.pem)

下面需要生成两个Secret，一个用于traefik绑定到https，一个用于traefik绑定到ingress上。

```shell
//生成treafik-cert
kubectl create secret generic traefik-cert --from-file=traefik-ui-key.pem --from-file=traefik-ui.pem -n kube-system
//生成traefik-ui-cert
kubectl create secret tls traefik-ui-cert --cert=/root/certs/traefik-ui/traefik-ui.pem --key=/root/certs/traefik-ui/traefik-ui-key.pem -n kube-system
```

**然后，创建一个ConfigMap**

这个配置文件用来将http跳转到https,[下载traefik.toml配置文件](../install/ingress-traefik/traefik.toml)，并执行创建命令：`kubectl create configmap traefik-conf --from-file=traefik.toml`,此时便可在`default`命名空间下创建`traefik-conf`配置,执行`kubectl get configmap | grep traefik-conf`命令查看结果。

**最后，安装ingress-traefik**


[下载ingress-traefik配置文件](../install/ingress-traefik/ingress-traefik-controller.yaml)，使用如下命令部署traefik-controller，命令执行后需要等一段时间（由你的网速决定），因为这需要去联网下载docker镜像。

```shell
kubectl apply -f ingress-traefik-controller.yaml
```

<font style="color:red;">如果你的网速实在太慢,请自行下载离线安装</font>

```shell
docker pull traefik:latest
```

**查看部署状态：**`kubectl get pods -n kube-system -o wide --watch|grep traefik-ingress`

    NAMESPACE       NAME                                       READY     STATUS     RESTARTS   IP
    kube-system   traefik-ingress-controller-7994d698d8-v7cr5   1/1       Running    0         192.168.169.182

    当状态变为`Running`时便是部署成功了,这里你只会看到一个ip（这也是与ingress-nginx不同的地方）：
    其中192.168.169.182是docker所在网络的ip，宿主机可以访问。

### 测试ingress-nginx是否安装成功

    因为traefik自带了服务界面，所以我们可以通过访问该服务界面来确认traefik是否安装成功。

**配置hosts**

k8s宿主机ip：194.168.1.15

测试机ip：194.168.1.5

修改测试机hosts文件，添加如下行：`traefik-ui.local  194.168.1.15`

最后，打开浏览器访问：`http://traefik-ui.local`后会自动跳转到`https://traefik-ui.local`，至此你就能看到traefik的ui界面了 。

### 接下来部署一个nginx，做更多的测试

[测试教程](./test-ingress.md)
