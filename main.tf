provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "AutomationInstance" {
  ami           = "ami-0e731c8a588258d0d"
  instance_type = "t2.micro"
  key_name      = "Kp"  # Adjust key_name if necessary
  security_groups = ["AutomationSG"]

  tags = {
    Name = "AutomationInstance"
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "sudo yum install jq",
      "sudo yum update -y",
      "sudo yum install python3 -y",
      "sudo yum install python3-pip -y",
      "sudo pip3 install mysql-connector-python "
    ]
  
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/SuperMan/Desktop/Kp.pem")
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "C:/Users/SuperMan/Desktop/RailProject"
    destination = "/home/ec2-user/RailProject"
    
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/SuperMan/Desktop/Kp.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user/RailProject", // Change directory to RailProject
      "python3 Main.py" // Run Python script
    ]
  
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/SuperMan/Desktop/Kp.pem")
      host        = self.public_ip
    }
  }
}

output "public_ip" {
  value = aws_instance.AutomationInstance.public_ip
}
