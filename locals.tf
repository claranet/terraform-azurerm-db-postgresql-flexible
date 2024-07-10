locals {
  tier_map = {
    "GeneralPurpose"  = "GP"
    "Burstable"       = "B"
    "MemoryOptimized" = "MO"
  }

  administrator_password = coalesce(var.administrator_password, random_password.administrator_password[0].result)
}
