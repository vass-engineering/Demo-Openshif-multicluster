DEMO Openshift 4 Multicluster
-------------------------
-------------------------

## Introduction:

* In the next demo will see: 
  * Deploy two Clusters, named OCPA and OCPB, Openshift 4.11 using Terraform on VMware with UPI
  * Deploy Red Hat Advanced Cluster Management Foundations in OCPA Clusters.
  * Add OCPB cluster as managed cluster.
  * Set up Submariner in Red Hat Advanced Cluster Management for Kubernetes between both cluster


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/main/DocsImages/Architecture.png)

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/main/DocsImages/Architecture2.png)

## Instructions order 

1. Requirements.md

* Before to proceded, you will need a loadbalancer and a dns services. This Doc has some examples for HA-proxy and Bind DNS bind files configuration.

2. ReadmeClusterA.md

* This guide will help you to install the Openshift  Cluster 4.11 OCPA using Terraform on VMware with UPI.

3. ReadmeClusterA.md

* This guide wil help you to install the Openshift Cluster 4.11 OCPB using Terraform on VMware with UPI.

4. ReadmeClusterManagement.md

This guilde will help you to: 
   * Install Red Hat Advanced Cluster Management in the cluster OCPA.  
   *  Add OCPB cluster as managed cluster.
   *  Set up Submariner in Red Hat Advanced Cluster Management for Kubernetes between both cluster


## Notes

* The nodes distribution along VMWare servers is just for Demo proposal. In a production implementation  distribute the nodes of the clusters in order to achieve HA.

## References

* https://cloud.redhat.com/blog/how-to-install-openshift-4.6-on-vmware-with-upi
* https://github.com/submariner-io/releases/releases
* https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.6/html-single/add-ons/index#submariner
* https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.6/html-single/add-ons/index#submariner-subctl
* https://docs.openshift.com/container-platform/4.11/installing/installing_bare_metal/installing-bare-metal.html
* https://www.maquinasvirtuales.eu/vmware-crear-virtual-machine-con-terraform/
* https://cloud.redhat.com/blog/set-up-an-istio-multicluster-service-mesh-with-submariner-in-red-hat-advanced-cluster-management-for-kubernetes
* 

## Next Steps to achive

* Management observability:
  
https://cloud.redhat.com/blog/how-your-grafana-can-fetch-metrics-from-red-hat-advanced-cluster-management-observability-observatorium-and-thanos

* PV Replication