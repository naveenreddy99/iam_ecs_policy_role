roles = {
  devops_task_execution_role = ["devops_task_execution_policy"]
  devops_task_role = ["devops_task_policy"]
}

task_execution_role_managed_policies     = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]