tf-sec:
	trivy config --severity=CRITICAL,HIGH ./
pre-commit-install:
	pre-commit install
pre-commit-run:
	pre-commit run --all-files
tf-validate:
	cd iac && terraform validate
