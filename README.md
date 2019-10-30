# Contains the codez for deployment of NESSSNA.org using terraform and ansible.

currently only the terraform is set up and will simply stand up a droplet in nyc1 region. and attach domain to that droplet.

It will update ubuntu and install nginx.


# setting up terraform

you will need to run 

`cp terraform.tfvars.example terraform.tfvars` 

and then put your api token in and add your fingerprint. you can get your fingerprint by running the following making sure to put your api key in curl command.

`curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer TOKEN" "https://api.digitalocean.com/v2/account/keys" | jq --raw-output` 

state file is in source control, I have removed remote state from DO to save money.

~to initalize terraform using remote state do the following.~
```
terraform init \
 -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
 -backend-config="secret_key=$SPACES_SECRET_KEY" \
 -backend-config="bucket=nesssna-terraform"
```
