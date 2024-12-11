resource "aws_kms_key" "rotation_key" {
  description             = "KMS key for encrypting password rotation data"
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "rotation_key_alias" {
  name          = "alias/password-rotation-key"
  target_key_id = aws_kms_key.rotation_key.id
}

