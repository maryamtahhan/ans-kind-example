# Abstract Socket Example in K8s

The goal of this example is to show that abstract sockets
are tied to network namespaces and an abstract socket
created in one pod cannot be accessed by another pod when
they don't share the same network namespace.

The example uses socat to create an abstract socket in a
pod called server-pod. The example then also creates a
client called client-pod that also uses socat to try to connect
to the abstract socket. The connection attempt will fail.

## Getting Started

This example assumes you have docker, kind and kubectl already installed.

### Create the kind cluster + build the docker image + launch the pods

```cmd
$ make
```

### Get the client pod logs

```cmd
$ make client-logs
kubectl logs client-pod
2023/12/11 12:59:56 socat[1] E connect(, AF=1 "\0@test", 8): Connection refused
```

