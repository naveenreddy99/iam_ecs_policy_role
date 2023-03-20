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

resource "aws_iam_role_policy_attachment" "task-role-attach" {
  count     = length(var.roles["devops_task_role"])
  role       = aws_iam_role.role["role_documents/devops_task_role.json"].name
  policy_arn =  aws_iam_policy.policy["policy_documents/${var.roles["devops_task_role"][count.index]}.json"].arn
}

resource "aws_iam_role_policy_attachment" "task-role-execution-attach" {
  count     = length(var.roles["devops_task_execution_policy"])
  role       = aws_iam_role.role["role_documents/devops_task_execution_policy.json"].name
  policy_arn =  aws_iam_policy.policy["policy_documents/${var.roles["devops_task_execution_policy"][count.index]}.json"].arn
}