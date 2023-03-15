resource "aws_iam_policy" "example_policy" {
  for_each = fileset(path.module, "policy_documents/*")
  
  name = trimsuffix(basename(each.value), ".json")
  policy = file(each.value)
}


resource "aws_iam_role" "EksClusterRole" {
  for_each = fileset(path.module, "role_documents/*")
  name = trimsuffix(basename(each.value), ".json")

  assume_role_policy = file(each.value)
}

