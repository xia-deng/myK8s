echo 'start to install k8s dashboard...'
echo `kubectl delete -f /k8s/dashboard/recommended-nodePort.yaml`
echo `kubectl apply -f /k8s/dashboard/recommended-nodePort.yaml`
echo 'start to create user...'
echo `kubectl delete -f /k8s/dashboard/dashboard_user_admin.yaml`
echo `kubectl delete -f /k8s/dashboard/dashboard_user_view.yaml`
echo `kubectl apply -f /k8s/dashboard/dashboard_user_admin.yaml`
echo `kubectl apply -f /k8s/dashboard/dashboard_user_view.yaml`
echo 'the dashboard installed.'
echo ''
echo 'try to get admin login token:'
echo `kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}') | grep token:`
