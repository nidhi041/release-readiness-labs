provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"

  tags = {
    Name        = "OrderFlow-v2.3.0-AppServer"
    Environment = "production"
    Release     = "v2.3.0"
  }
}
