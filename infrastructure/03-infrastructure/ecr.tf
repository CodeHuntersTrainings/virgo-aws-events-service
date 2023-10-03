resource "aws_ecr_repository" "events-service-ecr" {
  count = var.ecr-enabled ? 1 :0

  name = "eventsserviceecr"

  tags = {
    Name        = "eventsserviceecr"
  }
}

resource "aws_ecr_lifecycle_policy" "events-service-ecr-lifecycle-policy" {
  count = var.ecr-enabled ? 1 :0

  repository = aws_ecr_repository.events-service-ecr[0].name

  policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Keep last 2 images",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 2
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}