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
		-var-file=${APP}.tfvars \
		-out=tfplan

apply:
	terraform apply \
		-var-file=${APP}.tfvars \
		tfplan

import:
	terraform import \
		-var-file=${APP}.tfvars

refresh:
	terraform refresh \
		-var-file=${APP}.tfvars
