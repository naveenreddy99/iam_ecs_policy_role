resource "aws_iam_policy" "policy" {
  for_each = fileset(path.module, "policy_documents/*")
  
  name = trimsuffix(basename(each.value), ".json")
  policy = file(each.value)
}


resource "aws_iam_role" "role" {
  for_each = fileset(path.module, "role_documents/*")
  name = trimsuffix(basename(each.value), ".json")

  assume_role_policy = file(each.value)
}

resource "aws_iam_role_policy_attachment" "developer-attach" {
  count     = length(var.roles["developer"])
  role       = aws_iam_role.role["role_documents/developer.json"].name
  policy_arn =  aws_iam_policy.policy["policy_documents/${var.roles["developer"][count.index]}.json"].arn
}

resource "aws_iam_role_policy_attachment" "devops-attach" {
  count     = length(var.roles["devops"])
  role       = aws_iam_role.role["role_documents/devops.json"].name
  policy_arn =  aws_iam_policy.policy["policy_documents/${var.roles["devops"][count.index]}.json"].arn
}