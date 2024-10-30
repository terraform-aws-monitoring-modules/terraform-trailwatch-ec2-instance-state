<p align="center">
  <a href="https://github.com/terraform-trailwatch-modules" title="Terraform Trailwatch Modules"><img src="https://raw.githubusercontent.com/terraform-trailwatch-modules/art/refs/heads/main/logo.jpg" height="100" alt="Terraform Trailwatch Modules"></a>
</p>

<h1 align="center">Elastic Compute Cloud (EC2)</h1>

<p align="center">
  <a href="https://github.com/terraform-trailwatch-modules/terraform-trailwatch-ec2/releases" title="Releases"><img src="https://img.shields.io/badge/Release-1.0.0-1d1d1d?style=for-the-badge" alt="Releases"></a>
  <a href="https://github.com/terraform-trailwatch-modules/terraform-trailwatch-ec2/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-MIT-1d1d1d?style=for-the-badge" alt="License"></a>
</p>

## About
This Terraform module creates CloudWatch Log Metric Filters and associated Alarms to monitor EC2 instance state changes, based on specified events. It ensures that critical instance state changes are tracked and alerts are sent to a specified SNS topic.

## Features
- Creates CloudWatch Log Metric Filters for specified EC2 instances.
- Sets up CloudWatch Alarms that trigger based on state changes detected in the filters.
- Flexible configuration for monitored events and alarm settings.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.46 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cw_log_group_name"></a> [cw\_log\_group\_name](#input\_cw\_log\_group\_name) | The name of the CloudWatch log group storing CloudTrail logs. | `string` | n/a | yes |
| <a name="input_cw_metric_filter_alarm_actions"></a> [cw\_metric\_filter\_alarm\_actions](#input\_cw\_metric\_filter\_alarm\_actions) | The list of actions to execute when the alarm transitions into an ALARM state from any other state. | `list(string)` | `[]` | no |
| <a name="input_cw_metric_filter_alarm_comparison_operator"></a> [cw\_metric\_filter\_alarm\_comparison\_operator](#input\_cw\_metric\_filter\_alarm\_comparison\_operator) | The comparison operator for the CloudWatch metric filter alarm. | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_cw_metric_filter_alarm_evaluation_periods"></a> [cw\_metric\_filter\_alarm\_evaluation\_periods](#input\_cw\_metric\_filter\_alarm\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold. | `number` | `1` | no |
| <a name="input_cw_metric_filter_alarm_period"></a> [cw\_metric\_filter\_alarm\_period](#input\_cw\_metric\_filter\_alarm\_period) | The period in seconds over which the specified statistic is applied. | `number` | `300` | no |
| <a name="input_cw_metric_filter_alarm_statistic"></a> [cw\_metric\_filter\_alarm\_statistic](#input\_cw\_metric\_filter\_alarm\_statistic) | The statistic to apply to the alarm's associated metric. | `string` | `"Sum"` | no |
| <a name="input_cw_metric_filter_alarm_threshold"></a> [cw\_metric\_filter\_alarm\_threshold](#input\_cw\_metric\_filter\_alarm\_threshold) | The value against which the specified statistic is compared. | `number` | `1` | no |
| <a name="input_cw_metric_filter_namespace"></a> [cw\_metric\_filter\_namespace](#input\_cw\_metric\_filter\_namespace) | The namespace for the CloudWatch metric filter. | `string` | `"EC2/Monitoring"` | no |
| <a name="input_cw_metric_filter_value"></a> [cw\_metric\_filter\_value](#input\_cw\_metric\_filter\_value) | The value to publish to the CloudWatch metric. | `string` | `"1"` | no |
| <a name="input_ec2_instance_ids"></a> [ec2\_instance\_ids](#input\_ec2\_instance\_ids) | List of EC2 instance IDs to monitor. | `list(string)` | n/a | yes |
| <a name="input_ec2_instance_state_events"></a> [ec2\_instance\_state\_events](#input\_ec2\_instance\_state\_events) | List of EC2 instance-related state events to monitor. | `list(string)` | <pre>[<br/>  "RunInstances",<br/>  "StopInstances",<br/>  "StartInstances",<br/>  "TerminateInstances"<br/>]</pre> | no |
<!-- END_TF_DOCS -->

## Simple Example
```hcl
module "terraform_trailwatch_ec2" {
  source                         = "terraform-trailwatch-modules/ec2/aws"
  ec2_instance_ids               = ["i-12345678", "i-87654321"]
  cw_log_group_name              = "the-cloudtrail-log-group"
  cw_metric_filter_alarm_actions = ["arn:aws:sns:region:account-id:sns-topic"]
}
```

## Advanced Example
```hcl
module "terraform_trailwatch_ec2" {
  source                                     = "terraform-trailwatch-modules/ec2/aws"
  ec2_instance_ids                           = ["i-12345678", "i-87654321"]
  ec2_instance_state_events                  = ["RunInstances", "StopInstances"]
  cw_log_group_name                          = "the-cloudtrail-log-group"
  cw_metric_filter_namespace                 = "EC2/Monitoring"
  cw_metric_filter_value                     = "1"
  cw_metric_filter_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cw_metric_filter_alarm_evaluation_periods  = 1
  cw_metric_filter_alarm_period              = 300
  cw_metric_filter_alarm_statistic           = "Sum"
  cw_metric_filter_alarm_threshold           = 1
  cw_metric_filter_alarm_actions             = ["arn:aws:sns:region:account-id:sns-topic"]
}
```

## Changelog
For a detailed list of changes, please refer to the [CHANGELOG.md](CHANGELOG.md).

## License
This module is licensed under the [MIT License](LICENSE).
