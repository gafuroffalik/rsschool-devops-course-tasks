# rsschool-devops-course-tasks

## Task 1
Here's a joke:  
\- System administrators are underpaid  
\- Become a DevOps like me  
\- What's that for?  
\- You'll build higload systems for 300kk/nanosecs  
\- But you just shove everything into k8s  
\- Are you nuts? I'm a yaml-developer  

## Task 2

## AWS VPC Infrastructure with Bastion + NAT (Terraform)

### Description

This project deploys AWS infrastructure using Terraform. The infrastructure is built within a single VPC and includes public and private subnets in two availability zones. NAT and Bastion host are also implemented on a single machine to access private subnets and the Internet.

### Infrastructure composition

#### VPC
- One VPC

#### Subnets
- 2 public subnet (one each in AZ1 and AZ2)
- 2 private subnet (one each in AZ1 and AZ2)

#### Internet Gateway
- Connected to VPC
- Used to access the Internet from public subnets

#### Bastion + NAT Instance
- One EC2-instance with public IP
- Deployed in public subnet AZ1
- Used for:
  - SSH access to private instances (bastion)
  - NAT for private instances to access the Internet

#### Таблицы маршрутов
- PublicRT:
  - Binds to public subnets
  - Routes `0.0.0.0/0` traffic through Internet Gateway
- PrivateRT:
  - Binds to private subnets
  - Routes `0.0.0.0/0` traffic through a NAT instance

#### Security Groups
- Bastion SG:
  - Allows incoming SSH (port 22) from restricted IP
  - Allows outgoing traffic
- SG для private-инстансов:
  - Allows SSH from Bastion
  - Allows outgoing traffic to the internet

#### Network ACL
- General NACL allowing inbound and outbound traffic between subnets and outside (by rules)

---

### Interaction scheme

Internet ↔ IGW ↔ Bastion/NAT (AZ1 - Public Subnet)  
↕  
VM (AZ2 - Public Subnet) ↔ Internet

Private Subnets (AZ1 + AZ2)  
↕ ↕  
NAT Instance → Internet

---

### Using

#### 1. Подготовка

Make sure you have installed:
- Terraform >= v1.12.1
- AWS CLI with authorization (`aws configure`)
- Access to the desired region (default: `ca-central-1`)

#### 2. Initializing Terraform

```bash
terraform init
```
#### 3. Planning for change
```bash
terraform plan
```
#### 4. Applying of infrastructure
```bash
terraform apply
```
Confirm your input with 'yes' if necessary.

### Access to instances

Use SSH to connect to Bastion:
```bash
ssh -i ~/.ssh/your-key.pem ec2-user@<bastion_public_ip>
```
Once connected to Bastion, SSH to the private instances:  

```bash
ssh ec2-user@<private_instance_ip>
```

### Removing resources
To remove the entire infrastructure, run:
```bash
terraform destroy
```
### Project structure

.  
├── main.tf               # Main module  
├── variables.tf          # Variables  
├── outputs.tf            # Output values  
├── vpc.tf                # Creating a VPC and Internet Gateway  
├── subnets.tf            # Creating subnets  
├── nat_routes.tf         # Route tables  
├── instances.tf          # EC2: NAT/Bastion instance  
├── security.tf           # Security Group and VPS ACL  
├── nacl.tf               # Network ACL  
├── version.tf            # AWS Version  
└── README.md             # Documentation  
