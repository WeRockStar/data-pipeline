# Learning How to Build Data Pipelines

![CI](https://github.com/WeRockStar/data-pipeline/actions/workflows/ci.yaml/badge.svg)

This repository is a learning project to build data pipelines using the following tools:

- Provision Infrastructure with `Terraform`
  - `GKE` - Google Kubernetes Engine
  - How to Provision, see [here](./iac/README.md)
- `Trivy` - Security Scanner and Being used in `CI`
- `pre-commit` hooks
- Continuous Integration with `GitHub Actions`
- `Airbyte` - ELT (Extract, Load, Transform)
  - [https://airbyte.werockstar.dev](https://airbyte.werockstar.dev)
- `Apache Airflow` - Workflow Management
  - [https://airflow.werockstar.dev](https://airflow.werockstar.dev)
- `dbt` (Data Build Tool) - Transform
- `Great Expectation` - Data Quality Check
- `Cloudflare` - DNS (Optional)
