start:
	ctlptl apply -f ./cluster.yaml
	telepresence helm install
	docker compose up --build -d
	docker buildx build --push -t localhost:5011/my-gateway --target my-gateway .
	helm upgrade --install my-gateway ./my-gateway
	docker buildx build --push -t localhost:5011/my-proxy --target my-proxy .
	helm upgrade --install my-proxy ./my-proxy

intercept:
	telepresence intercept my-proxy --mechanism=http --preview-url=false --mount=false --workload=my-proxy --port 3000:3000 --http-header=my-header=1

stop:
	telepresence leave my-proxy
	docker compose down
	ctlptl delete -f ./cluster.yaml

