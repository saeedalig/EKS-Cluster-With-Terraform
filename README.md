
# Task-1 : Set up AWS EKS Cluster using Terraform


## EKS Cluster using Terraform
- VPC
- Two Availability Zones using `data block`
- Two Public Subnets
- Two Private Subnets
- Internet Gateway
- Route Tables (Public and Private)
- Route Table Association (Public and Private Subnets)
- Security Group
- Nat Gateways in Public Subnets
- `Bastion Host` (Jump Server) to interact with EKS Cluster
- EKS Cluster in Private Subnets to make it more secure

# Prerequisites
- Create a separate user and assign roles in AWS to perform specific tasks
- Configure `aws cli`
- Create `Backend Block` to store Terraform state file in `S3 Bucket`

## Terraform Lifecycle
- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply --auto-approve
- terraform destroy --auto-approve


## Update Kubeconfig
- once EKS cluster is created, you can access the instance in private subnets using `jump server(bastion-host)`.
- Since I've added script to install kubectl in terraform, you just need to update kubeconfig file to set the context by running below command:
    ```
    aws eks update-kubeconfig --region ap-south-1 --name my-eks-cluster --profile default
    ```
    Make sure to replace profile in case you have different.

Verify 
`kubectl get all`

### I have used custom module to create EKS Cluster to showcase my ability when it comes to Terraform. I can't claim this to be perfect but put all efforts in it. However, it can be improved as per the need and organization practices.

### This whole set up can also be done using the modules provided by Terraform Registery.





# Task-2: Deploy a Stateless Service (e.g., Nginx) in a Scalable Manner

- Navigate to respective folder and apply to create resources in EKS Cluster by running below command:
    ```
    kubectl apply -f <file_names>
    ```
- Verify them. I haven't created separate namespace for the app. If you do, make sure to pass namespace in below command
    ```
    kubectl get all
    ```



