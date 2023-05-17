resource "aws_iam_role" "SecretRead_role" {
  name = "Secret-Read"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_policy" "secret_policy" {
  name   = "secret-policy"
  policy = file("secret_role.json")

}

resource "aws_iam_role_policy_attachment" "SM_role_policy_attachment" {
  role       = aws_iam_role.SecretRead_role.name
  policy_arn = aws_iam_policy.secret_policy.arn
}

resource "aws_iam_role" "s3_role" {
  name = "s3-Access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_policy" "s3_policy" {
  name   = "s3-access-policy"
  policy = file("s3_role.json")

}

resource "aws_iam_role_policy_attachment" "s3_role_policy_attachment" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
