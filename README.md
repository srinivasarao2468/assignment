# ASSIGNMENT

## Prerequisites
- git bash
- AWS cli
- kubectl
- terraform

### Clone the git repository
```
 git clone https://github.com/srinivasarao2468/assignment.git
 cd assignment
```

### Run below command to initialize terraform script
```
terraform init
```

### Run below command to apply terraform script
```
terraform apply -auto-approve
```
**Note:** The above process will a while.

### [Follow the process to get EKS access](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)

### Run below command to deploy the pods to eks cluster
```
kubectl create -f deployment.yaml
```

### Run below command to deploy the service to eks cluster
```
kubectl create -f service.yaml
```
