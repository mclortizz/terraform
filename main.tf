#Configurar o operador
provider "aws" {
    region = "us-east-1"
  
}

#Criar o nosso bucket
resource "aws_s3_bucket" "s3_terraform" {
    bucket = "ortiztfteste"
    force_destroy = "true"
    tags = {
        Name = "Test Terraform"
        Env = "Test Env"
    }
  
}

#Setar permissão
resource "aws_s3_bucket_acl" "s3_terraform_acl" {
    bucket = aws_s3_bucket.s3_terraform.id
    acl = "public-read"
  
}

#Habilitar o versionamento do bucket
resource "aws_s3_bucket_versioning" "se_terraform_version" {
    bucket = aws_s3_bucket.s3_terraform.id
    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_terraform-lifecycle" {
    bucket = aws_s3_bucket.s3_terraform.id

    rule {
        id = "lifecycle_30_60"

        noncurrent_version_transition {
          noncurrent_days = 30
          storage_class = "STANDARD_IA"
        }

        noncurrent_version_transition {
          noncurrent_days = 60
          storage_class = "GLACIER"
        }

        status = "Enabled"

    }
  
}

#Habilitar a criptografia
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_terraform_cript" {
    bucket = aws_s3_bucket.s3_terraform.id

    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
  
}