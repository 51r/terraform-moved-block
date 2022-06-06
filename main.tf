moved {
    from = module.random.random_pet.pet
    to = module.tf.random_pet.pet
}


module "tf" {
  source = "./module"

}


resource "random_pet" "pet1" {
    length = 2
}