cd  ClientsAndBinaries
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.11.7/openshift-client-linux-4.11.7.tar.gz
tar -xvf openshift-client-linux-4.11.7.tar.gz
rm -rf openshift-client-linux-4.11.7.tar.gz
mv oc /usr/local/bin


wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.11.7/openshift-install-linux-4.11.7.tar.gz .
tar -xvf openshift-install-linux-4.11.7.tar.gz
rm -rf openshift-install-linux-4.11.7.tar.gz

