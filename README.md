# Terraform Bootstrap
The main terraform repository for managing other terraform repos
- Provision backends (S3, DynamoDB) 
- Setup OIDC and roles to assume

> **Notice:** <br> This terraform repo also requires remote backend setup and authentication configs, you will have to either create them manually from the cloud console or use a script to provision them.

