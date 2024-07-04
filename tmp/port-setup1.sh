docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  -v /:/host \
  -v portainer_agent_data:/data \
  --restart always \
  -e EDGE=1 \
  -e EDGE_ID=914b639e-4b27-4f22-85e6-44e1abe84295 \
  -e EDGE_KEY=aHR0cDovLzE5Mi4xNjguMC4xMjo5MDAwfDE5Mi4xNjguMC4xMjo4MDAwfHJ1V21uZW54UCsvNVpyLzYyV2RxQmR5aXFjLzVEcGJDVFBKVW83dmFVMDQ9fDg \
  -e EDGE_INSECURE_POLL=1 \
  --name portainer_edge_agent \
  portainer/agent:2.19.5
  
