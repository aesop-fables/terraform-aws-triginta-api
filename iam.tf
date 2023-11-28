data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "app_role" {
  name               = "${var.app_name}_app_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
