resource "random_pet" "pet" {
    length = 10
  
}

output "id" {
    value = random_pet.pet.id
  
}