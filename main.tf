resource "aws_vpc" "myvpc" {
    cidr_block       = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = "MyVPC-created-using-module",
        CreatedBy = "Sourav"
    }
}

data "aws_availability_zones" "all_azs" {
  
}

# output "all_avail_zones" {
#   value = data.aws_availability_zones.all_azs
# }
resource "aws_subnet" "my_private_subnet" {
    # count = length(data.aws_availability_zones.all_azs.names)
    count = length(var.subnet_cidr)
    vpc_id     = aws_vpc.myvpc.id
    # cidr_block = var.private_subnet_cidr[count.index]
    # cidr_block = "172.20.${count.index}.0/24"
    cidr_block = var.subnet_cidr[count.index]
    availability_zone = data.aws_availability_zones.all_azs.names[count.index]
    # tags = {
    #     Name = "MyPrivateSubnet_${count.index + 1}",
    #     CreatedBy = "Sourav"
    # }
    tags = var.tag_names
}


output "vpc_id" {
  value = aws_vpc.myvpc.id
}

# data "aws_vpc" "myvpc" {
#   id = aws_vpc.myvpc.id
# }

# resource "aws_subnet" "my_private_subnet_123" {
#     vpc_id     = data.aws_vpc.myvpc.id
#     cidr_block = "172.20.2.0/24"

#     tags = {
#         Name = "MyPrivateSubnet3",
#         CreatedBy = "Sourav"
#     }
# }