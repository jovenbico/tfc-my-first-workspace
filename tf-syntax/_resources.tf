terraform {
    required_providers {
      local = {
        source = "hashicorp/local"
        version = ">= 2.2.3"
      }
    }
}

variable "drinks" {
  default = ["beer", "whiskey", "wine"]
}

resource "local_file" "count" {
  count = length(var.drinks)

  filename = "./count-${var.drinks[count.index]}.txt"
  content = "${var.drinks[count.index]}, oh my!"
}

resource "local_file" "for_each" {
  for_each = toset(var.drinks)

  filename = "./for_each-${each.value}.txt"
  content = "${each.key}:${each.value}, oh my!"
}