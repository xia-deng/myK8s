echo 'start to init nfs'
echo `kubectl delete -f /k8s/nfs/class.yaml`
echo `kubectl delete -f /k8s/nfs/rbac.yaml`
echo `kubectl delete -f /k8s/nfs/deployment.yaml`
echo `kubectl create -f /k8s/nfs/class.yaml`
echo `kubectl create -f /k8s/nfs/rbac.yaml`
echo `kubectl create -f /k8s/nfs/deployment.yaml`
echo 'nfs installed.'

