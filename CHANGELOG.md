# Unreleased

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
