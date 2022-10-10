
## Node IPs
master_ips = ["10.0.6.20", "10.0.6.21", "10.0.6.22"]
worker_ips = ["10.0.6.30", "10.0.6.31"]
bootstrap_ip = "10.0.6.50"

## Cluster configuration
vmware_folder = "OcpMulticluster"
rhcos_template = "rhcos-vmware.x86_64"
cluster_slug = "ocpa"
cluster_domain = "labs.vass.es"
machine_cidr = "10.0.0.0/16"
netmask ="255.255.0.0"


## DNS
local_dns = "10.0.6.5" # probably the same as coredns_ip
public_dns = "10.0.6.5" # e.g. 1.1.1.1
gateway = "10.0.2.24"


## Ignition paths
## Expects `openshift-install create ignition-configs` to have been run
## probably via generate-configs.sh
bootstrap_ignition_path = "../../openshift/bootstrap.ign"
master_ignition_path = "../../openshift/master.ign"
worker_ignition_path = "../../openshift/worker.ign"




