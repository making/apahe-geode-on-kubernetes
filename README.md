# [Apache Geode](https://geode.apache.org) on Kubernetes

This instruction assumes stable [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) (k8s 1.9+).

```
$ kubectl apply -f .
$ kubectl get all,pv,pvc
NAME                   DESIRED   CURRENT   AGE
statefulsets/locator   2         2         1h
statefulsets/server    2         2         1h

NAME           READY     STATUS    RESTARTS   AGE
po/locator-0   1/1       Running   0          1h
po/locator-1   1/1       Running   0          1h
po/server-0    1/1       Running   0          1h
po/server-1    1/1       Running   0          1h

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
svc/kubernetes       ClusterIP   10.96.0.1       <none>        443/TCP          3d
svc/locator          ClusterIP   None            <none>        10334/TCP        1h
svc/locator-public   NodePort    10.111.229.15   <none>        7070:32609/TCP   1h
svc/server           ClusterIP   None            <none>        40404/TCP        1h

NAME                                          CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                          STORAGECLASS   REASON    AGE
pv/pvc-332360b6-0b53-11e8-8151-025000000001   1Gi        RWO            Delete           Bound     default/geode-data-locator-0   hostpath                 1h
pv/pvc-332be29b-0b53-11e8-8151-025000000001   1Gi        RWO            Delete           Bound     default/geode-data-server-0    hostpath                 1h
pv/pvc-345a7af5-0b53-11e8-8151-025000000001   1Gi        RWO            Delete           Bound     default/geode-data-locator-1   hostpath                 1h
pv/pvc-383a1330-0b53-11e8-8151-025000000001   1Gi        RWO            Delete           Bound     default/geode-data-server-1    hostpath                 1h

NAME                       STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc/geode-data-locator-0   Bound     pvc-332360b6-0b53-11e8-8151-025000000001   1Gi        RWO            hostpath       1h
pvc/geode-data-locator-1   Bound     pvc-345a7af5-0b53-11e8-8151-025000000001   1Gi        RWO            hostpath       1h
pvc/geode-data-server-0    Bound     pvc-332be29b-0b53-11e8-8151-025000000001   1Gi        RWO            hostpath       1h
pvc/geode-data-server-1    Bound     pvc-383a1330-0b53-11e8-8151-025000000001   1Gi        RWO            hostpath       1h
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
