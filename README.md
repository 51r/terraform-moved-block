# Terraform Moved Block sample

This repo contains code that it's calling different versions of Terraform Module.

It is used to describe the moved Terraform block functionality.

# Prerequisite
You need to have [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed on you workstation. 

# How to use the repo
* Clone this repo locally to a folder of your choice
```
git clone https://github.com/51r/terraform-moved-block.git
```

* Make sure you are in the main directory of the repo:
```
cd terraform-moved-block
```

* initialize Terraform  
```
terraform init
```

* Check the plan in order to see the changes which terraform is going to made.
```
terraform plan
```

* Apply the plan which terraform is going to execute based on our configuration (main.tf)
```
terraform apply
```

# How to update to the latest module version which has different resource name

1. Modify the code to use version v.0.2.0, the plan would like to destroy your current existing resources, as the resource inside the module has different name:

* main.tf code:
```
module "tf" {
  source = "git::https://github.com/51r/tf-sample-module.git?ref=v0.2.0"

}
```
* Initialize the Terraform again to download v0.2.0:
```
terraform init
```

* Apply the plan again:
```
terraform apply
module.tf.random_pet.pet: Refreshing state... [id=legally-joint-dogfish]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # module.tf.random_pet.animal will be created
  + resource "random_pet" "animal" {
      + id        = (known after apply)
      + length    = 3
      + separator = "-"
    }

  # module.tf.random_pet.pet will be destroyed
  # (because random_pet.pet is not in configuration)
  - resource "random_pet" "pet" {
      - id        = "legally-joint-dogfish" -> null
      - length    = 3 -> null
      - separator = "-" -> null
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```

**As you can see from the printed plan above, Terraform wants to destroy and re-create the resource, as it's name was changed.**

2. I have created patch in v0.2.1 which includes [moved](https://www.terraform.io/language/modules/develop/refactoring#moved-block-syntax) block. Change your Terraform module to use v0.2.1:
```
module "tf" {
  source = "git::https://github.com/51r/tf-sample-module.git?ref=v0.2.1"

}
```

* Initialize the Terraform again to download the v.0.2.1 from the GitHub Repo:
```
terraform init
```

* Execute the plan:
```
± terraform apply
module.tf.random_pet.animal: Refreshing state... [id=legally-joint-dogfish]

Terraform will perform the following actions:

  # module.tf.random_pet.pet has moved to module.tf.random_pet.animal
    resource "random_pet" "animal" {
        id        = "legally-joint-dogfish"
        # (2 unchanged attributes hidden)
    }

Plan: 0 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

**This is a simple how to use the moved block inside Terraform configuration. You can check the source code at my other repo [releases](https://github.com/51r/tf-sample-module/releases)**

Agenda of the module:

* v0.1.0 - Initial commit with resource name "pet"
* v0.2.0 - Second version with resource name "animal"
* v0.2.1 - Patch of second version with resource name "animal" and "moved" block
