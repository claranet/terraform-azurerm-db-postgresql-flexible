## 7.5.0 (2024-07-10)


### Features

* **AZ-1432:** add administrator password creation with random_password cc0dcda


### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.7.3 0a0f552
* **deps:** update dependency tflint to v0.51.2 27b809a
* **deps:** update dependency tflint to v0.52.0 abf0227
* **deps:** update dependency trivy to v0.52.2 93e65e0
* **deps:** update dependency trivy to v0.53.0 42650db
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 9f06e11

## 7.4.0 (2024-06-14)


### Features

* add `auto_grow_enabled` and `public_network_access_enabled` new parameters 9a5e4bb


### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.7.0 14ba3ef
* **deps:** update dependency opentofu to v1.7.1 5eba199
* **deps:** update dependency opentofu to v1.7.2 d623d46
* **deps:** update dependency pre-commit to v3.7.1 544dadb
* **deps:** update dependency terraform-docs to v0.18.0 54e0aba
* **deps:** update dependency tflint to v0.51.0 b04959c
* **deps:** update dependency tflint to v0.51.1 ca7ed4a
* **deps:** update dependency trivy to v0.51.0 671c58f
* **deps:** update dependency trivy to v0.51.1 080647e
* **deps:** update dependency trivy to v0.51.2 94b535c
* **deps:** update dependency trivy to v0.51.4 9d97214
* **deps:** update dependency trivy to v0.52.0 9e8d00c
* **deps:** update dependency trivy to v0.52.1 1c30742

## 7.3.1 (2024-04-26)


### Styles

* **output:** remove unused version from outputs-module 83ce552


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] 3d01308
* **AZ-1391:** update semantic-release config [skip ci] 0254f7b


### Miscellaneous Chores

* **deps:** enable automerge on renovate 82a189b
* **deps:** update dependency trivy to v0.50.2 957f9d0
* **deps:** update dependency trivy to v0.50.4 00875ed
* **pre-commit:** update commitlint hook e940be1
* **release:** remove legacy `VERSION` file b646d7b

# v7.3.0 - 2024-03-29

Added
  * AZ-1384: Adding `authentication` block

# v7.2.0 - 2024-02-23

Changed
  * [GH-4](https://github.com/claranet/terraform-azurerm-db-postgresql-flexible/pull/4): fix: Correct casing of default PostgreSQL collation, bump provider `AzureRM` to `v3.70` minimum version

# v7.1.1 - 2023-12-08

Fixed
  * AZ-1302: Fix example

# v7.1.0 - 2023-09-21

Breaking
  * [GH-2](https://github.com/claranet/terraform-azurerm-db-postgresql-flexible/pull/2/files): Remove `retention_days` parameter for the diagnostic-settings module

# v7.0.0 - 2023-02-10

Breaking
  * AZ-930: Externalize `postgresql-users` and `postgresql-database-configuration` as separated modules in dedicated repo
  * AZ-933: Terraform 1.3 minimum version

Added
  * AZ-933: adding pre_condition on private_dns_zone_id and delegated_subnet_id vars

Changed
  * AZ-934: Adding `databases` map variable as unique var to set dbs

# v6.1.0 - 2022-12-14

Added
  * AZ-936: Only create firewall rules for public servers

# v6.0.0 - 2022-11-25

Breaking
  * AZ-839: Require Terraform 1.1+ and AzureRM provider `v3.22+`

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v5.2.0 - 2022-07-01

Added
  * AZ-770: Add Terraform module info in output

# v5.1.0 - 2022-06-24

Added
  * AZ-787: Edit user `search_path`

# v5.0.1 - 2022-04-20

Fixed
  * AZ-725: Remove `TEMPORARY` privilege to user table privileges.

# v5.0.0 - 2022-04-15

Added
  * AZ-602: First release of Postgresql Flexible server module
