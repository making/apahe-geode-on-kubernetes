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

gfsh>list members
    Name     | Id
------------ | ---------------------------------------------
Coordinator: | 10.1.0.250(locator-0:55:locator)<ec><v0>:1024
locator-0    | 10.1.0.250(locator-0:55:locator)<ec><v0>:1024
server-0     | 10.1.0.251(server-0:55)<v10>:1024
locator-1    | 10.1.0.252(locator-1:56:locator)<ec><v1>:1024
server-1     | 10.1.0.253(server-1:55)<v11>:1024
```

![image](https://user-images.githubusercontent.com/106908/35868113-f73535e6-0b9e-11e8-9fac-3df2bf58a6a2.png)

`admin`/`admin`

![image](https://user-images.githubusercontent.com/106908/35868131-01d96b48-0b9f-11e8-8dac-9468e558e78f.png)
