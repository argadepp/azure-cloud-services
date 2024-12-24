terraform {
  source = "https://github.com/argadepp/azure-cloud-services.git//modules/azure-basics?ref=master"
}

inputs = {
    resource_group_name="pratik-argade-az-basics"
    location="West Europe"
    tags={
        project="learn-az-services"
        budget="free-tier"
        maintainer="Pratik Argade"
    }
}
