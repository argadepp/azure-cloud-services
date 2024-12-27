terraform {
  source = "https://github.com/argadepp/azure-cloud-services.git//modules/azure-basics?ref=master"
}

inputs = {
    
    resource_group_name="pratik-argade-az-basics"
    location="West Europe"

  default_tags = {
    environment = "dev"
    owner       = "team-a"
  }
  tags = {
    project = "learn-az-services"
    cost    = "1000"
    budget  = "free-tier"
  }
}
