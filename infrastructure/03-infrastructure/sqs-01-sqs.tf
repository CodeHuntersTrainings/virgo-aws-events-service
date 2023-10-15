resource "aws_sqs_queue" "codehunters-sqs-events" {
  count = var.queue-enabled ? 1 : 0

  name                        = "codehunters-events-sqs"
  delay_seconds               = 10
  visibility_timeout_seconds  = 30
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 2
}