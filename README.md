 # ECS ThreatMod Deployment Project

## Project Overview

This project deploys a containerised ThreatMod application to AWS using Docker, Amazon ECR, ECS Fargate, an Application Load Balancer, Route53, ACM, Terraform, and GitHub Actions.

The application is packaged into a Docker image and pushed to Amazon ECR under the `threatmod` repository. Terraform is used to provision the AWS infrastructure, including a custom VPC, public and private subnets, security groups, an Application Load Balancer, ECS Fargate service, ACM certificate, and Route53 DNS record.

The application is designed to be accessed through the custom domain:

https://tm.yusufdevops.online

## Features

- **Containerised application**: The ThreatMod application is packaged into a Docker image so it can run consistently across local, CI/CD, and AWS environments.
- **Amazon ECR integration**: Docker images are pushed to Amazon Elastic Container Registry under the `threatmod` repository.
- **ECS Fargate deployment**: The application is deployed as an ECS Fargate service using the `threatmod-cluster` and `threatmod-service`.
- **Application Load Balancer**: Public traffic is routed through an ALB named `threatmod-alb`.
- **HTTPS with ACM**: An ACM certificate is used to secure the application with HTTPS.
- **Route53 DNS**: The custom domain `tm.yusufdevops.online` points to the ALB.
- **Terraform modules**: Infrastructure is split into modules for VPC, security groups, ECR, ALB, ECS, ACM, and Route53.
- **Remote Terraform state**: Terraform state is stored remotely in S3.
- **GitHub Actions CI/CD**: Pipelines are used for application image deployment, Terraform deployment, and Terraform destroy. 

## Local Setup

To run the application locally, clone the repository and install the Node.js dependencies.

```bash
git clone https://github.com/Yusuf-2x/ecs-project.git
cd ecs-project/app
npm install --legacy-peer-deps
npm start
```

## Docker Setup


The application is containerised using Docker so it can run consistently across local development, GitHub Actions, and AWS ECS.

### Build the Docker image

From the project root:

```bash
docker build -t threatmod .
```

## Terraform Infrastructure

Terraform is used to provision the AWS infrastructure for this project. The Terraform code is stored in the `infra/` directory and uses a modular structure rather than one large configuration file.

The infrastructure includes:

- Custom VPC
- Public and private subnets
- Internet gateway and route tables
- Security groups for the ALB and ECS service
- Amazon ECR repository
- ECS Fargate cluster, task definition, and service
- Application Load Balancer
- Target group and listeners
- ACM certificate for HTTPS
- Route53 DNS record for `tm.yusufdevops.online`

Terraform state is stored remotely in an S3 backend, which allows the infrastructure state to be managed safely outside the local machine.

## Terraform Module Breakdown

The Terraform code is split into separate modules to keep the infrastructure organised, reusable, and easier to maintain.

### VPC Module

The VPC module creates the custom network for the project. It provisions the VPC, public subnets, private subnets, internet gateway, route table, and route table associations.

The public subnets are used for internet-facing resources such as the Application Load Balancer. The private subnets are intended for backend resources such as ECS tasks.

### Security Module

The security module creates the security groups used by the ALB and ECS service.

The ALB security group allows inbound HTTP and HTTPS traffic from the internet. The ECS security group only allows inbound traffic from the ALB security group on port `3000`.

### ECR Module

The ECR module creates the Amazon Elastic Container Registry repository named `threatmod`.

This repository stores the Docker image built by the GitHub Actions application pipeline.

### ALB Module

The ALB module creates the Application Load Balancer, target group, and listeners.

The ALB receives public traffic and forwards it to the ECS service through the target group. The HTTPS listener uses the ACM certificate for secure traffic.

### ECS Module

The ECS module creates the ECS Fargate cluster, task definition, ECS service, and IAM execution role.

The ECS service runs the Docker container using the image stored in ECR and connects it to the ALB target group.

### ACM Module

The ACM module creates an AWS Certificate Manager certificate for `tm.yusufdevops.online`.

### Route53 Module

The Route53 module creates a DNS A record that points the custom domain `tm.yusufdevops.online` to the Application Load Balancer, making the application accessible via HTTPS.

## CI/CD Pipelines

This project uses GitHub Actions to automate application delivery and infrastructure management.

### App Deploy Pipeline

The App Deploy pipeline builds the Docker image and pushes it to Amazon ECR.

Workflow file: `.github/workflows/app-deploy.yml`

### Terraform Deploy Pipeline

The Terraform Deploy pipeline provisions the AWS infrastructure by running `terraform apply`.

Workflow file: `.github/workflows/terraform-deploy.yml`

### Terraform Destroy Pipeline

The Terraform Destroy pipeline tears down the AWS infrastructure by running `terraform destroy`.

Workflow file: `.github/workflows/terraform-destroy.yml`

## Architecture Diagram

## Screenshots

The following screenshots should be added before final submission:

- Application running locally
- Docker image built successfully
- Docker container running locally
- Amazon ECR repository showing pushed image
- ECS cluster and service
- ECS task running
- Application Load Balancer
- Target group health check
- ACM certificate issued
- Route53 DNS record for `tm.yusufdevops.online`
- GitHub Actions App Deploy pipeline
- GitHub Actions Terraform Deploy pipeline
- GitHub Actions Terraform Destroy pipeline
- Live application running at `https://tm.yusufdevops.online`

## Troubleshooting

During this project, I ran into and resolved several issues:

- **Dockerfile missing in GitHub Actions**  
  The App Deploy pipeline initially failed because the repository did not have a Dockerfile in the root directory. I fixed this by creating a project Dockerfile and `.dockerignore`.

- **ECS image pull failure**  
  ECS failed with `CannotPullContainerError` because the `latest` image tag was not available in ECR. This was fixed by updating the App Deploy pipeline to tag and push both the commit SHA and `latest`.

- **GitHub Actions OIDC issue**  
  GitHub Actions initially could not assume the AWS IAM role. I fixed this by updating the IAM trust policy so the role could be assumed by the `Yusuf-2x/ecs-project` repository.

- **Target group health checks**  
  The ALB target group showed unhealthy targets while debugging the ECS service. This required checking the ECS task status, target group health reason, security groups, container port, and health check path.

- **Terraform resource conflicts**  
  Some resources already existed from the manual ClickOps stage. I deleted the manually created resources before allowing Terraform to recreate and manage them properly.

## Future Improvements

Future improvements for this project include:

- Add a dedicated `/health` endpoint to the application for cleaner ALB health checks.
- Add a NAT Gateway so ECS tasks can run fully inside private subnets while still pulling images from ECR.
- Add Trivy scanning to check Docker images for vulnerabilities.
- Add TFLint to improve Terraform code quality.
- Improve IAM permissions by replacing broad permissions with least-privilege policies.
- Add CloudWatch log groups for better ECS task logging and debugging.
- Add separate environments such as development, staging, and production.
- Add automated post-deployment health checks in GitHub Actions.
