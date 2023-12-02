.PHONY: clean np pr apply-np apply-pr destroy-np destroy-pr
.DEFAULT_GOAL := clean

ENVIRONMENT = $(word 2,$@)
BACKEND_CONFIG = config/$(ENVIRONMENT).config
VAR_FILE = $(ENVIRONMENT).tfvars
PLAN_FILE = terraform-$(ENVIRONMENT).tfplan

clean:
	rm -rf .terraform
	rm -f terraform-np.tfplan
	rm -f terraform-pr.tfplan

np: clean
	terraform init --backend-config=config/np.config
	terraform plan -var-file=np.tfvars -out=terraform-np.tfplan

pr: clean
	terraform init --backend-config=config/pr.config
	terraform plan -var-file=pr.tfvars -out=terraform-pr.tfplan

apply-np:
	terraform apply terraform-np.tfplan

apply-pr:
	terraform apply terraform-pr.tfplan

destroy-np:
	terraform destroy -var-file=np.tfvars 

destroy-pr:
	terraform destroy -var-file=pr.tfvars 	
