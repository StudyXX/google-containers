# google-containers
Google Containers Mirror

## Pull

```bash
## 拉取镜像
docker pull reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.1
docker pull reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.1
docker pull reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.1
docker pull reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.1
docker pull reg.qiniu.com/k8s/etcd-amd64:3.1.13
docker pull reg.qiniu.com/k8s/pause-amd64:3.1

## 如果使用CoreDNS,不需要下面三个镜像
docker pull reg.qiniu.com/k8s/k8s-dns-sidecar-amd64:1.14.9
docker pull reg.qiniu.com/k8s/k8s-dns-kube-dns-amd64:1.14.9
docker pull reg.qiniu.com/k8s/k8s-dns-dnsmasq-nanny-amd64:1.14.9

## Dashboard
docker pull reg.qiniu.com/k8s/kubernetes-dashboard-amd64:v1.8.3
```

## Add k8s.gcr.io tag

```bash
docker tag reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.1 k8s.gcr.io/kube-apiserver-amd64:v1.10.1
docker tag reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.1 k8s.gcr.io/kube-scheduler-amd64:v1.10.1
docker tag reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.1 k8s.gcr.io/kube-controller-manager-amd64:v1.10.1
docker tag reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.1 k8s.gcr.io/kube-proxy:v1.10.1
docker tag reg.qiniu.com/k8s/etcd-amd64:3.1.12 k8s.gcr.io/etcd-amd64:3.1.13
docker tag reg.qiniu.com/k8s/pause-amd64:3.1 k8s.gcr.io/pause-amd64:3.1
docker tag reg.qiniu.com/k8s/k8s-dns-sidecar-amd64:1.14.9 k8s.gcr.io/k8s-dns-sidecar-amd64:1.14.9
docker tag reg.qiniu.com/k8s/k8s-dns-kube-dns-amd64:1.14.9 k8s.gcr.io/k8s-dns-kube-dns-amd64:1.14.9
docker tag reg.qiniu.com/k8s/k8s-dns-dnsmasq-nanny-amd64:1.14.9 k8s.gcr.io/k8s-dns-dnsmasq-nanny-amd64:1.14.9
docker tag reg.qiniu.com/k8s/kubernetes-dashboard-amd64:v1.8.3 k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3
```