docker build -t lovenic/multi-client:latest -t lovenic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lovenic/multi-server:latest -t lovenic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lovenic/multi-worker:latest -t lovenic/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lovenic/multi-client:latest
docker push lovenic/multi-client:$SHA
docker push lovenic/multi-server:latest
docker push lovenic/multi-server:$SHA
docker push lovenic/multi-worker:latest
docker push lovenic/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lovenic/multi-server:$SHA
kubectl set image deployments/client-deployment client=lovenic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lovenic/multi-worker:$SHA

