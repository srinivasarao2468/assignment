###==========================================================================================
# Creation of auto scaling Policies for eks asg
###==========================================================================================
resource "aws_autoscaling_policy" "autoscaling_policy" {
  count                  = length(local.asg_names)
  name                   = local.asg_names[count.index]
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = local.asg_names[count.index]

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40.0
  }

  depends_on = [
    aws_eks_node_group.eks_node_group
  ]
}
