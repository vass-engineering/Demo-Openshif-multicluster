1. Install Submariner add-ons in both clusters

* Access to the console AdvanceClusterMngK8sConsole, and go to MulticlusterNetworking > Submariner add-ons.
  
![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/AdvanceClusterMngK8sConsole.png)


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/1InstallSubmarineradd-ons.png)



* Select both cluster to install the submariner add-ons 


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/2InstallSubmarineradd-ons-ons.png)

* Check configuration

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/3InstallSubmarineradd-ons.png)

* Review configuiration

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/4InstallSubmarineradd-ons.png)


* Wait for installation completed.

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/5InstallSubmarineradd-ons.png)

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/6InstallSubmarineradd-ons.png)


2. Download and install submariner binary.

```
wget https://github.com/submariner-io/releases/releases/download/v0.13.1/subctl-v0.13.1-linux-amd64.tar.xz
```

```
tar -xvf subctl-v0.13.1-linux-amd64.tar.xz
```

```
mkdir -p /home/labmulticluster/.local/bin/
```

```
 install -m744 subctl-v0.13.1-linux-amd64 $HOME/.local/bin/subctl
```


3. Expose an App.

Example:

* From one of the cluster deploy an APP and export the svc for both clusters.


```
oc -n default create deployment nginx --image=nginxinc/nginx-unprivileged:stable-alpine

oc -n default expose deployment nginx --port=8080

subctl export service --namespace <service-namespace> <service-name>

subctl export service --namespace default nginx
```

* Check that the service is available from both cluster.

```
oc run tmp-shell --image quay.io/submariner/nettest  -n default --  sleep 100
oc rsh tmp-shell 
curl nginx.default.svc.clusterset.local:8080


.....
.....


</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
/app # curl nginx.test.svc.clusterset.local:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
