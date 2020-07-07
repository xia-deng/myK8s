echo 'change k8s namespace to:' $1
echo `kubectl config set-context $(kubectl config current-context) --namespace=$1`
echo `kubectl config view | grep namespace`
