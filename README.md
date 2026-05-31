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

## Docker Setup


The application is containerised using Docker so it can run consistently across local development, GitHub Actions, and AWS ECS.

### Build the Docker image

From the project root:

```bash
docker build -t threatmod .

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

### VPC Module

### Security Module

### ECR Module

### ALB Module

### ECS Module

### ACM Module

### Route53 Module

## CI/CD Pipelines

### App Deploy Pipeline

### Terraform Deploy Pipeline

### Terraform Destroy Pipeline

## Architecture Diagram

## Screenshots

## Troubleshooting

## Future Improvements
