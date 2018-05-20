## 加入k8s集群

在[使用kubeadm安装k8s](./使用kubeadm安装k8s.md)中介绍了如何安装k8s主节点，这篇文章我们来介绍如何加入k8s集群。

#### 环境要求

​	同上一篇的环境要求

#### 首先，从我们的镜像服务器获取docker镜像

[获取镜像shell脚本](../install/k8s-images.sh)

#### 然后，获取加入k8s集群的授权码

​	在上篇文章中，当执行`kubeadm init`命令成功后，会打印加入k8s集群需要的命令，如下：

```sh
kubeadm join 194.168.1.15:6443 --token ninsl0.hgnutou2p9f9u8d4 --discovery-token-ca-cert-hash sha256:ba73076c46a143260ba876d09174f558deb1941794621591cbc104d63c50adaa
```

​	将这条命令复制到子节点，执行，以便加入k8s集群（如果发现docker版本错误的提示，可以忽略，或者去官网查找如何忽略版本检查）。

#### 执行命令后，等待节点启动

​	在master节点上执行`kubectl get nodes`查看各节点的status，直到所有的状态均为Ready。

#### 在子节点上执行kubectl命令

​	默认情况下，子节点执行kubectl命令几乎是不可用的，为了使kubectl命令正常，需要将master节点上的/etc/kubernetes/admin.conf文件复制到本地，命令如下：

```shell
//复制文件命令
scp user@master-ip:/etc/kubernetes/admin.conf .

//vi .profile编辑改文件，加入环境变量
export KUBECONFIG=/root/admin.conf
//是配置生效
source .profile
```

​	此时就可以在该节点执行kubectl命令，执行`kubectl get nodes`命令查看效果。