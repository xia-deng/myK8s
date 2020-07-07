/k8s/stop.sh
swapoff -a
echo -e "export KUBECONFIG=/etc/kubernetes/kubelet.conf" >> ~/.bashrc
source ~/.bashrc
kubeadm join 192.168.29.134:6443 --token xsqc61.9gxxa3fgiihew4fz --discovery-token-ca-cert-hash sha256:57789463f0e315260a2121c7eebfbe7042821b3106340d58f5d4e048df04985c
