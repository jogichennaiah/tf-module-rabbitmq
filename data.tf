# Reads the information from the remote statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
     bucket  = "b55-terraform-bucket"
     key     = "vpc/${var.ENV}/terraform.tfstate"
     region  = "us-east-1" 
  }
}

# Datasource to fetch the info of AMI
data "aws_ami" "ami" {
   most_recent      = true
  name_regex       = "b55-chinna-lab-image"
  owners           = ["self"]
}

# fetches the information of the secret
data "aws_secretsmanager_secret" "secrets" {
  name = "robot/secrets"
}

# Fetches the secrets version from the above server
data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}