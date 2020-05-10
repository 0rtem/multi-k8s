#build images
docker build -t 0rtem/multi-client:latest -t 0rtem/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 0rtem/multi-server:latest -t 0rtem/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 0rtem/multi-worker:latest -t 0rtem/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#push images
docker push 0rtem/multi-client:latest
docker push 0rtem/multi-server:latest
docker push 0rtem/multi-worker:latest

docker push 0rtem/multi-client:$SHA
docker push 0rtem/multi-server:$SHA
docker push 0rtem/multi-worker:$SHA

#apply/deploy
kubectl apply -f k8s

#update images
kubectl set image deploymets/server-deployment server=stephengrider/multi-server:844b0adf6542a7dae725faa9839bb3890e6f233a
kubectl set image deploymets/client-deployment client=stephengrider/multi-client:844b0adf6542a7dae725faa9839bb3890e6f233a
kubectl set image deployment/worker-deployment client=stephengrider/multi-worker:844b0adf6542a7dae725faa9839bb3890e6f233a