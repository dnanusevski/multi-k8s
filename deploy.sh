docker build -t dnanusevski/multi-client:latest -t dnanusevski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dnanusevski/multi-server:latest -t dnanusevski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dnanusevski/multi-worker:latest -t dnanusevski/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dnanusevski/multi-client:latest
docker push dnanusevski/multi-server:latest
docker push dnanusevski/multi-worker:latest
docker push dnanusevski/multi-client:$SHA 
docker push dnanusevski/multi-server:$SHA 
docker push dnanusevski/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/client-deployment	client=dnanusevski/multi-client:$SHA
kubectl set image deployments/server-deployment	server=dnanusevski/multi-server:$SHA
kubectl set image deployments/worker-deployment	worker=dnanusevski/multi-worker:$SHA
