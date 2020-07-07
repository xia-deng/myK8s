echo `./stop.sh`
echo '1.start to do some init task.'
echo `swapoff -a`
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bashrc
source ~/.bashrc
echo '2.start to pull docker image.'
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.18.0`
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.0`
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.0`
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.0`
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2`
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.3-0`
echo `yes Y | docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.6.7`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.18.0 k8s.gcr.io/kube-apiserver:v1.18.0`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.0 k8s.gcr.io/kube-controller-manager:v1.18.0`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.0 k8s.gcr.io/kube-scheduler:v1.18.0`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.0 k8s.gcr.io/kube-proxy:v1.18.0`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2 k8s.gcr.io/pause:3.2`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.3-0 k8s.gcr.io/etcd:3.4.3-0`
echo `yes Y | docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.6.7 k8s.gcr.io/coredns:1.6.7`
echo '3.get the mechine ip.'
ip=`ifconfig ens33 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`
echo `rm -rf start.log`

echo '4.kubeadm init start the k8s'
echo `kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$ip --kubernetes-version=v1.18.0 --ignore-preflight-errors=Swap` > start.log
echo '5.init the network'
echo `yes Y | kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml`
joinStr=`more start.log | grep 'kubeadm join'`
command='kubeadm join'${joinStr#*'kubeadm join'}
echo '6.create node start script.'
rm -rf /k8s/nodeStart.sh
echo -e '/k8s/stop.sh' >> /k8s/nodeStart.sh
echo -e 'swapoff -a' >> /k8s/nodeStart.sh
echo -e 'echo -e "export KUBECONFIG=/etc/kubernetes/kubelet.conf" >> ~/.bashrc' >> /k8s/nodeStart.sh
echo -e 'source ~/.bashrc'  >> /k8s/nodeStart.sh
echo -e ${command%\\*}${command#*\\} >> /k8s/nodeStart.sh
echo `cat /k8s/nodeStart.sh`
