module "my-s3rep" {
    source = "./module"
    source_bucket_name = "test-bucket-replication-sss-sdb"
    destination_bucket_name = "test-dest-bucket-replication-sss-sdb"
}

