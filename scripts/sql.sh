kubectl exec -it  --namespace cockroach  cockroachdb-client-secure -- ./cockroach sql --certs-dir=/cockroach/cockroach-certs --certs-dir=/cockroach-certs --host=cockroachdb-public 
