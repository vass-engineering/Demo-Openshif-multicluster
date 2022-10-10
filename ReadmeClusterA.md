
1.  Configure vsphere.yaml adding your variables:

```
    cd OcpMulticlusterV1
    vi .config/vmwareConf/vsphere.yaml
```

2. Download and import the OVA.

* From VShpere Navigate to files, select a folder for templates, and select Deploy OVF Template using the next URL

```
https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/rhcos-vmware.x86_64.ova
```


3. Convert the VM to a template ready for Terraform.

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/main/DocsImages/DeployOVFTemplate.png)


4. Add two VmWare pools. 

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/main/DocsImages/VmWarePools.png)


5. Download binaries for OCP
   
```
cd $HOME/OcpMulticlusterV1/
./downloadClientandBinaries.sh
```

6. Generate the SSH KEY  and added to install-config.yaml


```
    cd $HOME/OcpMulticlusterV1/ClusterA/sshKeys/
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
cd $HOME/OcpMulticlusterV1/ClusterA/
vi install-config.yaml
```

```
sshKey: 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJPehYsDsrmM+yK6hhPpoG6Rflh284s06tNA+XcPeVC labmulticluster@bastion.labs.vass.es'
```

7. Download your installation pull secret from  Red Hat OpenShift Cluster Manager added to install-config.yaml

```
    The pull secret from the Red Hat OpenShift Cluster Manager. This pull secret allows you to authenticate with the services that are provided by the included authorities, including Quay.io, which serves the container images for OpenShift Container Platform components.
    https://console.redhat.com/openshift/install/pull-secret
```

```
cd $HOME/OcpMulticlusterV1/ClusterA/
vi install-config.yaml
```

```
pullSecret: '{"auths":{"cloud.openshift.com":{"auth":"b3...............
```

8. Generate ignition files for instalation.

```
cd $HOME/OcpMulticlusterV1/ClusterA
./generate-configs.sh 
```

9. Generate in Vmware the VirtualMachines with terraform and add the ingnition files to the VMs.

* First review all the variables in order to accommodate the installation to your infrastructure.

```  
vi /HOME/OcpMulticlusterV1/ClusterA/main.tf
vi /HOME/OcpMulticlusterV1/ClusterA/terraform.tfvars
vi /HOME/OcpMulticlusterV1/ClusterA/variables.tf
```

* Deploy with Terraform.

```
cd $HOME/OcpMulticlusterV1/ClusterA/clusters/4.11
terraform init
terraform apply
```

1.  Install Openshift
   
```
cd $HOME/OcpMulticlusterV1/ClusterA/openshift 
openshift-install wait-for install-complete --log-level debug
```

11. From another terminal Check installation process

```
cd $HOME/OcpMulticlusterV1/ClusterA

oc --kubeconfig openshift/auth/kubeconfig get csr
oc --kubeconfig openshift/auth/kubeconfig get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc --kubeconfig openshift/auth/kubeconfig adm certificate approve
oc --kubeconfig openshift/auth/kubeconfig get nodes
oc --kubeconfig openshift/auth/kubeconfig get co
```

12. During installation approve the csr

```
oc --kubeconfig openshift/auth/kubeconfig get csr
oc --kubeconfig openshift/auth/kubeconfig get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc --kubeconfig openshift/auth/kubeconfig adm certificate approve
```

13.  Wait for installation completed.

```
DEBUG Cluster is initialized                       
INFO Waiting up to 10m0s (until 1:37PM) for the openshift-console route to be created... 
DEBUG Route found in openshift-console namespace: console 
DEBUG OpenShift console route is admitted          
INFO Install complete!                            
INFO To access the cluster as the system:admin user when using 'oc', run 
INFO     export KUBECONFIG=/home/labmulticluster/OcpMulticlusterV1/ClusterA/openshift/auth/kubeconfig 
INFO Access the OpenShift web-console here: https://console-openshift-console.apps.ocpa.labs.vass.es 
INFO Login to the console with user: "kubeadmin", and password: "xxxxx" 
DEBUG Time elapsed per stage:                      
DEBUG Cluster Operators: 22m34s                    
INFO Time elapsed: 22m34s  
```

14. Shutdown Bootstrap virtual machine. And remember to comment/delete the entry in the HA-proxy or in your load balancer