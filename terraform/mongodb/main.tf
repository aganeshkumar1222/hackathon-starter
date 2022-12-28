# EC2 Instance: MongoDB 1
resource "aws_instance" "mongodb_one" {
    availability_zone = "${var.AWS_REGION}a"

    tags = {
        Name = "${var.ENVIRONMENT}-mongodb-one"
    }

    ami = "ami-0a6b2839d44d781b2"

    instance_type = "t2.micro"

    root_block_device {
        volume_type = "gp2"
        volume_size = "100"
    }

    security_groups = [
        "${aws_security_group.mongodb.name}"
    ]

    associate_public_ip_address = true

}



# MongoDB security group
resource "aws_security_group" "mongodb" {
  name        = "mongodb-${var.ENVIRONMENT}"
  description = "Security group for mongodb-${var.ENVIRONMENT}"

  tags = {
    Name = "mongodb-${var.ENVIRONMENT}"
  }
}

resource "aws_security_group_rule" "mongodb_allow_all" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mongodb.id}"
}

resource "aws_security_group_rule" "mongodb_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mongodb.id}"
}

resource "aws_security_group_rule" "mongodb_mongodb" {
  type            = "ingress"
  from_port       = 27017
  to_port         = 27017
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mongodb.id}"
}

resource "aws_security_group_rule" "mongodb_mongodb_replication" {
  type            = "ingress"
  from_port       = 27019
  to_port         = 27019
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.mongodb.id}"
}
