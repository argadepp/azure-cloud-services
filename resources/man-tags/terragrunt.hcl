terraform {
  source = "https://github.com/argadepp/azure-cloud-services.git//modules/man-tags?ref=master"
}


inputs = {
    project="learn-azure"
    budget="free-tier"
    maintainer="argadepp@gmail.com"
}
