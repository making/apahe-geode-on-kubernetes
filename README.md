# [Apache Geode](https://geode.apache.org) on Kubernetes

This instruction assumes stable [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) (k8s 1.9+).

```
$ kubectl create ns geode
$ kubectl apply -f .
$ kubectl get all,pv,pvc -n geode -o wide
NAME            READY   STATUS    RESTARTS   AGE     IP              NODE                                          NOMINATED NODE   READINESS GATES
pod/locator-0   1/1     Running   0          5m59s   10.200.2.8      ip-10-0-9-5.ap-northeast-1.compute.internal   <none>           <none>
pod/locator-1   1/1     Running   0          3m35s   10.200.74.116   ip-10-0-8-6.ap-northeast-1.compute.internal   <none>           <none>
pod/server-0    1/1     Running   4          5m59s   10.200.74.115   ip-10-0-8-6.ap-northeast-1.compute.internal   <none>           <none>
pod/server-1    1/1     Running   0          5m21s   10.200.2.7      ip-10-0-9-5.ap-northeast-1.compute.internal   <none>           <none>

NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP                                                                    PORT(S)          AGE     SELECTOR
service/locator          ClusterIP      None            <none>                                                                         10334/TCP        8m44s   app=locator
service/locator-public   LoadBalancer   10.100.200.24   aa2815f853d1d11e9a42606dd4042512-1956244383.ap-northeast-1.elb.amazonaws.com   7070:30065/TCP   8m44s   app=locator
service/server           ClusterIP      None            <none>                                                                         40404/TCP        8m44s   app=server

NAME                       READY   AGE     CONTAINERS   IMAGES
statefulset.apps/locator   2/2     5m59s   locator      apachegeode/geode:1.8.0
statefulset.apps/server    2/2     5m59s   server       apachegeode/geode:1.8.0

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                                  STORAGECLASS   REASON   AGE
persistentvolume/pvc-14f023e7-3745-11e9-a426-06dd40425126   8Gi        RWO            Delete           Bound    spinnaker/redis-data-spinnaker-redis-master-0          standard                7d10h
persistentvolume/pvc-15097846-3745-11e9-a426-06dd40425126   10Gi       RWO            Delete           Bound    spinnaker/halyard-home-spinnaker-spinnaker-halyard-0   standard                7d10h
persistentvolume/pvc-1baebacf-3d1e-11e9-a426-06dd40425126   5Gi        RWO            Delete           Bound    geode/geode-data-server-1                              standard                5m11s
persistentvolume/pvc-5b2ca560-3d1e-11e9-a426-06dd40425126   1Gi        RWO            Delete           Bound    geode/geode-data-locator-1                             standard                3m34s
persistentvolume/pvc-811138b3-17de-11e9-bf29-065aa5e66230   10Gi       RWO            Delete           Bound    monitoring/prometheus-k8s-db-prometheus-k8s-0          standard                47d
persistentvolume/pvc-a294793c-3d1d-11e9-a426-06dd40425126   1Gi        RWO            Delete           Bound    geode/geode-data-locator-0                             standard                8m41s
persistentvolume/pvc-a2ce2dcf-3d1d-11e9-a426-06dd40425126   5Gi        RWO            Delete           Bound    geode/geode-data-server-0                              standard                8m43s

NAME                                         STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/geode-data-locator-0   Bound    pvc-a294793c-3d1d-11e9-a426-06dd40425126   1Gi        RWO            standard       8m44s
persistentvolumeclaim/geode-data-locator-1   Bound    pvc-5b2ca560-3d1e-11e9-a426-06dd40425126   1Gi        RWO            standard       3m35s
persistentvolumeclaim/geode-data-server-0    Bound    pvc-a2ce2dcf-3d1d-11e9-a426-06dd40425126   5Gi        RWO            standard       8m44s
persistentvolumeclaim/geode-data-server-1    Bound    pvc-1baebacf-3d1e-11e9-a426-06dd40425126   5Gi        RWO            standard       5m21s
```

``` sh
$ ./help.sh
gfsh
connect --use-http=true --url=http://127.0.0.1:32609/geode-mgmt/v1
start pulse --url=http://127.0.0.1:32609/pulse
```

```
$ gfsh
    _________________________     __
   / _____/ ______/ ______/ /____/ /
  / /  __/ /___  /_____  / _____  / 
 / /__/ / ____/  _____/ / /    / /  
/______/_/      /______/_/    /_/    1.4.0

Monitor and Manage Apache Geode
gfsh>connect --use-http=true --url=http://127.0.0.1:32609/geode-mgmt/v1
Successfully connected to: GemFire Manager HTTP service @ org.apache.geode.management.internal.web.http.support.HttpRequester@70b012ca

gfsh>start pulse --url=http://127.0.0.1:32609/pulse
Launched Geode Pulse

gfsh>list members
    Name     | Id
------------ | ---------------------------------------------
Coordinator: | 10.1.0.250(locator-0:55:locator)<ec><v0>:1024
locator-0    | 10.1.0.250(locator-0:55:locator)<ec><v0>:1024
server-0     | 10.1.0.251(server-0:55)<v10>:1024
locator-1    | 10.1.0.252(locator-1:56:locator)<ec><v1>:1024
server-1     | 10.1.0.253(server-1:55)<v11>:1024

gfsh>put --region=/ExRegion1 --key=foo --value=bar
Result      : true
Key Class   : java.lang.String
Key         : foo
Value Class : java.lang.String
Old Value   : <NULL>

gfsh>get --region=/ExRegion1 --key=foo 
Result      : true
Key Class   : java.lang.String
Key         : foo
Value Class : java.lang.String
Value       : bar
```

![image](https://user-images.githubusercontent.com/106908/35868113-f73535e6-0b9e-11e8-9fac-3df2bf58a6a2.png)

`admin`/`admin`

![image](https://user-images.githubusercontent.com/106908/35868131-01d96b48-0b9f-11e8-8dac-9468e558e78f.png)
