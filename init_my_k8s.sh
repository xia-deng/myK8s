echo 'start to init my k8s'
echo '1.start to create my own namespace named:lin'
echo `kubectl create namespace lin`
echo `kubectl apply -f /k8s/quota/quota_pod_lin.yaml`
echo `kubectl apply -f /k8s/quota/limit_range_lin.yaml`
echo `kubectl apply -f /k8s/quota/quota_pod_default.yaml`

echo 'switch namespace to my own: lin'
echo `/k8s/reset-namespace.sh lin`

echo '2.start to init dashboard'
echo `/k8s/dashboard/dashboard.sh`

echo '3.start to init ingress'
echo `/k8s/ingress/init_ingress.sh`

echo '4.start to init nfs'
echo `/k8s/nfs/init_nfs.sh`

echo 'init finished. please check.'
