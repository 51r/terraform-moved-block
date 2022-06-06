# Terraform Moved Block sample

This repo contains Terraform Configuration that contains [Moved](https://learn.hashicorp.com/tutorials/terraform/move-config#move-your-resources-with-the-moved-configuration-block) block that describes moved random_pet resource in a child module.

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

1. Created main.tf configuration containing 2 resources:
* resource "random_pet" "pet"
* resource "null_resource" "hello" {

2. Executed the Terraform plan and deployed the 2 resources.
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

3. Moved the resource random_pet.pet to sub module "module":
```
module "pet" {
  source = "./module"

}
```

4. Modified the `null_resource` to match the new var from random_pet resource, which has to be printed:
```
    command = "echo Hello ${module.pet.id}"
```

5. Added `moved` block inside the main.tf to let Terraform know that the resource has been moved and it doesn't need to destroy or create a new resource:
```
moved {
    from = random_pet.pet
    to = module.pet.random_pet.pet
}
```

6. Re-initalized the Terraform to load the new module:
```
terraform init
```

7. Applied the new plan:
<img width="909" alt="Screen Shot 2022-06-06 at 10 52 56 AM" src="https://user-images.githubusercontent.com/52199951/172119237-261d0c64-287a-4a2d-80ce-48f1c730e368.png">


**As you can see from the screenshoht above, Terraform wanted to modify the state and save the moved resource and it doesn't need to add/destroy or change the resources.**
