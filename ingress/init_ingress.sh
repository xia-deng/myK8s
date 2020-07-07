echo 'start to install ingress and display by node ip.'
echo `kubectl delete -f /k8s/ingress/mandatory.yaml`
echo `kubectl delete -f /k8s/ingress/service-load.yaml`
echo `kubectl apply -f /k8s/ingress/mandatory.yaml`
echo `kubectl apply -f /k8s/ingress/service-load.yaml`
echo 'ingress installed.'
