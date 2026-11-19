# Rancher Terraform

This repository contains Infrastructure as Code (IaC) configurations using **Terraform** to provision and manage **Rancher** environments and downstream Kubernetes clusters.

## 📋 Prerequisites

Before getting started, ensure you have the following installed and configured:

* [Terraform](https://developer.hashicorp.com/terraform/downloads) (`>= 1.5.0`)
* [kubectl](https://kubernetes.io/docs/tasks/tools/) (optional, for cluster validation)
* Access and configured credentials for your target cloud or infrastructure provider (e.g., AWS, Azure, vSphere, Harvester, etc.)
* A reachable Rancher Server instance (if using the `rancher2` provider to manage downstream clusters)

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/mmoreira-suse/rancher-terraform.git](https://github.com/mmoreira-suse/rancher-terraform.git)
   cd rancher-terraform
   ```

2. **Configure credentials and variables:**
   Export your AWS credentials as environment variables so Terraform can authenticate automatically:
   ```bash
   export AWS_ACCESS_KEY_ID="your-aws-access-key-id"
   export AWS_SECRET_ACCESS_KEY="your-aws-secret-access-key"
   ```

   Create a `terraform.tfvars` file if you'd like to define your Rancher credentials and environment parameters:
   ```hcl
   rancher_api_url   = "[https://rancher.your-domain.com](https://rancher.your-domain.com)"
   rancher_token_key = "token-xxxxx:yyyyyyyyyyyyyyyyyyyy"
   ```
   > **Note:** Do not commit `terraform.tfvars`, `.tfstate` files, or hardcode AWS credentials into version control.
   
3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Review the execution plan:**
   ```bash
   terraform plan
   ```

5. **Apply the infrastructure:**
   ```bash
   terraform apply
   ```

## 🧹 Cleanup

To tear down the resources provisioned by this project:
```bash
terraform destroy
```

## 📁 Repository Structure

```text
.
├── main.tf           # Main resource definitions
├── variables.tf      # Input variable declarations
├── outputs.tf        # Outputs generated after apply (e.g., kubeconfig, endpoints)
├── versions.tf       # Required Terraform and provider versions
└── README.md         # Initial project documentation
```
