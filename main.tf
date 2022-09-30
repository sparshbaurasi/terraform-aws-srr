module "my-s3rep" {
    source = "./module"
    source_bucket_name = "Your_source_bucket_name"
    destination_bucket_name = "Your_destination_bucket_name"
}

