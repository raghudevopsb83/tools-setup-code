terraform {
  backend "s3" {
    bucket = "terraform-b83"
    key    = "vault-secrets/state"
    region = "us-east-1"
  }
}


provider "vault" {
  address = "http://vault-internal.rdevopsb83.online:8200"
  token   = var.vault_token
}

variable "vault_token" {}

resource "vault_mount" "ssh" {
  path        = "infra"
  type        = "kv"
  options     = { version = "2" }
  description = "Infra secrets"
}

resource "vault_generic_secret" "ssh" {
  path = "${vault_mount.ssh.path}/ssh"

  data_json = <<EOT
{
  "username":   "ec2-user",
  "password": "DevOps321"
}
EOT
}

resource "vault_generic_secret" "elasticsearch" {
  path = "${vault_mount.ssh.path}/elasticsearch"

  data_json = <<EOT
{
  "username":   "elastic",
  "password": "+6E_xYrCwdv5eOTFVFFJ"
}
EOT
}

resource "vault_generic_secret" "github-runner" {
  path = "${vault_mount.ssh.path}/github-runner"

  data_json = <<EOT
{
  "RUNNER_TOKEN":   "xx"
}
EOT
}

resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "2" }
  description = "Roboshop Dev secrets"
}

resource "vault_generic_secret" "roboshop-dev-cart" {
  path = "${vault_mount.roboshop-dev.path}/cart"

  data_json = <<EOT
{
"REDIS_HOST":   "redis-dev.rdevopsb83.online",
"CATALOGUE_HOST": "catalogue",
"CATALOGUE_PORT": "8080"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-catalogue" {
  path = "${vault_mount.roboshop-dev.path}/catalogue"

  data_json = <<EOT
{
"MONGO":   "true",
"MONGO_URL": "mongodb://mongodb-dev.rdevopsb83.online:27017/catalogue",
"DB_TYPE": "mongo",
"APP_GIT_URL" : "https://github.com/roboshop-devops-project-v3/catalogue",
"DB_HOST" : "mongodb-dev.rdevopsb83.online",
"SCHEMA_FILE" : "db/master-data.js"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-frontend" {
  path = "${vault_mount.roboshop-dev.path}/frontend"

  data_json = <<EOT
{
"catalogue":   "http://catalogue-dev.rdevopsb83.online:8080/",
"user":   "http://user-dev.rdevopsb83.online:8080/",
"cart":   "http://cart-dev.rdevopsb83.online:8080/",
"shipping":   "http://shipping-dev.rdevopsb83.online:8080/",
"payment":   "http://payment-dev.rdevopsb83.online:8080/",
"CATALOGUE_HOST" : "catalogue-dev.rdevopsb83.online",
"CATALOGUE_PORT" : "8080",
"USER_HOST" : "user-dev.rdevopsb83.online",
"USER_PORT" : "8080",
"CART_HOST" : "cart-dev.rdevopsb83.online",
"CART_PORT" : "8080",
"SHIPPING_HOST" : "shipping-dev.rdevopsb83.online",
"SHIPPING_PORT" : "8080",
"PAYMENT_HOST" : "payment-dev.rdevopsb83.online",
"PAYMENT_PORT" : "8080"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-payment" {
  path = "${vault_mount.roboshop-dev.path}/payment"

  data_json = <<EOT
{
"CART_HOST" : "cart",
"CART_PORT" : 8080,
"USER_HOST" : "user",
"USER_PORT" : 8080,
"AMQP_HOST" : "rabbitmq-dev.rdevopsb83.online",
"AMQP_USER" : "roboshop",
"AMQP_PASS" : "roboshop123"
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-shipping" {
  path = "${vault_mount.roboshop-dev.path}/shipping"

  data_json = <<EOT
{
"CART_ENDPOINT" : "cart:8080",
"DB_HOST" : "mysql-dev.rdevopsb83.online",
"DB_TYPE" : "mysql",
"APP_GIT_URL" : "https://github.com/roboshop-devops-project-v3/shipping",
"DB_USER" : "root",
"DB_PASS" : "RoboShop@1",
"NEW_RELIC_LICENSE_KEY" : ""
}
EOT
}

resource "vault_generic_secret" "roboshop-dev-user" {
  path = "${vault_mount.roboshop-dev.path}/user"

  data_json = <<EOT
{
"MONGO" : "true",
"REDIS_URL" : "redis://redis-dev.rdevopsb83.online:6379",
"MONGO_URL" : "mongodb://mongodb-dev.rdevopsb83.online:27017/users"
}
EOT
}



## Username and Password should not be hardcoded, Here we just hardcoding because of lab and code is the mean of information sharing to the students.
