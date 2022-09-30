resource "aws_iam_role" "replication_role_s3" {
  name = "${var.source_bucket_name}-rep_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
depends_on = [aws_s3_bucket.destination_bucket]
}

resource "aws_iam_policy" "replication_role_s3_policy" {
  name = "${var.source_bucket_name}.${var.destination_bucket_name}-rep_role_policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.source_bucket_name}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
         "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.source_bucket_name}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.destination_bucket_name}/*"
    }
  ]
}
POLICY
depends_on = [aws_s3_bucket.destination_bucket]
}

resource "aws_iam_role_policy_attachment" "replication_attachment" {
  role       = aws_iam_role.replication_role_s3.name
  policy_arn = aws_iam_policy.replication_role_s3_policy.arn
  depends_on = [aws_s3_bucket.destination_bucket]
}
