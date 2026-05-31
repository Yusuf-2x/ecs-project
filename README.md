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

## Docker Setup

## Terraform Infrastructure

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
