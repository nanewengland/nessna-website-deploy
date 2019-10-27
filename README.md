# Contains the codez for deployment of NESSSNA.org using terraform and ansible.

currently only the terraform is set up and will simply stand up a droplet in nyc1 region. and attach domain to that droplet.

It will update ubuntu and install nginx.

# setting up terraform

to initalize terraform using remote state do the following. 
```
terraform init \
 -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
 -backend-config="secret_key=$SPACES_SECRET_KEY" \
 -backend-config="bucket=nesssna-terraform"
```