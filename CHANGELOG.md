# Changelog

## [1.0.0] - 2024-10-30

### Added
- Initial release of the EC2 Instance State Monitoring module.
- Support for monitoring specified EC2 instances using custom CloudWatch log metric filters and alarms.
- Configurable parameters for EC2 instance IDs, state change events, and CloudWatch log settings.
- Automatic creation of CloudWatch metric filters based on specified EC2 instance IDs and monitored events.
- Alarms triggered based on defined thresholds for selected instance state changes.
- Detailed variable descriptions for streamlined customization and configuration.

### Changed
- Updated Terraform examples in [`README.md`](README.md) to reference the module source from the Terraform Registry.
- Updated the `alarm_description` in the [`main.tf`](main.tf).

### Fixed
- Corrected `metric_name` parameter in `aws_cloudwatch_metric_alarm` to ensure proper linkage with `aws_cloudwatch_log_metric_filter` resource.

