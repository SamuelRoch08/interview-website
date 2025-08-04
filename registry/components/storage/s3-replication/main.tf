resource "aws_iam_role" "replication" {
  name               = "${var.project_prefix}-replication-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "replication" {
  name   = "${var.project_prefix}-replication-pol"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket_replication_configuration" "replication" {

  role   = aws_iam_role.replication.arn
  bucket = var.source_bucket_name

  rule {
    id = "${var.project_prefix}-replication"

    status = "Enabled"

    destination {
      bucket        = var.destination_bucket_arn
      storage_class = "STANDARD"
    }
  }
}