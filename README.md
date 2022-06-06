# Terraform Moved Block sample

This repo contains Terraform Configuration that includes [Moved](https://learn.hashicorp.com/tutorials/terraform/move-config#move-your-resources-with-the-moved-configuration-block) block that describes renamed random_pet module.

The use case can be helpful when you decide to rename your module and sustain compatibility with old versions of the plan.

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

1. Created main.tf configuration containing 2 blocks:
* module "random_pet" "random"
* resource "random_pet" "pet1" {

2. Executed the Terraform plan and deployed the 2 resources.
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

3. Renamed the module random_pet to "tf":
```
module "tf" {
  source = "./module"

}
```

5. Added `moved` block inside the main.tf to let Terraform know that the resource has been renamed and it doesn't need to destroy or create a new resource:
```
moved {
    from = module.random.random_pet.pet
    to = module.tf.random_pet.pet
}
```

6. Re-initalized the Terraform to load the new module:
```
terraform init
```

7. Applied the new plan:
<img width="912" alt="Screen Shot 2022-06-06 at 11 15 47 AM" src="https://user-images.githubusercontent.com/52199951/172123084-c17fff40-00b2-409d-b7ce-83ecf530c41d.png">

**As you can see from the screenshot above, Terraform wanted to modify the state and save the new module name without the need to add/destroy or change the resources.**
