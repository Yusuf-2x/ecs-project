 # ECS ThreatMod Deployment Project

## Project Overview

This project deploys a containerised ThreatMod application to AWS using Docker, Amazon ECR, ECS Fargate, Application Load Balancer, Route53, ACM, Terraform, and GitHub Actions.

The goal of the project is to build a production-style DevOps workflow where the application is packaged into a Docker image, pushed to ECR, deployed onto ECS, exposed through an ALB, secured with HTTPS, and managed using Terraform.

Final domain:

https://tm.yusufdevops.online

## Features

- Dockerised ThreatMod application
- Docker image stored in Amazon ECR
- ECS Fargate service for running containers
- Application Load Balancer for public traffic
- HTTPS using AWS Certificate Manager
- Route53 DNS record for custom domain
- Terraform modules for infrastructure
- Remote Terraform state stored in S3
- GitHub Actions CI/CD pipelines

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
