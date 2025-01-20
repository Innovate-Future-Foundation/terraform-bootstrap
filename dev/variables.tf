variable "location" {
  type    = string
  default = "us-west-2"
}

variable "dev_bootstrap_role" {
  type = string
}

variable "organisation" {
  type    = string
  default = "Innovate-Future-Foundation"
}

variable "org_abbr" {
  type    = string
  default = "inff"
}

variable "repo_env" {
  type    = string
  default = "Development"
}

variable "sso_repo" {
  type    = string
  default = "access-control"
}

variable "repos" {
  type = list(string)
  default = [
    # "access-control"
    "Frontend"
  ]
}

variable "repo_permission" {
  type = map(list(string))
  default = {
    # "access-control" = [
    #   "IAMFullAccess",
    #   "AWSConfigRoleForOrganizations",                    # For Organization management
    #   "AWSSSOMemberAccountAdministrator",                 # For SSO management
    #   "SAMLProviderManagementPolicy"
    # ]
    
    "Frontend" = [
      # S3 permissions for static website hosting
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:PutBucketPolicy",
      "s3:GetBucketPolicy",
      "s3:PutObject",          # Upload files
      "s3:GetObject",          # Download files
      "s3:DeleteObject",       # Remove files
      "s3:ListBucket",         # List bucket contents
      "s3:PutBucketWebsite",   # Configure static website hosting

      # CloudFront permissions for CDN management
      "cloudfront:CreateDistribution",    # Create new CDN distribution
      "cloudfront:UpdateDistribution",    # Modify existing distribution
      "cloudfront:DeleteDistribution",    # Remove distribution
      "cloudfront:GetDistribution",       # Read distribution config
      "cloudfront:ListDistributions",     # List all distributions
      "cloudfront:CreateInvalidation",    # Clear cache when deploying
      
      # ACM permissions for SSL certificate management
      "acm:RequestCertificate",          # Request new SSL cert
      "acm:DeleteCertificate",           # Remove SSL cert
      "acm:DescribeCertificate",         # Get cert details
      "acm:ListCertificates",            # List all certs
      "acm:AddTagsToCertificate",        # Add tags to cert
      
      # Route53 permissions for DNS management
      "route53:ChangeResourceRecordSets", # Modify DNS records
      "route53:GetChange",                # Check DNS propagation
      "route53:ListHostedZones",          # List DNS zones
      "route53:GetHostedZone",            # Get zone details
      "route53:ListResourceRecordSets"    # List DNS records
    ]
  }
}

variable "oidc_provider_url" {
  description = "The URL for the OIDC token endpoint"
  type        = string
  default     = "https://token.actions.githubusercontent.com" # Default to GitHub Actions
}

variable "oidc_audience_url" {
  type    = string
  default = "sts.amazonaws.com"
}

variable "oidc_provider_thumbprint" {
  type        = string
  description = "The thumbprint of the OIDC provider"
}
