resource "aws_instance" "from_terraform" {
    ami = "ami-0caf778a172362f1c"
#    count  = 3
    instance_type = "t2.micro"
    key_name = var.key
    tags = {
       Name = "from_terrbhai"
   }
     
 provisioner "file" {
  source = "terraform.sh"
   destination = "/home/ubuntu/terraform.sh"
 }


   provisioner "remote-exec"{
    inline = [
       " chmod 700 /home/ubuntu/terraform.sh", 
       "sudo -s | /home/ubuntu/terraform.sh"
     ]
   }
   connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/ubuntu/tf/test-demo.pem")
#       file("${path.}/test-demo.pem")
      host = aws_instance.from_terraform.public_ip
   }

}