resource "aws_spot_fleet_request" "cheap_compute" {
  iam_fleet_role      = var.iam_fleet_role
  allocation_strategy = var.allocation_strategy
  target_capacity     = var.target_capacity

  dynamic "launch_specification" {
    for_each = [
      for pair in setproduct(var.instance_types, var.availability_zones) : {
        instance_type = pair[0].type
        weighted      = pair[0].weighted
        az            = pair[1]
      }
    ]

    content {
      instance_type     = launch_specification.value.instance_type
      ami               = var.ami
      key_name          = var.key_name
      availability_zone = launch_specification.value.az
      weighted_capacity = launch_specification.value.weighted

      root_block_device {
        volume_size = var.volume_config.size
        volume_type = var.volume_config.type
      }

      tags = merge(
        var.tags,
        {
          Name = "k8s-spot-${replace(launch_specification.value.instance_type, ".", "-")}"
        }
      )
    }
  }
}