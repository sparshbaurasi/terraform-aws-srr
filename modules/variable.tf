variable "provider_region" {
    default = "us-east-1"
}
# variable "role_name" {
#     default = "s3_replication_role"
# }
# variable "role_policy_name" {
#     default = "s3_replication_role_policy"
# }

variable "bucket_versioning_status_toggle" {
    default = "Enabled"
}
# variable "replication_rule_id" {
     
#     default = "id"
# }
variable "replication_rule_status" {
     
    default = "Enabled"
}
variable "replication_rule_destination_storage_class" {
   default = "STANDARD"
}
variable "source_bucket_name" {
     
}
variable "destination_bucket_name" {
    
}