moved {
    from = module.tf.random_pet.pet
    to = module.tf.random_pet.animal
}

module "tf" {
  source = "./module"

}