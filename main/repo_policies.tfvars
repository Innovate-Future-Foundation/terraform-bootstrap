# SSO Management
sso_repo_policies = {
  access-control = [
    "AWSConfigRoleForOrganizations",
    "AWSSSOMemberAccountAdministrator",
    "SSOManagementPowerUserPolicy",
  ]
}

# Production Env
prod_repo_policies = {
  fe-infra = [
    "FrontendS3Policy",
    "FrontendBucketConfigPolicy",
    "CloudFrontPowerUserPolicy",
    "FrontendRoute53AcmPolicy",
  ]
  be-infra = [
    "NetworkPowerUserPolicy",
    "CloudMapPowerUserPolicy",
    "ECRPowerUserPolicy",
    "LogGroupInFFUserPolicy",
    "ManageECSRolePolicy",
    "ECSPowerUserPolicy",
    "AmazonAPIGatewayAdministrator",
    "RoleManagementPolicy",
  ]
  fe = [
    "CloudFrontPowerUserPolicy",
  ]
  be = [
    "CentralECRTaggingPolicy",
  ]
}

# UAT Env
uat_repo_policies = {
  fe-infra = [
    "FrontendS3Policy",
    "FrontendBucketConfigPolicy",
    "CloudFrontPowerUserPolicy",
    "FrontendRoute53AcmPolicy",
  ]
  be-infra = [
    "NetworkPowerUserPolicy",
    "CloudMapPowerUserPolicy",
    "ECRPowerUserPolicy",
    "LogGroupInFFUserPolicy",
    "ManageECSRolePolicy",
    "ECSPowerUserPolicy",
    "AmazonAPIGatewayAdministrator",
    "RoleManagementPolicy",
  ]
  fe = [
    "CloudFrontPowerUserPolicy",
  ]
  be = [
    "CentralECRPublishingPolicy",
  ]
}