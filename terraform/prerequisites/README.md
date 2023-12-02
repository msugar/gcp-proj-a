# Prerequisite

[Unable to create google project with Terraform](https://stackoverflow.com/questions/56311272/unable-to-create-google-project-with-terraform)

In order to create folders and projects, your account need to have the respective permissions and, of course you need to make sure that you are using the right account.

First make sure the user has the right permissions:
```
gcloud organizations add-iam-policy-binding YOUR_ORGANIZATION_ID --member=user:your@email.com --role=roles/billing.admin
gcloud organizations add-iam-policy-binding YOUR_ORGANIZATION_ID --member=user:your@email.com --role=roles/resourcemanager.organizationAdmin
gcloud organizations add-iam-policy-binding YOUR_ORGANIZATION_ID --member=user:your@email.com --role=roles/resourcemanager.folderCreator
gcloud organizations add-iam-policy-binding YOUR_ORGANIZATION_ID --member=user:your@email.com --role=roles/resourcemanager.projectCreator
```

Then make sure you set the application defaults and login to exactly this account:
```
gcloud auth application-default login
```

Then set a project that the API calls will be billed to by default. Read more about this [here](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/set-quota-project). If you don't set this, you might get a quota error when you run `terraform apply`.
```
gcloud auth application-default set-quota-project SOME_BILLING_PROJECT
```

```
terraform plan  -var 'env=np' -var 'project_prefix=proj-a' -state=terraform-np.tfstate -out=terraform-np.tfplan
terraform apply -state=terraform-np.tfstate terraform-np.tfplan

terraform plan  -var 'env=pr' -var 'project_prefix=proj-a' -state=terraform-pr.tfstate -out=terraform-pr.tfplan
terraform apply -state=terraform-pr.tfstate terraform-pr.tfplan
```

