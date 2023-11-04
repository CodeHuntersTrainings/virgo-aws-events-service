resource "aws_sns_topic" "czirjak-sns-lambda-destination" {
  name = "czirjak-sns-lambda-destination"
}

resource "aws_sqs_queue" "czirjak-sqs-sns-destination" {
  name = "czirjak-sqs-sns-destination"
}

resource "aws_sns_topic_subscription" "czirjak-sqs-to-sns-integration" {
  topic_arn = aws_sns_topic.czirjak-sns-lambda-destination.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.czirjak-sqs-sns-destination.arn
}