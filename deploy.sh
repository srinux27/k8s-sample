docker build -t srinux27/fib-client:latest -t srinux27/fib-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t srinux27/fib-server:latest -t srinux27/fib-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t srinux27/fib-worfer:latest -t srinux27/fib-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push srinux27/fib-client:latest
docker push srinux27/fib-server:latest
docker push srinux27/fib-worker:latest

docker push srinux27/fib-client:$SHA
docker push srinux27/fib-server:$SHA
docker push srinux27/fib-worker:$SHA

kubectl apply -f kube-files
kubectl set image deployments/server-deployment api=srinux27/fib-server:$SHA
kubectl set image deployments/client-deployment client=srinux27/fib-client:$SHA
kubectl set image deployments/worker-deployment worker=srinux27/fib-worker:$SHA
