resource "aws_s3_bucket" "password_store" {
  bucket = "password-rotation-store"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm    = "aws:kms"
        kms_master_key_id = aws_kms_key.rotation_key.arn
      }
    }
  }
}

