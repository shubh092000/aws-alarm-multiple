variable "instance_ids" {
  default = ["i-036c6f15aa0b5dc12", "i-048780e5302d0eb37"]  # Replace with your actual instance IDs
}

variable "metrics" {
  default = {
    "CPUUtilization" = 80
    "NetworkIn"      = 1000000  # Example threshold for NetworkIn (1 MB)
    "NetworkOut"     = 500000   # Example threshold for NetworkOut (500 KB)
  }
}

locals {
  metric_alarms = flatten([
    for instance_id in var.instance_ids : [
      for metric, threshold in var.metrics : {
        instance_id = instance_id
        metric_name = metric
        threshold   = threshold
      }
    ]
  ])
}
