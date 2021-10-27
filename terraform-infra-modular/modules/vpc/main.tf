resource "aws_vpc" "cyber94_bdeadfield_cal_2_vpc_tf" {
    cidr_block = "10.21.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "cyber94_bdeadfield_cal_2_vpc"
    }
}


resource "aws_route53_zone" "cyber94_bdeadfield_cal_2_vpc_dns_tf" {
  name = "cyber-21.sparta"

  vpc {
    vpc_id = aws_vpc.cyber94_bdeadfield_cal_2_vpc_tf.id
  }
}
