gcloud container clusters get-credentials jph-gke-us-central1 --zone us-central1-a --project cockroach-jhaugland
kubectl delete namespace  us-central1-a
kubectl delete secret cockroachdb.client.root
gcloud container clusters get-credentials jph-gke-us-east1 --zone us-east1-c --project cockroach-jhaugland
kubectl delete namespace  us-east1-c
kubectl delete secret cockroachdb.client.root
gcloud container clusters get-credentials jph-gke-us-west1 --zone us-west1-a --project cockroach-jhaugland
kubectl delete namespace  us-west1-a
kubectl delete secret cockroachdb.client.root
rm -f certs/ca.crt
rm -f certs/client.root.crt	
rm -f certs/client.root.key
rm -f my-safe-directory/ca.key
