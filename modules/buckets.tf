resource "aws_s3_bucket" "destination_bucket" {
  bucket = var.destination_bucket_name
}

resource "aws_s3_bucket_versioning" "destination_versioning" {
  bucket = var.destination_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [aws_s3_bucket.destination_bucket]
}

resource "aws_s3_bucket_versioning" "source_versioning" {
  bucket = var.source_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [aws_s3_bucket.destination_bucket]
}

resource "aws_s3_bucket_replication_configuration" "replication" {
     
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source_versioning]

  role   = aws_iam_role.replication_role_s3.arn
  bucket = var.source_bucket_name

  rule {
    id = "${var.source_bucket_name}.${var.destination_bucket_name}-rule-id"
    status = var.replication_rule_status
    destination {
      bucket        = aws_s3_bucket.destination_bucket.arn
      storage_class = var.replication_rule_destination_storage_class
    }
  }
}
