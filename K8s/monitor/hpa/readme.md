

# Horizontal Pod autoscaler

##  Install Metrics server - 

```
cd metrics-server

kubectl create -f . 
```
##  Create nginx deployment, service & hpa 

> It is mandatory to set requests on  cpu utilization as HPA requires CPU metrics. 

` kubectl create -f hpa.yaml` 

```
kubectl get hpa 
NAME    REFERENCE          TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
nginx   Deployment/nginx   0%/40%    3         5         3          55s

```

## Test the HPA 
  ```
  kubectl run load-generator --image=busybox --restart=Never  -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://CIP; done"
