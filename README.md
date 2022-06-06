# Terraform Moved Block sample

This repo contains Terraform Configuration that includes [Moved](https://learn.hashicorp.com/tutorials/terraform/move-config#move-your-resources-with-the-moved-configuration-block) block that describes renamed random_pet resource in a module called `tf`.

The use case can be helpful when you decide to rename your resource inside your module and want to sustain compatibility with the versions containing the old name.

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

# What have been made

1. Created main.tf configuration containing 1 module block:
* module "random_pet" called "pet"

2. Executed the Terraform plan and deployed the 2 resources.
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

3. Renamed the resource "pet" to "animal":
```
module "tf" {
  source = "./module"

}
```

5. Added `moved` block inside the main.tf to let Terraform know that the resource has been renamed and it doesn't need to destroy or create a new resource:
```
moved {
    from = module.tf.random_pet.pet
    to = module.tf.random_pet.animal
}
```

6. Re-initalized the Terraform to load the new module:
```
terraform init
```

7. Applied the new plan:
<img width="919" alt="Screen Shot 2022-06-06 at 11 26 15 AM" src="https://user-images.githubusercontent.com/52199951/172124718-62d1f96d-1a9b-419f-b45f-beba60a69d12.png">

**As you can see from the screenshot above, Terraform wanted to modify the state and save the new resource name without the need to add/destroy or change the resources.**
