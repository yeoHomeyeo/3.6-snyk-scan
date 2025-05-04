data "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${var.lambda_function_name}"
}

data "aws_iam_policy_document" "inline_policy_cloudwatch" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [data.aws_cloudwatch_log_group.lambda_log_group.arn]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name                     = var.iam_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}