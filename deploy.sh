docker build -t voctez/multi-client:latest -t voctez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t voctez/multi-server:latest -t voctez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t voctez/multi-worker:latest -t voctez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push voctez/multi-client:latest
docker push voctez/multi-server:latest
docker push voctez/multi-worker:latest

docker push voctez/multi-client:$SHA
docker push voctez/multi-server:$SHA
docker push voctez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=voctez/multi-server:$SHA
kubectl set image deployments/client-deployment client=voctez/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=voctez/multi-worker:$SHA