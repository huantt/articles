## Liveness
Liveness probes determine when to restart a container. 

If the liveness probe fails, Kubernetes considers the container to be unhealthy and takes appropriate action, such as restarting the container. Liveness probes are essential for applications that can encounter runtime issues or deadlock situations.

## Readiness
Readiness probes determine when a container is **ready to start accepting traffic**. 

This is useful when waiting for an application to perform time-consuming initial tasks, such as establishing network connections, loading files, and warming caches.

If the readiness probe returns a failed state, Kubernetes removes the pod from all matching service endpoints.

## Startup probe
A startup probe verifies whether the application within a container is started. This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.

**If such a probe is configured, it disables liveness and readiness checks until it succeeds.**

**This type of probe is only executed at startup, unlike readiness probes, which are run periodically.**

```yaml
startupProbe:
  httpGet:
    path: /health/readiness
    port: 8080
  failureThreshold: 30
  periodSeconds: 10
```

## Probes configuration

```yaml
readinessProbe:
    httpGet:
        path: /health/readiness
        port: 8080
    initialDelaySeconds: 10
    periodSeconds: 5
    successThreshold: 1
    failureThreshold: 3
    timeoutSeconds: 30
```

- `initialDelaySeconds`: The delay in seconds before the first liveness probe is performed. This allows time for the container to start up.

- `periodSeconds`: The time interval between consecutive liveness probes. It defines how frequently the probe should be performed.

- `timeoutSeconds`: The maximum amount of time given to each liveness probe to complete. If the probe exceeds this timeout, it is considered failed.

- `failureThreshold`: The number of consecutive failures allowed before considering the container as unhealthy and triggering the defined action (e.g., container restart).

- `successThreshold`: The number of consecutive successful probes required to transition a container from an unhealthy to a healthy state. This parameter helps prevent quick flapping between unhealthy and healthy states.

## Probes types
### HTTP probe
```yaml
readinessProbe:
    httpGet:
        path: /readiness
        port: 8080
```
It sends an HTTP GET request to a specified endpoint on a container's IP address and port. If the endpoint returns a successful HTTP status code (2xx or 3xx), the probe considers the container as healthy. Otherwise, it assumes the container is unhealthy.

### TCP probe
```yaml
readinessProbe:
    tcpSocket:
        port: 8080
```

It attempts to open a TCP connection to a specified port on the container. If the connection is successfully established, the container is considered healthy. Otherwise, it is considered unhealthy.


### Command probe
```yaml
readinessProbe:
  exec:
    command:
    - /script/readiness.sh
```

It executes a specified command inside the container. If the command exits with a zero status code, the container is considered healthy. Otherwise, it is considered unhealthy.

### gRPC Probe
```yaml
livenessProbe:
    grpc:
        port: 8080
```

Since Kubernetes version 1.24, the gRPC handler can be configured to be used by the kubelet for application lifetime checking. To configure checks that use gRPC, you must enable the GRPCContainerProbe function gate. You must configure the port to use a gRPC probe, and if the health endpoint is configured on a non-default service, you also need to specify the service.

## References
- https://kubeops.net/blog/kubernetes-probes
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/