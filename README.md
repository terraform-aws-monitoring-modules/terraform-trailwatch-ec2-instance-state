<p align="center">
  <a href="https://github.com/terraform-trailwatch-modules" title="Terraform Trailwatch Modules"><img src="https://raw.githubusercontent.com/terraform-trailwatch-modules/art/refs/heads/main/logo.jpg" height="100" alt="Terraform Trailwatch Modules"></a>
</p>

<h1 align="center">Elastic Compute Cloud (EC2)</h1>

<p align="center">
  <a href="https://github.com/terraform-trailwatch-modules/terraform-trailwatch-ec2/releases" title="Releases"><img src="https://img.shields.io/badge/Release-1.0.1-1d1d1d?style=for-the-badge" alt="Releases"></a>
  <a href="https://github.com/terraform-trailwatch-modules/terraform-trailwatch-ec2/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-MIT-1d1d1d?style=for-the-badge" alt="License"></a>
</p>

## About
This Terraform module creates CloudWatch Log Metric Filters and associated Alarms to monitor EC2 instance state changes, based on specified events. It ensures that critical instance state changes are tracked and alerts are sent to a specified SNS topic.

## Features
- Creates CloudWatch Log Metric Filters for specified EC2 instances.
- Sets up CloudWatch Alarms that trigger based on state changes detected in the filters.
- Flexible configuration for monitored events and alarm settings.

## Requirements
- Terraform 1.0 or later
- AWS Provider

## Inputs

| Variable                                      | Description                                                                                          | Type           | Default                                                   |
|-----------------------------------------------|------------------------------------------------------------------------------------------------------|----------------|-----------------------------------------------------------|
| `ec2_instance_ids`                            | List of EC2 instance IDs to monitor.                                                                 | `list(string)` | n/a                                                       |
| `ec2_instance_state_events`                   | List of EC2 instance-related state events to monitor.                                                | `list(string)` | `["RunInstances", "StopInstances", "StartInstances", "TerminateInstances"]` |
| `cw_log_group_name`                           | Name of the CloudWatch log group storing CloudTrail logs.                                            | `string`       | n/a                                                       |
| `cw_metric_filter_namespace`                  | Namespace for the CloudWatch metric filter.                                                          | `string`       | `EC2/Monitoring`                                          |
| `cw_metric_filter_value`                      | Value to publish to the CloudWatch metric.                                                           | `string`       | `1`                                                       |
| `cw_metric_filter_alarm_comparison_operator`  | Comparison operator for the CloudWatch metric filter alarm.                                          | `string`       | `GreaterThanOrEqualToThreshold`                           |
| `cw_metric_filter_alarm_evaluation_periods`   | Number of periods over which data is compared to the specified threshold.                            | `number`       | `1`                                                       |
| `cw_metric_filter_alarm_period`               | Period in seconds over which the specified statistic is applied.                                     | `number`       | `300`                                                     |
| `cw_metric_filter_alarm_statistic`            | Statistic to apply to the alarm's associated metric.                                                 | `string`       | `Sum`                                                     |
| `cw_metric_filter_alarm_threshold`            | Value against which the specified statistic is compared.                                             | `number`       | `1`                                                       |
| `cw_metric_filter_alarm_actions`              | List of actions to execute when the alarm transitions into an ALARM state.                           | `list(string)` | `[]`                                                      |

## Simple Example
```hcl
module "terraform_trailwatch_ec2" {
  source                         = "terraform-trailwatch-modules/ec2/trailwatch"
  ec2_instance_ids               = ["i-12345678", "i-87654321"]
  cw_log_group_name              = "the-cloudtrail-log-group"
  cw_metric_filter_alarm_actions = ["arn:aws:sns:region:account-id:sns-topic"]
}
```

## Advanced Example
```hcl
module "terraform_trailwatch_ec2" {
  source                                     = "terraform-trailwatch-modules/ec2/trailwatch"
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
