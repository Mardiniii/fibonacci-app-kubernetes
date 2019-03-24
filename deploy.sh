docker build -t mardini0803/fibonacci-client:latest -t mardini0803/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t mardini0803/fibonacci-server:latest -t mardini0803/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t mardini0803/fibonacci-worker:latest -t mardini0803/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mardini0803/fibonacci-client
docker push mardini0803/fibonacci-server
docker push mardini0803/fibonacci-worker

docker push mardini0803/fibonacci-client:$SHA
docker push mardini0803/fibonacci-server:$SHA
docker push mardini0803/fibonacci-worker:$SHA

kubectl apply -f k8s

# We need a unique tag for the image in order to kubectl to update the image running
# in the deployment service
kubectl set image deployments/client-deployment client=mardini0803/fibonacci-client:$SHA
kubectl set image deployments/server-deployment server=mardini0803/fibonacci-server:$SHA
kubectl set image deployments/worker-deployment worker=mardini0803/fibonacci-worker:$SHA
