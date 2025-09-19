## 8.5.0 (2025-09-19)

### Features

* **GH-13:** ✨ add `storage_tier` parameter 596c2f3
* **GH-9:** ✨ add an option to allow Azure Services access on the PostgreSQL flexible server e3b8d2c

### Styles

* 🎨 rename variable ccc46a2
* **GH-13:** 🎨 apply MrAI suggestions 92900ba

### Miscellaneous Chores

* **deps:** 🔗 bump AzureRM provider version to v4.31+ f7419c8
* **deps:** update dependency claranet/diagnostic-settings/azurerm to ~> 8.1.0 d622aeb
* **deps:** update dependency opentofu to v1.10.6 4b7482c
* **deps:** update dependency tflint to v0.59.1 ed64651
* **deps:** update dependency trivy to v0.66.0 80e62b1
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6 33bf256
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 8.2.0 1132c81
* **deps:** update tools 376778f
* merge branch 'feat/GH-9' into 'feat/GH-13' 662637b

## 8.4.0 (2025-08-08)

### Features

* **AZ-1602:** ✨ add recommended configurations for PostgreSQL Flexible server e606673

### Bug Fixes

* **AZ-1602:** 🐛 correct typo in query capture mode configuration f9f018f

### Miscellaneous Chores

* **deps:** update tools fbd533a

## 8.3.0 (2025-07-25)

### Features

* **AZ-1591:** ✨ add backup policy support for PostgreSQL Flexible server df3c416
* **AZ-1591:** ✨ add backup role assignment toggle for backup vault cda6cf8
* **AZ-1591:** ✨ add reader role on resource group to backup vault identity 4e145c3
* **AZ-1591:** ✨ add role assignments and backup vault data source for PostgreSQL Flexible server bcb382f

### Miscellaneous Chores

* **AZ-1591:** apply suggestion 06de3a5

## 8.2.0 (2025-07-18)

### Features

* ✨ change `delegated_subnet_id` and `private_dns_zone_id` to objects 29b69e0

### Code Refactoring

* **variables:** ✨♻️ change `delegated_subnet_id` and `private_dns_zone_id` to objects db556c7

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review c685f74
* 🗑️ remove old commitlint configuration files d29201c
* apply suggestions faf728f
* **deps:** update dependency opentofu to v1.10.0 d9cf50c
* **deps:** update dependency opentofu to v1.10.1 e9414d0
* **deps:** update dependency opentofu to v1.10.3 b594844
* **deps:** update dependency opentofu to v1.9.1 a4ae6e7
* **deps:** update dependency pre-commit to v4.2.0 1d685af
* **deps:** update dependency terraform-docs to v0.20.0 23ee649
* **deps:** update dependency tflint to v0.55.1 de4716a
* **deps:** update dependency tflint to v0.57.0 e106b32
* **deps:** update dependency tflint to v0.58.0 2e20c49
* **deps:** update dependency tflint to v0.58.1 fb335f6
* **deps:** update dependency trivy to v0.59.0 0d11aa5
* **deps:** update dependency trivy to v0.59.1 bc90b87
* **deps:** update dependency trivy to v0.60.0 c1d51bf
* **deps:** update dependency trivy to v0.61.1 a2b884e
* **deps:** update dependency trivy to v0.62.0 6816d28
* **deps:** update dependency trivy to v0.62.1 7f06d99
* **deps:** update dependency trivy to v0.63.0 d20123f
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 968dc6a
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 a9d9521
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 3d09adb
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 39767b3
* **deps:** update tools bd410e5
* **deps:** update tools 162cb20
* **release:** 8.1.1 [skip ci] 6fecab6
* update Github templates cdad613

### Code Refactoring

