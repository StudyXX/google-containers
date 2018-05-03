# google-containers
Google Containers Mirror

[![Build Status](https://travis-ci.org/RainingNight/google-containers.svg?branch=master)](https://travis-ci.org/RainingNight/google-containers)

## Pull image

```bash
## 拉取镜像
docker pull reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/etcd-amd64:3.1.13
docker pull reg.qiniu.com/k8s/pause-amd64:3.1

## 如果使用CoreDNS，则不需要下面三个镜像
docker pull reg.qiniu.com/k8s/k8s-dns-sidecar-amd64:1.14.10
docker pull reg.qiniu.com/k8s/k8s-dns-kube-dns-amd64:1.14.10
docker pull reg.qiniu.com/k8s/k8s-dns-dnsmasq-nanny-amd64:1.14.10

## Calico
docker pull reg.qiniu.com/quay/coreos-etcd:v3.1.10
docker pull reg.qiniu.com/quay/calico-node:v3.0.6
docker pull reg.qiniu.com/quay/calico-cni:v2.0.5
docker pull reg.qiniu.com/quay/calico-kube-controllers:v2.0.4

## Dashboard
docker pull reg.qiniu.com/k8s/kubernetes-dashboard-amd64:v1.8.3

## Heapster
docker pull reg.qiniu.com/k8s/heapster-influxdb-amd64:v1.3.3
docker pull reg.qiniu.com/k8s/heapster-grafana-amd64:v4.4.3
docker pull reg.qiniu.com/k8s/heapster-amd64:v1.4.2

## Ingress
docker pull reg.qiniu.com/k8s/defaultbackend:1.3
docker pull reg.qiniu.com/k8s/defaultbackend-amd64:1.3
```

## Add tag

```bash
docker tag reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.2 k8s.gcr.io/kube-apiserver-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.2 k8s.gcr.io/kube-scheduler-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.2 k8s.gcr.io/kube-controller-manager-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.2 k8s.gcr.io/kube-proxy:v1.10.2
docker tag reg.qiniu.com/k8s/etcd-amd64:3.1.12 k8s.gcr.io/etcd-amd64:3.1.12
docker tag reg.qiniu.com/k8s/pause-amd64:3.1 k8s.gcr.io/pause-amd64:3.1

docker tag reg.qiniu.com/k8s/k8s-dns-sidecar-amd64:1.14.10 k8s.gcr.io/k8s-dns-sidecar-amd64:1.14.10
docker tag reg.qiniu.com/k8s/k8s-dns-kube-dns-amd64:1.14.10 k8s.gcr.io/k8s-dns-kube-dns-amd64:1.14.10
docker tag reg.qiniu.com/k8s/k8s-dns-dnsmasq-nanny-amd64:1.14.10 k8s.gcr.io/k8s-dns-dnsmasq-nanny-amd64:1.14.10

docker tag reg.qiniu.com/quay/coreos-etcd:v3.1.10 quay.io/coreos/etcd:v3.1.10
docker tag reg.qiniu.com/quay/calico-node:v3.0.6 quay.io/calico/node:v3.0.6
docker tag reg.qiniu.com/quay/calico-cni:v2.0.5 quay.io/calico/cni:v2.0.5
docker tag reg.qiniu.com/quay/calico-kube-controllers:v2.0.4 quay.io/calico/kube-controllers:v2.0.4

docker tag reg.qiniu.com/k8s/kubernetes-dashboard-amd64:v1.8.3 k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3

docker tag reg.qiniu.com/k8s/heapster-influxdb-amd64:v1.3.3 k8s.gcr.io/heapster-influxdb-amd64:v1.3.3
docker tag reg.qiniu.com/k8s/heapster-grafana-amd64:v4.4.3 k8s.gcr.io/heapster-grafana-amd64:v4.4.3
docker tag reg.qiniu.com/k8s/heapster-amd64:v1.4.2 k8s.gcr.io/heapster-amd64:v1.4.2

docker tag reg.qiniu.com/k8s/defaultbackend:1.3 k8s.gcr.io/defaultbackend:1.3
docker tag reg.qiniu.com/k8s/defaultbackend-amd64:1.3 k8s.gcr.io/defaultbackend-amd64:1.3
```

## Doc

* [使用kubeadm初始化Kubernetes（1.10.2）集群教程（国内环境）](http://www.cnblogs.com/RainingNight/p/using-kubeadm-to-create-a-cluster.html)