provider "digitalocean" {
  # You need to set this in your environment variable
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "nesssna" {
  # Obtain your ssh_key id number via your account. By running the following.
  # curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer TOKEN" "https://api.digitalocean.com/v2/account/keys" | jq --raw-output
  ssh_keys = [
    25669899, # PJ
    25670813, # JB
    39430344  # AH
  ]
  image   = "wordpress-20-04"
  region  = "nyc3"
  size    = "s-1vcpu-1gb-intel"
  backups = true
  ipv6    = false
  name    = "nesssna-webserver-nyc3"
}

resource "digitalocean_floating_ip" "nesssna" {
  region = digitalocean_droplet.nesssna.region
}

resource "digitalocean_floating_ip_assignment" "nesssna" {
  ip_address = digitalocean_floating_ip.nesssna.ip_address
  droplet_id = digitalocean_droplet.nesssna.id
}

resource "digitalocean_record" "www" {
  domain = "nesssna.org"
  type   = "A"
  name   = "www"
  ttl    = "60"
  value  = digitalocean_floating_ip.nesssna.ip_address
}

resource "digitalocean_record" "nesssna" {
  domain = "nesssna.org"
  type   = "A"
  name   = "@"
  ttl    = "60"
  value  = digitalocean_floating_ip.nesssna.ip_address
}

data "digitalocean_domain" "nesssna" {
  name = "nesssna.org"
}
