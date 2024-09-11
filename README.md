# cockroachTerraformAnsible Deploy CockroachDB on kubernetes using terraform and ansible
## Purpose
Demo deployments of CockroachDB with kubernetes using terraform and ansible.  Has GKE (Google), EKS (AWS)  and AKS (Azure) terraform deployments.  The Ansible code is deployed from a terraform provisioner subdirectory for each cloud provider.  Ansible code differences between cloud providers are minimal.  The ansible code could also be used in on-premise situations.

## Outline
- [Useful Links](#useful-links) 
- [K8s and ansible on macOS](#k8s-ansible-on-mac)
- [Single Region](#single-region)
  - [Single Region GKE](#gke)
    - [Terraform Creation GKE](#terraform-creation-gke)
  - [Single Region EKS](#eks)
    - [Terraform Creation GKE](#terraform-creation-gke)
  - [Single Region AKS](#aks)
    - [Terraform Creation AKS](#terraform-creation-aks)
- [Multi region](#multi-region)
    - [GKE](#gke-multi-cluster)
- [Ansible Documentation](#ansible-documentation)
## Useful Links
* [Deploy CockroachDB on kubernetes using manual config files](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* [Single Region CockroachDB](https://www.cockroachlabs.com/docs/stable/deploy-cockroachdb-with-kubernetes)
* [Multi-Cluster Deployment](https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster)
* [Python Virtual Environment](https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/)
## k8s ansible on mac
Prior to Mac OS 14, using a global python3 worked with ansible.  It no longer works well-using [venv](https://docs.python.org/3/library/venv.html) instead.
easiest to install ansible with *brew install ansible*
```bash
python3 -m venv ansible-venv
source ansible-venv/bin/activate
pip3 install requests
pip3 install google-auth
pip3 install kubernetes
pip3 install psycopg2
brew install ansible
```
Make sure to run terraform and ansible with this environment sourced

## Single Region
### GKE
* set the parameters in the main [terraform job file](terraform/test/main.tf)
    * main.tf file includes version information such as gke_release_channel, gcp credentials, region and zone
    * no need to set the variables in [main parameter file](ansible/cockroach/vars/main.yml)
    * this parameter file is only needed for reruns to disable parts of the operation
  
#### Terraform creation GKE
kick off terraform creation-the gke creation takes a very long time-over 10 minutes
```bash
source ansible-venv/bin/activate
cd terraform/test
terraform init
terraform apply --auto-approve
```
* The terraform and ansible will deploy using the steps referenced in [this cockroachDB documentation](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* To connect with the GCP need to run *gcloud container clusters get-credentials*
  * The appropriate parameters for this are available in the GCP cloud interface by selecting the cluster and clicking on the *connect* link near the top of the UI
  * Set the context to the *cockroach* namespace with *kubectl config set-context --current --namespace=cockroach*
* To finish the steps referenced above, continue at [Step 3.  Use the Built-in SQL Client at substep 2.](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual#step-3-use-the-built-in-sql-client)
  
#### Terraform creation EKS
kick off terraform creation-the eks creation takes a long time-over 10 minutes
```bash
source ansible-venv/bin/activate
cd terraform/test
terraform init
terraform apply --auto-approve
```
* The terraform and ansible will deploy using the steps referenced in [this cockroachDB documentation](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* To connect with the GCP need to run *gcloud container clusters get-credentials*
  * The appropriate parameters for this are available in the GCP cloud interface by selecting the cluster and clicking on the *connect* link near the top of the UI
  * Set the context to the *cockroach* namespace with *kubectl config set-context --current --namespace=cockroach*
* To finish the steps referenced above, continue at [Step 5](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual#step-4-access-the-db-console)
### EKS
* set the parameters in the main [terraform job file](terraform-aws/test/main.tf)
  * main.tf file includes version information such as cluster_prefix, credentials, IP addresses, region, vm_size, versions
  * no need to set the variables in [main parameter file](ansible/cockroach/vars/main.yml)
  * this parameter file is only needed for reruns to disable parts of the operation

#### Terraform creation AKS
kick off terraform creation but must re-initialize aks if a cluster t
```bash
source ansible-venv/bin/activate
cd terraform-azure/test
terraform init
terraform apply --auto-approve
```
* The terraform and ansible will deploy using the steps referenced in [this cockroachDB documentation](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* To finish the steps referenced above, continue at [Step 5](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual#step-4-access-the-db-console)
## Multi-region
### GKE multi-cluster
* set the parameters in the main [terraform job file](multiregionGKE/test/main.tf)
  * main.tf file includes version information such as gke_release_channel, gcp credentials, region and zone
  * no need to set the variables in [main parameter file](ansible-multiregion/cockroach/vars/main.yml)
  * this parameter file is only needed for reruns to disable parts of the operation
## Ansible documentation
* In each of the terraform directories, the ansible is initiated using provisioning.tf
  * For Single Region AKS, [provisioning.tf](terraform-azure/provisioning.tf)
  * For Single Region GKE, [provisioning.tf](terraform/provisioning.tf)
  * For Multi-Cluster GKE, [provisioning.tf](multiregionGKE/provisioning.tf)
* The common single region ansible code is [ansible](ansible)
  * There are directories here for the [certificates](ansible/certs) and the [ca cert](ansible/my-safe-directory)
  * The [cockroach](ansible/cockroach) directory has the ansible and k8s code to deploy cockroach on kubernetes
  * The common [playbook.yml](ansible/playbook.yml) starts kubernetes ansible
* The multi-cluster ansible code is [ansible-multiregion](ansible-multiregion)
  * This code implements [this multi-cluster documentation](https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster)
    * However, [step 7](https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster#step-1-start-kubernetes-clusters) in these steps which defines RBAC roles are not done.
  * The [cockroach](ansible-multiregion/cockroach) directory has the ansible and k8s code
