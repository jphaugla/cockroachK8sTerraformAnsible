# cockroachGKE Deploy CockroachDB on kubernetes using terraform and ansible
## Purpose
Demo deployment of Single Region CockroachDB on kubernetes using terraform and ansible.  Initial terraform deployment
is for GKE but plan to do other kubernetes platforms.  Ansible should be work across all kubernetes platforms.

## Useful Links

* [Deploy CockroachDB on kubernetes](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* [Python Virtual Environment](https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/)
* [Install anible on mac using pip]()
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
### Run GKE
* set the parameters in the main [terraform job file](terraform/test/main.tf)
    * main.tf file includes version information such as gke_release_channel, gcp credentials, region and zone
    * no need to set the variables in [main parameter file](ansible/cockroach/vars/main.yml)
    * this parameter file is only needed for reruns to disable parts of the operation

#### Terraform creation
kick off the terraform creation-the gke creation takes a very long time-over 10 minutes
```bash
cd terraform/test
terraform init
terraform apply --auto-approve
```
* The terraform and ansible will deploy using the steps referenced in [this cockroachDB documentation](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual)
* To finish the steps referenced above, continue at [Step 5](https://www.cockroachlabs.com/docs/stable/orchestrate-a-local-cluster-with-kubernetes?filters=manual#step-4-access-the-db-console)