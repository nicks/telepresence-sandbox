# Telepresence Sandbox 

## Instructions

Install Telepresence, Docker Compose, k3d,
and ctlptl https://github.com/tilt-dev/ctlptl .

You'll need these to create a local Kubernetes cluster and local containers.

```
make start
```

This creates three proxies:

- `my-local-proxy`: Runs at localhost:3000 in Docker Compose and forwards traffic to hub.docker.com

- `my-gateway`: Runs at localhost:3005 in Kubernetes and forwards traffic to an internal service.

- `my-proxy`: Runs at :3000 in Kubernetes and forwards traffic to hub.docker.com

You can verify this with:

```
curl -v localhost:3000
curl -v localhost:3005
```

## Bug report

Run:

```
make intercept
```

to forward traffic from the proxy running in Kubernetes to the one running in Compose.

## Expected behavior

The proxies should work!

## Actual behavior

Telepresence kills all traffic with HTTP error 426

```
curl -v localhost:3005
*   Trying 127.0.0.1:3005...
* Connected to localhost (127.0.0.1) port 3005 (#0)
> GET / HTTP/1.1
> Host: localhost:3005
> User-Agent: curl/7.81.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 426 Upgrade Required
< Content-Length: 0
< Date: Tue, 09 May 2023 00:13:42 GMT
< Server: nginx/1.23.4
< 
* Connection #0 to host localhost left intact
```

## Additional Details

Interestingly, this happens for all traffic, not just the traffic being intercepted!

Once telepresence gets into this state, the only way to fix it is to uninstall the agent.

```
telepresence uninstall -d my-proxy
```

Notably, `telepresence leave` does not fix the problem.


