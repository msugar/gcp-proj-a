# Prerequisite

```
terraform plan  -var 'env=np' -var 'project_prefix=proj-a' -state=terraform-np.tfstate -out=terraform-np.tfplan
terraform apply -state=terraform-np.tfstate terraform-np.tfplan

terraform plan  -var 'env=pr' -var 'project_prefix=proj-a' -state=terraform-pr.tfstate -out=terraform-pr.tfplan
terraform apply -state=terraform-pr.tfstate terraform-pr.tfplan
```

