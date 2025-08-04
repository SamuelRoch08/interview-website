resource "aws_ecr_repository" "ecr" {
  name                 = var.repo_name
  force_delete         = var.force_delete
  image_tag_mutability = "MUTABLE"
  tags                 = var.extra_tags
}

resource "aws_ecr_lifecycle_policy" "ecr_limits" {
  repository = aws_ecr_repository.ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep only ${var.max_images_retained} images",
            "selection": {
                "countType": "imageCountMoreThan",
                "countNumber": ${var.max_images_retained},
                "tagStatus": "any"
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}