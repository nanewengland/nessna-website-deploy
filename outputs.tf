output "droplet" {
  value = {
    public_ip = digitalocean_droplet.nesssna.ipv4_address
    static_ip = digitalocean_floating_ip.nesssna.ip_address
    domain    = data.digitalocean_domain.nesssna.urn
  }
}
