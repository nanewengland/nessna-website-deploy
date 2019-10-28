provider "digitalocean" {
  # You need to set this in your environment variable
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
}

terraform {
  backend "s3" {
    endpoint = "nyc3.digitaloceanspaces.com"
    region = "us-east-1"
    key = "terraform.tfstate"
    skip_requesting_account_id = true
    skip_credentials_validation = true
    skip_get_ec2_platforms = true
    skip_metadata_api_check = true
  }
}

resource "digitalocean_droplet" "nesssna" {
  # Obtain your ssh_key id number via your account. By running the following.
  # curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer TOKEN" "https://api.digitalocean.com/v2/account/keys" | jq --raw-output
  ssh_keys           = [25669899, # PJ
                        25670813] # JB
  image              = var.wordpress
  region             = var.do_nyc1
  size               = "s-1vcpu-1gb"
  private_networking = false
  backups            = true
  ipv6               = false
  name               = "nesssna-webserver-nyc1"
}

resource "digitalocean_record" "www" {
  domain = var.domain
  type   = "A"
  name   = "www"
  ttl    = "60"
  value  = digitalocean_droplet.nesssna.ipv4_address
}

resource "digitalocean_record" "nesssna" {
  domain = var.domain
  type   = "A"
  name   = "@"
  ttl    = "60"
  value  = digitalocean_droplet.nesssna.ipv4_address
}

data "digitalocean_domain" "nesssna" {
  name = var.domain
}
