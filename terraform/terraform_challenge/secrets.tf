data "aws_secretsmanager_secret_version" "mysql_secret_password" {
  secret_id = "mariadb-key"

}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.mysql_secret_password.secret_string

  )
}

locals {
  policy = templatefile("${path.module}/mariadb.tpl", {
    secret = local.db_creds.password

  })
}
