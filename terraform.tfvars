aws_region = "us-east-1"
ami      = "ami-04631d2c883552c84" # Fedora core os 41
key_name = "kubernetes-pem"
iam_fleet_role = "arn:aws:iam::xxx:role/aws-ec2-spot-fleet-tagging-role"

instance_types = [
  {
    type     = "c5.xlarge"
    weighted = 1
  },
  {
    type     = "c5.2xlarge"
    weighted = 2
  },
  {
    type     = "c5.4xlarge"
    weighted = 4
  }
]

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

volume_config = {
  size = 50
  type = "gp3"
}

tags = {
  Environment = "production"
  Team        = "devops"
  Project     = "kubernetes"
}