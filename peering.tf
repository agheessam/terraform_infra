# Create the VPC Peering Connection
resource "aws_vpc_peering_connection" "dev_to_prod" {
  vpc_id        = aws_vpc.Development.id
  peer_vpc_id   = aws_vpc.Production.id
  auto_accept   = true  # Set to true if you want to automatically accept the connection

  tags = {
    Name = "DevToProdPeering"
  }
}
# Add routes to the Development VPC route table
resource "aws_route" "dev_to_prod_route" {
  route_table_id         = aws_route_table.pvt_route.id  # Replace with your Development VPC route table
  destination_cidr_block = aws_vpc.Production.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.dev_to_prod.id
}

# Add routes to the Production VPC route table
resource "aws_route" "prod_to_dev_route" {
  route_table_id         = aws_route_table.prodpvt_route.id  # Replace with your Production VPC route table
  destination_cidr_block = aws_vpc.Development.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.dev_to_prod.id
}