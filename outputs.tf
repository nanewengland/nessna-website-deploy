output "public_ip" {
  value = digitalocean_droplet.nesssna.ipv4_address
}

output "name" {
  value = digitalocean_droplet.nesssna.name
}

output "domain_output" {
  value = data.digitalocean_domain.nesssna.urn
}
