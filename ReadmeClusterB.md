1. Generate the SSH KEY  and added to install-config.yaml

```
    cd $HOME/OcpMulticlusterV1/ClusterB/sshKeys/
    ssh-keygen -t ed25519 -N '' -f id_ed25519
    eval "$(ssh-agent -s)"
    ssh-add  id_ed25519
```

```
cat id_ed25519.pub 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJPehYsDsrmM+yK6hhPpoG6Rflh284s06tNA+XcPeVC labmulticluster@bastion.labs.vass.es
```

 * Add the ssh pub key to install-config.yaml file.

```
cd $HOME/OcpMulticlusterV1/ClusterB
vi install-config.yaml
```

```
sshKey: 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJPehYsDsrmM+yK6hhPpoG6Rflh284s06tNA+XcPeVC labmulticluster@bastion.labs.vass.es'
```

2. Download your installation pull secret from the Red Hat OpenShift Cluster Manager and added to install-config.yaml

```
	The pull secret from the Red Hat OpenShift Cluster Manager. This pull secret allows you to authenticate with the services that are provided by the included authorities, including Quay.io, which serves the container images for OpenShift Container Platform components.
    https://console.redhat.com/openshift/install/pull-secret
```

```
cd $HOME/OcpMulticlusterV1/ClusterB/
vi install-config.yaml
```

```
pullSecret: '{"auths":{"cloud.openshift.com":{"auth":"b3...............
```

3. Generate ignition files for instalation.

```
cd $HOME/OcpMulticlusterV1/ClusterB
./generate-configs.sh 
```

4. Generate in Vmware the VirtualMachines with terraform and add the ingnition files to the VMs.

* First review all the variables in order to accommodate the installation to your infrastructure.

```  
vi /HOME/OcpMulticlusterV1/ClusterA/main.tf
vi /HOME/OcpMulticlusterV1/ClusterA/terraform.tfvars
vi /HOME/OcpMulticlusterV1/ClusterA/variables.tf
```
* Deploy with Terraform.

```
cd $HOME/OcpMulticlusterV1/ClusterB/clusters/4.11
terraform init
terraform apply
```

5. Install Openshift
   
```
cd $HOME/OcpMulticlusterV1/ClusterB/openshift
openshift-install wait-for install-complete --log-level debug
```

6. From another terminal Check installation process

```
cd $HOME/OcpMulticlusterV1/ClusterB
oc --kubeconfig openshift/auth/kubeconfig get csr
oc --kubeconfig openshift/auth/kubeconfig get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc --kubeconfig openshift/auth/kubeconfig adm certificate approve
oc --kubeconfig openshift/auth/kubeconfig get nodes
oc --kubeconfig openshift/auth/kubeconfig get co
```

7. During installation approve the csr

```
cd $HOME/OcpMulticlusterV1/ClusterB
oc --kubeconfig openshift/auth/kubeconfig get csr
oc --kubeconfig openshift/auth/kubeconfig get csr -o json | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc --kubeconfig openshift/auth/kubeconfig adm certificate approve
```

8.  Wait for installation completed.

```
DEBUG Cluster is initialized                       
INFO Waiting up to 10m0s (until 1:37PM) for the openshift-console route to be created... 
DEBUG Route found in openshift-console namespace: console 
DEBUG OpenShift console route is admitted          
INFO Install complete!                            
INFO To access the cluster as the system:admin user when using 'oc', run 
INFO     export KUBECONFIG=/home/labmulticluster/OcpMulticlusterV1/ClusterA/openshift/auth/kubeconfig 
INFO Access the OpenShift web-console here: https://console-openshift-console.apps.ocpb.labs.vass.es 
INFO Login to the console with user: "kubeadmin", and password: "xxxxx" 
DEBUG Time elapsed per stage:                      
DEBUG Cluster Operators: 22m34s                    
INFO Time elapsed: 22m34s  
```

9. Shutdown Bootstrap virtual machine. And remember to comment/delete the entry in the HA-proxy or in your load balancer