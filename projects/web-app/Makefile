# export AWS_PROFILE ?= "AWS_PROFILE"

APP = "web-server"

#in the init, use -reconfigure if things are throwing errors


init:
	terraform init \
		-get=true \
		-upgrade 
	# -backend-config=backend.tfvars

plan: init
	terraform plan \
		-out=tfplan \
		# -var-file=${APP}.tfvars \

apply:
	terraform apply \
		tfplan \
		# -var-file=${APP}.tfvars \

destroy: plan 
	terraform destroy \
		# -var-file=${APP}.tfvars \
import:
	terraform import \
		# -var-file=${APP}.tfvars \

refresh:
	terraform refresh \
		# -var-file=${APP}.tfvars \
