docker build -t salamatburj/multi-client:latest -t salamatburj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t salamatburj/multi-server -f:latest -t salamatburj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t salamatburj/multi-worker:latest -t salamatburj/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push salamatburj/multi-client:latest
docker push salamatburj/multi-server:latest
docker push salamatburj/multi-worker:latest
docker push salamatburj/multi-client:$SHA
docker push salamatburj/multi-server:$SHA
docker push salamatburj/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=salamatburj/multi-server:$SHA
kubectl set image deployments/client-deployment client=salamatburj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=salamatburj/multi-worker:$SHA

