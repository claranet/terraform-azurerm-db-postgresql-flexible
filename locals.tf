locals {
  tier_map = {
    "GeneralPurpose"  = "GP"
    "Burstable"       = "B"
    "MemoryOptimized" = "MO"
  }

  administrator_password = coalesce(var.administrator_password, one(random_password.administrator_password[*].result))
}
