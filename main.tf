provider "aws" {
    region = "us-east-2"

    ## Forma 1
    #access_key = ""
    #secret_key = ""

    ## Forma 2
    # export AWS_SECRET_ACCESS_KEY=
    # export AWS_ACCESS_KEY_ID=

    ## Forma 3
    # Instalar o AWS CLI
    # AWS configure
}

resource "aws_instance" "efs_server_2" {
    ami = var.ami_id # Define a imagem do SO
    instance_type = var.instance_type # Define qual é o tipo da instância
    availability_zone = var.avail_zone # Defino qual é a minha zona de disponibilidade
    key_name = "ohio"

    user_data = <<EOF
                    #!/bin/bash
                    yum install -y amazon-efs-utils
                    mkdir /mnt/efs
                    mount -t efs -o tls fs-0def155c622f750fc:/ /mnt/efs
                EOF

    tags = {
        Name = "${var.env_prefix}-server"
    }

} 
