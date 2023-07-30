module "example" {
  source = "./../.."
  namespace = "eg"
  name = "simple-webapp"
  stage = "dev"
  rds_engine = "postgres"
}
