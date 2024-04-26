output "terraform_module" {
  description = "Information about this Terraform module"
  value = {
    name       = "db-postgresql-flexible"
    provider   = "azurerm"
    maintainer = "claranet"
  }
}
