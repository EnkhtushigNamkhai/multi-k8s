# image building, push to docker, apply all configs in k8s folder, imperatively set latest images on each deployment
docker build -t enkhtushig/multi-client:latest -t enkhtushig/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t enkhtushig/multi-server:latest -t enkhtushig/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t enkhtushig/multi-worker:latest -t enkhtushig/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push enkhtushig/multi-client:latest
docker push enkhtushig/multi-server:latest
docker push enkhtushig/multi-worker:latest
docker push enkhtushig/multi-client:$SHA
docker push enkhtushig/multi-server:$SHA
docker push enkhtushig/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=enkhtushig/multi-server:$SHA
kubectl set image deployments/client-deployment client=enkhtushig/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=enkhtushig/multi-worker:$SHA

