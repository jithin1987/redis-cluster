kubectl delete configmap sd-redis-master-conf
kubectl delete secret redis-secret
kubectl delete -f ./redis-master.yaml
