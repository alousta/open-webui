#Debugging Steps:
#Verify Ollama is Accessible: From your host machine, try curl http://localhost:11434/v1/models 
# (or the equivalent for your OS). If this doesn't work, Ollama itself is not running or accessible.
#Check Container Logs: Examine the logs of the OpenWebUI container (podman logs open-webui). 
#Look for any error messages related to connecting to Ollama.
#exec into the Container: Use podman exec -it open-webui bash to get a shell inside the OpenWebUI container. 
#Then, try curl http://<YOUR_HOST_IP>:11434/v1/models (or curl http://ollama:11434/v1/models if using a user-defined network) from inside the container. This helps isolate whether the problem is network connectivity or DNS resolution.
#local mac ip address: 172.20.10.6
#podman exec -it open-webui bash
#Then, try curl http://<YOUR_HOST_IP>:11434/v1/models (or curl http://ollama:11434/v1/models
#ssh root@9.30.215.131
#psDDKC6?T3JJXgKYGwrjnpJV
#Install ollama cli
#curl -fsSL https://ollama.com/install.sh | sh
#root | dSC7*Aaz8Py@qk!Cr?g@UZVT
curl http://localhost:11434/v1/models
podman ps -a
podman stop open-webui
podman rm open-webui
#this podman run command in line 20 is to run Ollama locally in mac laptop
#podman run -d --network slirp4netns:allow_host_loopback=true -p 3000:8080 -e OLLAMA_BASE_URL=http://host.containers.internal:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
#podman run -d --network host -p 3000:8080 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
podman run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
podman ps -a
curl http://localhost:11434/v1/models
#once open-webui podman pod is up and running make sure to
# confirm that open-web ui is up and change open-webui general settings===>connectivity ollama
#connections...change it to 127.0.0.1:11434