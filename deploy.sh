docker build -t billtlee/multi-client:latest  -t billtlee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t billtlee/multi-server:latest -t billtlee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t billtlee/multi-worker:latest -t billtlee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push billtlee/multi-client:latest
docker push billtlee/multi-client:$SHA
docker push billtlee/multi-server:latest
docker push billtlee/multi-server:$SHA
docker push billtlee/multi-worker:latest
docker push billtlee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=billtlee/multi-server:$SHA
kubectl set image deployments/client-deployment client=billtlee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=billtlee/multi-worker:$SHA