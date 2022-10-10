1. LoadBalancer or HA-proxy for both cluster

* Example for ha-proxy:

```
#---------------------------------------------------------------------
# OpenShift
#---------------------------------------------------------------------

frontend stats
  bind 10.0.6.11:1936
  mode            http
  log             global
  maxconn 10
  stats enable
  stats hide-version
  stats refresh 30s
  stats show-node
  stats show-desc Stats for ocp cluster
  stats auth admin:ocp
  stats uri /stats

listen apia-server-6443 
  bind 10.0.6.11:6443
  mode tcp
  server ocpa-bootstrap.ocpa.labs.vass.es 10.0.6.50:6443 check inter 1s backup
  server ocpa-master1.ocpa.labs.vass.es  10.0.6.20:6443 check inter 1s
  server ocpa-master2.ocpa.labs.vass.es  10.0.6.21:6443 check inter 1s
  server ocpa-master3.ocpa.labs.vass.es  10.0.6.22:6443 check inter 1s

listen machine-config-server-22623 
  bind 10.0.6.11:22623
  mode tcp
  server ocpa-bootstrap.ocpa.labs.vass.es 10.0.6.50:22623 check inter 1s backup
  server ocpa-master1.ocpa.labs.vass.es  10.0.6.20:22623 check inter 1s
  server ocpa-master2.ocpa.labs.vass.es  10.0.6.21:22623 check inter 1s
  server ocpa-master3.ocpa.labs.vass.es  10.0.6.22:22623 check inter 1s

listen ingress-router-443 
  bind 10.0.6.11:443
  mode tcp
  balance source
  server ocpa-worker1.ocpa.labs.vass.es 10.0.6.30:443 check inter 1s
  server ocpa-worker2.ocpa.labs.vass.es 10.0.6.31:443 check inter 1s
  server ocpa-master1.ocpa.labs.vass.es  10.0.6.20:443 check inter 1s
  server ocpa-master2.ocpa.labs.vass.es  10.0.6.21:443 check inter 1s
  server ocpa-master3.ocpa.labs.vass.es  10.0.6.22:443 check inter 1s

listen ingress-router-80 
  bind 10.0.6.11:80
  mode tcp
  balance source
  server ocpa-worker1.ocpa.labs.vass.es 10.0.6.30:80 check inter 1s
  server ocpa-worker2.ocpa.labs.vass.es 10.0.6.31:80 check inter 1s
  server ocpa-master1.ocpa.labs.vass.es  10.0.6.20:80 check inter 1s
  server ocpa-master2.ocpa.labs.vass.es  10.0.6.21:80 check inter 1s
  server ocpa-master3.ocpa.labs.vass.es  10.0.6.22:80 check inter 1s


listen ocpb-api-server-6443
  bind 10.0.6.14:6443
  mode tcp
  server ocpb-bootstrap.ocpb.labs.vass.es 10.0.6.51:6443 check inter 1s backup
  server ocpb-master1.ocpb.labs.vass.es   10.0.6.32:6443 check inter 1s
  server ocpb-master2.ocpb.labs.vass.es   10.0.6.33:6443 check inter 1s
  server ocpb-master3.ocpb.labs.vass.es   10.0.6.34:6443 check inter 1s

listen ocpb-machine-config-server-22623
  bind 10.0.6.14:22623
  mode tcp
  server ocpb-bootstrap.ocpb.labs.vass.es 10.0.6.51:22623 check inter 1s backup
  server ocpb-master1.ocpb.labs.vass.es   10.0.6.32:22623 check inter 1s
  server ocpb-master2.ocpb.labs.vass.es   10.0.6.33:22623 check inter 1s
  server ocpb-master3.ocpb.labs.vass.es   10.0.6.34:22623 check inter 1s

listen ocpb-ingress-router-443
  bind 10.0.6.14:443
  mode tcp
  balance source
  server ocpb-master1.ocpb.labs.vass.es  10.0.6.32:443 check inter 1s
  server ocpb-master2.ocpb.labs.vass.es  10.0.6.33:443 check inter 1s
  server ocpb-master3.ocpb.labs.vass.es  10.0.6.34:443 check inter 1s
  server ocpb-worker1.ocpb.labs.vass.es  10.0.6.35:443 check inter 1s
  server ocpb-worker2.ocpb.labs.vass.es  10.0.6.36:443 check inter 1s
  
listen ocpb-ingress-router-80
  bind 10.0.6.14:80
  mode tcp
  balance source
  server ocpb-master1.ocpb.labs.vass.es  10.0.6.32:80 check inter 1s
  server ocpb-master2.ocpb.labs.vass.es  10.0.6.33:80 check inter 1s
  server ocpb-master3.ocpb.labs.vass.es  10.0.6.34:80 check inter 1s
  server ocpb-worker1.ocpb.labs.vass.es 10.0.6.35:80 check inter 1s
  server ocpb-worker2.ocpb.labs.vass.es 10.0.6.36:80 check inter 1s
```

2. DNS 

* Example in bind:

```
cat  db.ocplab-a.local 
```
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     dns.labs.vass.es root.labs.vass.es. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      dns.labs.vass.es.

; Entradas para API
api             IN      A       10.0.6.11
api-int         IN      A       10.0.6.11
; Wildcard para pods
*.apps          IN      A       10.0.6.11
; Entrada temporal para bootstrap
ocpa-bootstrap  IN      A       10.0.6.50
; CPs
ocpa-master1            IN      A       10.0.6.20 
ocpa-master2            IN      A       10.0.6.21 
ocpa-master3            IN      A       10.0.6.22 
; Workers
ocpa-worker1            IN      A       10.0.6.30 
ocpa-worker2            IN      A       10.0.6.31
```


```
cat db.ocplab-b.local 
```

```
; 
; BIND data file for local loopback interface 
;
$TTL    604800
@       IN      SOA     dns.labs.vass.es root.labs.vass.es. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      dns.labs.vass.es.

; CONFIGURACI√ÆCLUSTER OCPB
; Entradas para API
api             IN      A       10.0.6.14
api-int         IN      A       10.0.6.14
; Wildcard para pods
*.apps          IN      A       10.0.6.14
; Entrada temporal para bootstrap
ocpb-bootstrap       IN      A       10.0.6.51
; CPs
ocpb-master1         IN      A       10.0.6.32
ocpb-master2         IN      A       10.0.6.33
ocpb-master3         IN      A       10.0.6.34
; Workers
ocpb-worker1         IN      A       10.0.6.35  
ocpb-worker2         IN      A       10.0.6.36
```