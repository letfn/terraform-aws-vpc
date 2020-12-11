SHELL := /bin/bash

test:
	$(MAKE) fmt
	$(MAKE) validate

clean:
	rm -f main.tf.json

init:
	terraform init

upgrade:
	terraform init -upgrade

fmt:
	for a in *.tf *.tfvars; do if [[ -f $$a ]]; then terraform fmt $$a; fi; done

validate:
	terraform validate

plan:
	terraform plan -out=.plan

apply:
	terraform apply .plan
	rm -f .plan

refresh:
	terraform refresh

console:
	terraform console

%:
	terraform workspace select "$(shell echo "$@" | sed 's#--#.#g')"

good:
	$(MAKE) upgrade fmt validate
	gs
