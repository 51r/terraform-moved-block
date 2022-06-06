moved {
    from = random_pet.pet
    to = module.pet.random_pet.pet
}

module "pet" {
  source = "./module"

}


resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo Hello ${module.pet.id}"
  }
}