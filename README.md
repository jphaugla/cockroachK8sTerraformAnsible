# cockroachTerraformAnsible Deploy CockroachDB on kubernetes using terraform and ansible
## Purpose
Demo deployment of Single Region CockroachDB on kubernetes using terraform and ansible.  Has GKE (Google) and AKS (Azure) terraform deployments.  THe Ansible code is deployed from a terraform provisioner in each cloud provider.  
Ansible code differences between cloud providers is minimal.  The ansible code could also be used in on-premise situations.

## Useful Links

* [Deploy CockroachDB on kubernetes](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* [Python Virtual Environment](https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/)
* [Install ansible on mac using pip]()
## Set up to run kubernetes on mac
Prior to Mac OS 14, using a global python3 worked with ansible.  It no longer works well-using [venv](https://docs.python.org/3/library/venv.html) instead.
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

### Run using GKE (Google) or AKS (Microsoft Azure)
####  Run GKE
* set the parameters in the main [terraform job file](terraform/test/main.tf)
    * main.tf file includes version information such as gke_release_channel, gcp credentials, region and zone
    * no need to set the variables in [main parameter file](ansible/cockroach/vars/main.yml)
    * this parameter file is only needed for reruns to disable parts of the operation
  
##### Terraform creation
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
* To finish the steps referenced above, continue at [Step 5](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual#step-4-access-the-db-console)
  
#### Run AKS
* set the parameters in the main [terraform job file](terraform-azure/test/main.tf)
  * main.tf file includes version information such as gke_release_channel, gcp credentials, region and zone
  * no need to set the variables in [main parameter file](ansible/cockroach/vars/main.yml)
  * this parameter file is only needed for reruns to disable parts of the operation

##### Terraform creation
kick off terraform creation but must re-initialize aks if a cluster t
```bash
source ansible-venv/bin/activate
cd terraform-azure/test
terraform init
terraform apply --auto-approve
```
* The terraform and ansible will deploy using the steps referenced in [this cockroachDB documentation](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* To finish the steps referenced above, continue at [Step 5](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual#step-4-access-the-db-console)
### Ansible documentation
* In each of the terraform directories, the ansible is initiated using provisioning.tf
  * For AKS, [provisioning.tf](terraform-azure/provisioning.tf)
  * For GKE, [provisioning.tf](terraform/provisioning.tf)
* The common ansible code is [ansible](ansible)
  * There are directories here for the [certificates](ansible/certs) and the [ca cert](ansible/my-safe-directory)
  * The [cockroach](ansible/cockroach) directory has the ansible and k8s code to deploy cockroach on kubernetes
  * The common [playbook.yml](ansible/playbook.yml) starts to kubernetes ansible
