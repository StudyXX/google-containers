#!/bin/sh
docker pull reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.2
docker pull reg.qiniu.com/k8s/etcd-amd64:3.1.12
docker pull reg.qiniu.com/k8s/pause-amd64:3.1

docker pull quay.io/calico/node:v3.0.7
docker pull quay.io/calico/kube-controllers:v2.0.4
docker pull quay.io/calico/cni:v2.0.5
docker pull coredns/coredns:1.0.6
docker pull quay.io/coreos/etcd:v3.1.10

docker tag reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.2 k8s.gcr.io/kube-apiserver-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.2 k8s.gcr.io/kube-scheduler-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.2 k8s.gcr.io/kube-controller-manager-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.2 k8s.gcr.io/kube-proxy-amd64:v1.10.2
docker tag reg.qiniu.com/k8s/etcd-amd64:3.1.12 k8s.gcr.io/etcd-amd64:3.1.12
docker tag reg.qiniu.com/k8s/pause-amd64:3.1 k8s.gcr.io/pause-amd64:3.1

docker rmi reg.qiniu.com/k8s/kube-apiserver-amd64:v1.10.2
docker rmi reg.qiniu.com/k8s/kube-controller-manager-amd64:v1.10.2
docker rmi reg.qiniu.com/k8s/kube-scheduler-amd64:v1.10.2
docker rmi reg.qiniu.com/k8s/kube-proxy-amd64:v1.10.2
docker rmi reg.qiniu.com/k8s/etcd-amd64:3.1.12
docker rmi reg.qiniu.com/k8s/pause-amd64:3.1