resource "aws_subnet" "cyber94_bdeadfield_cal_2_subnet_web_tf" {
  vpc_id = var.var_aws_vpc_id
  cidr_block = "10.21.1.0/24"

  tags = {
    Name = "cyber94_bdeadfield_cal_2_subnet_web"
  }
}
