## I. Concepts
### Node labels
When create a node, we can mark some labels for it.
On AWS nodes are assigned by default some labels such as:

```
node.kubernetes.io/instance-type=t3.xlarge
kubernetes.io/arch=amd64
node.kubernetes.io/instance-type=t3.xlarge
```
### Node taints
A node taint lets you mark a node to prevent using it for Pods.

A taint consists of a key, value, and effect.

Available effect values:

- NoSchedule
 - New pods that do not match the taint are not scheduled onto that node.
 - Existing pods on the node remain.

- PreferNoSchedule
 - New pods that do not match the taint might be scheduled onto that node, but the scheduler tries not to.
 - Existing pods on the node remain.

- NoExecute
 - New pods that do not match the taint cannot be scheduled onto that node.
 - Existing pods on the node that do not have a matching toleration are removed.
 - Pods that tolerate the taint and specifies `tolerationSeconds` remain bound for the specified amount of time. After that time elapses, this pod will be evicted.

## II. Assigning Pods to Nodes
There are 2 main ways to schedule a pod into a specific node:

### 1/ nodeSelector (pod) - node labales (node)
`spec.nodeSelector` is a map that specific the node labels that this pod want to be deployed on.

### 2/ toleration (pod) - taint (node)
Pods that have suitable toleration with the node's taint will be scheduled to the node. The matching rule includes the matching key, value, and the valid rule of `effect` described above.

## Reference
- https://www.densify.com/kubernetes-autoscaling/kubernetes-taints/
- https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
