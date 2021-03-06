# build deployment images and push to docker
docker build -t shadrach19/multi-client:lastest -t shadrach19/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shadrach19/multi-server:lastest  -t shadrach19/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shadrach19/multi-worker:lastest  -t shadrach19/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shadrach19/multi-client:lastest
docker push shadrach19/multi-server:lastest
docker push shadrach19/multi-worker:lastest

docker push shadrach19/multi-client:$SHA
docker push shadrach19/multi-server:$SHA
docker push shadrach19/multi-worker:$SHA

# start kubernetes using k8s folder
kubectl apply -f k8
kubectl set image deployments/server-deployment multi-server=shadrach19/multi-server:$SHA
kubectl set image deployments/client-deployment multi-client=shadrach19/multi-client:$SHA
kubectl set image deployments/worker-deployment multi-worker=shadrach19/multi-worker:$SHA