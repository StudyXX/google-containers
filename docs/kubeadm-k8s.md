## 使用Kubeadm部署k8s

本文参考[官网教程](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)，安装过程一波三折，几次想放弃，但又不甘心，一边翻着源码一边看着教程，最终才有了下面的内容。

### 环境要求

#### 1. Ubuntu 16.04 2核4G

    注意这里最好是2核，部署安装时发现单核导致ingress-nginx部分pod无启动

    安装开始之前请确保使用的root账户，非root账户请自行添加sudo

#### 2. 安装docker

    我这里使用的是18.03.1

#### 3. 安装Kubeadm， kubelet，kubectl
```bash
apt-get update && apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
```

#### 4. 永久禁用交换分区

`打开/etc/fstab文件并找到包含swap文本行在开头注释，类似如下：`

```bash
/dev/mapper/ubuntu--vg-root /               ext4    errors=remount-ro 0       1
UUID=d11aa7b5-457b-4bc1-80fd-c5e33f63ac04 /boot           ext2    defaults        0       2
## 注释一下两行
#/dev/mapper/ubuntu--vg-swap_1 none            swap    sw              0       0
#/dev/mapper/cryptswap1 none swap sw 0 0
```

#### 5. 禁用防火墙

    禁用防火墙并不是安全的做法，如果在真实的环境中请查看k8s文档开放指定的端口。
    我这里简单粗暴直接禁用防火墙：
    ufw disable

#### 6. 配置cgroup驱动类型

`docker中有两种cgroup驱动类型：cgroupfs，systemd`

    1. 查看docker使用的驱动类型：`docker info|grep -i cgroup`
    2. 修改/etc/systemd/system/kubelet.service.d/10-kubeadm.conf 配置文件中的cgroup类型与上一步执行结果对应
        //假如该文件中有如下这一行
        Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"
        //如果没有上面这行，需要添加，并修改cgroup-driver为docker使用的类型，我的安装环境正确的配置如下：
        Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=cgroupfs"
    3. 使上一步配置生效
        systemctl daemon-reload
        systemctl restart kubelet

### 部署k8s

    执行kubeadm init命令之前需要提前准备一些docker镜像，因为这些镜像位于google服务器上，我们没有用办法正常获取，所以这里我们从自己的镜像服务器下载。

    我这里写了一个简单的脚本文件，便于你获取所需的docker镜像。

[下载镜像shell脚本](../install/k8s-images.sh)

```bash
# --kubernetes-version=v1.10.2 指定我们要安装的k8s版本
# --feature-gates=CoreDNS=true 使用CoreDNS来做主机名到IP的对应关系
# --pod-network-cidr=192.168.0.0/16 这里使用的网络类型为Calico
kubeadm init --kubernetes-version=v1.10.2 --feature-gates=CoreDNS=true --pod-network-cidr=192.168.0.0/16
```

`如果部署成功你会看到如下显示：`

```
......
Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 194.168.1.15:6443 --token ninsl0.hgnutou2p9f9u8d4 --discovery-token-ca-cert-hash sha256:ba73076c46a143260ba876d09174f558deb1941794621591cbc104d63c50adaa
```

`接下来在.profile文件中加入环境变量，使kubectl命令生效：`

```sh
//vi .profile
export KUBECONFIG=/etc/kubernetes/admin.conf
//使配置生效
source .profile
```

`此时执行kubectl get nodes可以看到返回结果中master处于NotReady状态`

```
NAME        STATUS     ROLES     AGE       VERSION
k8s-node   NotReady   master    26m       v1.10.2
```

### 部署Calico网络插件

```sh
kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
```

`稍等片刻后查看master节点的状态:kubectl get nodes`
```
NAME        STATUS    ROLES     AGE       VERSION
k8s-node2   Ready     master    40m       v1.10.2
```