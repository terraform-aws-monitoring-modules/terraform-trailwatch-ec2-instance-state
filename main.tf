resource "aws_cloudwatch_log_metric_filter" "ec2_instance_state_metric_filter" {
  count          = length(var.ec2_instance_ids)
  log_group_name = var.cw_log_group_name
  name           = "${var.ec2_instance_ids[count.index]}-instance-state-metric-filter"
  pattern        = format("{ ($.eventSource = ec2.amazonaws.com) && ($.requestParameters.instancesSet.items[*].instanceId = \"${var.ec2_instance_ids[count.index]}\") && ($.eventName = \"${join("\" || $.eventName = \"", var.ec2_instance_state_events)}\") }")

  metric_transformation {
    name      = "${var.ec2_instance_ids[count.index]}-instance-state-metric-filter"
    namespace = var.cw_metric_filter_namespace
    value     = var.cw_metric_filter_value
  }
}

resource "aws_cloudwatch_metric_alarm" "elb_metric_filter_alarm" {
  count               = length(var.ec2_instance_ids)
  alarm_name          = "${var.ec2_instance_ids[count.index]}-metric-filter-alarm"
  comparison_operator = var.cw_metric_filter_alarm_comparison_operator
  evaluation_periods  = var.cw_metric_filter_alarm_evaluation_periods
  metric_name         = "${var.ec2_instance_ids[count.index]}-metric-filter"
  namespace           = var.cw_metric_filter_namespace
  period              = var.cw_metric_filter_alarm_period
  statistic           = var.cw_metric_filter_alarm_statistic
  threshold           = var.cw_metric_filter_alarm_threshold
  alarm_description   = "Alarm when ELB ${var.ec2_instance_ids[count.index]} has >= 1 data points within 5 minutes."
  alarm_actions       = var.cw_metric_filter_alarm_actions
}