* **variables:** ✨♻️ change `delegated_subnet_id` and `private_dns_zone_id` to objects db556c7

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review c685f74
* 🗑️ remove old commitlint configuration files d29201c
* apply suggestions faf728f
* **deps:** update dependency opentofu to v1.10.0 d9cf50c
* **deps:** update dependency opentofu to v1.10.1 e9414d0
* **deps:** update dependency opentofu to v1.10.3 b594844
* **deps:** update dependency opentofu to v1.9.1 a4ae6e7
* **deps:** update dependency pre-commit to v4.2.0 1d685af
* **deps:** update dependency terraform-docs to v0.20.0 23ee649
* **deps:** update dependency tflint to v0.55.1 de4716a
* **deps:** update dependency tflint to v0.57.0 e106b32
* **deps:** update dependency tflint to v0.58.0 2e20c49
* **deps:** update dependency tflint to v0.58.1 fb335f6
* **deps:** update dependency trivy to v0.59.0 0d11aa5
* **deps:** update dependency trivy to v0.59.1 bc90b87
* **deps:** update dependency trivy to v0.60.0 c1d51bf
* **deps:** update dependency trivy to v0.61.1 a2b884e
* **deps:** update dependency trivy to v0.62.0 6816d28
* **deps:** update dependency trivy to v0.62.1 7f06d99
* **deps:** update dependency trivy to v0.63.0 d20123f
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 968dc6a
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 a9d9521
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 3d09adb
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 39767b3
* **deps:** update tools bd410e5
* **deps:** update tools 162cb20
* update Github templates cdad613

## 8.1.0 (2025-01-24)

### Features

* **AZ-1491:** add SameZone HA mode 5386106
* **AZ-1491:** add SameZone HA mode using same model as mysql-flexible module 9c73949
* **AZ-1491:** ignore_changes on zone and standby_availabitility_zone in case of failover 4b69684
* hack for collation case issue e3e3415

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.6 2e20840
* **deps:** update dependency opentofu to v1.8.8 84a34fc
* **deps:** update dependency opentofu to v1.9.0 f87338f
* **deps:** update dependency pre-commit to v4.1.0 69bdec9
* **deps:** update dependency tflint to v0.55.0 29460c0
* **deps:** update dependency trivy to v0.58.1 e8f7528
* **deps:** update dependency trivy to v0.58.2 a41cecc
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 5884b89
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 5f5a22a
* **deps:** update tools 4cc8388
* update tflint config for v0.55.0 f3b46cd

## 8.0.0 (2024-11-21)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** global update 5d39717
* **AZ-1088:** module v8 structure and updates 098428e
* **AZ-1088:** remove unused CAF naming for databases 6b65f2f

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 9a3b1ed
* **deps:** update dependency opentofu to v1.8.3 d5f0d3f
* **deps:** update dependency opentofu to v1.8.4 621a4de
* **deps:** update dependency pre-commit to v4 f346429
* **deps:** update dependency pre-commit to v4.0.1 b2c8e7d
* **deps:** update dependency tflint to v0.54.0 085f336
* **deps:** update dependency trivy to v0.56.1 ec8c62e
* **deps:** update dependency trivy to v0.56.2 1b7b754
* **deps:** update dependency trivy to v0.57.1 11e7093
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 8ecf383
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 85cba4d
* **deps:** update tools f324417
* prepare for new examples structure 25378c8
* update examples structure 4a87a39

## 7.6.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 919ca45

### Documentation

* update README badge to use OpenTofu registry 4c2402d
* update README with `terraform-docs` v0.19.0 87f379c

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.0 21b460b
* **deps:** update dependency opentofu to v1.8.1 417c0d7
* **deps:** update dependency pre-commit to v3.8.0 be87d2f
* **deps:** update dependency tflint to v0.53.0 e1079c2
* **deps:** update dependency trivy to v0.54.1 716d59b
* **deps:** update dependency trivy to v0.55.0 7efbe37
* **deps:** update dependency trivy to v0.55.1 2fc3b97
* **deps:** update dependency trivy to v0.55.2 8a2d1ab
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 6edd14f
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 72a8cc8
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 706c4db
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 b6b659c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 36f66e5
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 3fd2acb
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 821021c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 ede8a99
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 53261c4
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 b24ca89
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 3f2a7a6
* **deps:** update tools e0bfb8e
* **deps:** update tools 018552b

## 7.5.2 (2024-07-15)


### Bug Fixes

* **GH-8:** fix variable evaluation when `administrator_password` is specified fc0c455

## 7.5.1 (2024-07-11)


### Bug Fixes

* **AZ-1432:** fix administrator_paswword output 247efbd

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
