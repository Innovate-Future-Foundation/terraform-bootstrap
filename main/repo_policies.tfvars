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
    "ProdFrontendS3Policy",
  ]
  be = [
    "CentralECRPublishingPolicy",
    "ECSPowerUserPolicy",
    "RoleManagementPolicy",
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
    "UATFrontendS3Policy",
  ]
  be = [
    "CentralECRPublishingPolicy",
    "ECSPowerUserPolicy",
    "RoleManagementPolicy",
  ]
}