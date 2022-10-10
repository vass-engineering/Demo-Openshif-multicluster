1. Install Operator Advanced Cluster Management for Kubernetes


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/1InstallOperatorAdClusterManagement.png)


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/2InstallOperatorAdClusterManagement.png)


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/3InstallOperatorAdClusterManagement.png)

2. Create MulticlusterHub

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/4InstallOperatorAdClusterManagement.png)


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/5InstallOperatorAdClusterManagement.png)

3. Check Installation completed

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/6InstallOperatorAdClusterManagement.png)


![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/7InstallOperatorAdClusterManagement.png)


4. Access to Advanced Cluster Management for Kubernetes

* Check console route to acces:
  
![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/AccessToMultiCludConsole.png)

* Access to the console
  
![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/AdvanceClusterMngK8sConsole.png)


5. Import an existing cluster

* Go to Clusters and click Import cluster 
  
![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/0ImportCluster.png)

* Add the information required. We will use import mode 

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/1ImportAnExistingCluster.png)

* Review the information and click in generate the command

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/2ImportAnExistingCluster.png)

* Click "Copy command"

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/3ImportAnExistingCluster.png)

* From a terminal, login with OC in your managed cluster as system:admin, the one that you will managed from " Advanced Cluster Management for Kubernetes"

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/4ImportAnExistingCluster.png)


* Paste the command that we have copied.

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/5ImportAnExistingCluster.png)


6. From the console "Advanced Cluster Management for Kubernetes", navigate to clusters and you will be abel to view your cluster managament.

![alt text](https://github.com/vass-engineering/Demo-Openshif-multicluster/blob/master/DocsImages/1ClusterAdded.png)