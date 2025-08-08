kubectl config set-context --current --namespace kube-system
kubectl get pods
kubectl describe ebs-csi-node-9s2p8
kubectl describe pod/ebs-csi-node-9s2p8
kubectl describe pod/ebs-csi-node-9s2p8
kubectl describe pod/ebs-csi-node-9s2p8
# this tends to show the error Unexpected failure when attempting to remove node taint(s)" err="isAllocatableSet: driver not found on node 
kubectl logs pod/ebs-csi-node-9s2p8
kubectl get all -l app.kubernetes.io/name=aws-ebs-csi-driver -n kube-system
kubectl logs deployment/ebs-csi-controller -n kube-system -c ebs-plugin
kubectl logs daemonset/ebs-csi-node -n kube-system -c ebs-plugin
kubectl logs deployment/ebs-csi-controller -n kube-system -c csi-provisioner
kubectl logs deployment/ebs-csi-controller -n kube-system -c csi-attacher
kubectl get sa ebs-csi-controller-sa -n kube-system -o jsonpath='{.metadata.annotations}'
# this was the fix for this but I think it is actually ok because last message is the same
kubectl rollout restart daemonset -n kube-system ebs-csi-node
kubectl logs daemonset/ebs-csi-node -n kube-system -c ebs-plugin
kubectl logs deployment/ebs-csi-controller -n kube-system -c csi-attacher
kubectl get all -l app.kubernetes.io/name=aws-ebs-csi-driver -n kube-system
kubectl logs pod/ebs-csi-node-9s2p8
kubectl get pods
kubectl logs pod/ebs-csi-node-6dvn
# this shows the pvc disaster
kubectl describe pvc
kubectl get storageclass --all-namespaces
kubectl describe storageclass --all-namespaces
Name:            gp2
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"gp2"},"parameters":{"fsType":"ext4","type":"gp2"},"provisioner":"kubernetes.io/aws-ebs","volumeBindingMode":"WaitForFirstConsumer"}

Provisioner:           kubernetes.io/aws-ebs
Parameters:            fsType=ext4,type=gp2
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     WaitForFirstConsumer
Events:                <none>
