# Apache Geode on Kubernetes


```
kubectl apply -f .
```

``` sh
$ ./help.sh
gfsh
connect --use-http=true --url=http://127.0.0.1:31254/geode-mgmt/v1
start pulse --url=http://127.0.0.1:31254/pulse
```

```
$ gfsh
    _________________________     __
   / _____/ ______/ ______/ /____/ /
  / /  __/ /___  /_____  / _____  / 
 / /__/ / ____/  _____/ / /    / /  
/______/_/      /______/_/    /_/    1.4.0

Monitor and Manage Apache Geode
gfsh>connect --use-http=true --url=http://127.0.0.1:31254/geode-mgmt/v1
Successfully connected to: GemFire Manager HTTP service @ org.apache.geode.management.internal.web.http.support.HttpRequester@70b012ca

gfsh>start pulse --url=http://127.0.0.1:31254/pulse
Launched Geode Pulse

gfsh>
```

![image](https://user-images.githubusercontent.com/106908/35867644-9b85f0b0-0b9d-11e8-89b4-1ac386beeabb.png)

