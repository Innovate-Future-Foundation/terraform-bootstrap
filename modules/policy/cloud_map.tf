data "aws_iam_policy_document" "cloud_map_poweruser" {
  statement {
    effect = "Allow"
    actions = [
      "servicediscovery:CreatePrivateDnsNamespace",
      "servicediscovery:DeleteNamespace",
      "servicediscovery:GetNamespace",
      "servicediscovery:ListNamespaces",
      "servicediscovery:TagResource",
      "servicediscovery:UntagResource",
      "servicediscovery:ListTagsForResource",
      "servicediscovery:GetOperation",
      "servicediscovery:ListServices",
      "servicediscovery:DeleteService",
      "servicediscovery:GetService",
      "servicediscovery:CreateService",
      "route53:CreateHostedZone",
      "route53:DeleteHostedZone",
      "route53:GetHostedZone",
      "route53:ListHostedZonesByName",
      "ec2:DescribeVpcs",
      "ec2:DescribeRegions",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloud_map_poweruser_policy" {
  name        = "CloudMapPowerUserPolicy"
  description = "Custom policy for managing Cloud Map resources"
  policy      = data.aws_iam_policy_document.cloud_map_poweruser.json
}
