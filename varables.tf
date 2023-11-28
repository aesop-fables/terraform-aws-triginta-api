variable "region" {
  type = string
  description = "The region where AWS operations will take place. Examples are us-east-1, us-west-2, etc."
}

variable "app_name" {
  type = string
  description = "An AWS friendly name of your triginta application (e.g., my-microservice)"
}

variable "runtime" {
  type = string
  description = "The target NodeJS runtime"
}

variable "local" {
  type = bool
  default = false
  description = "Whether the environment is local (i.e., LocalStack) vs. AWS"
}

variable "routes" {
  type = list(object({
    method = string
    path = string
    function = object({
      name = string
      filename = string
      handler = string
    })
  }))
  default = []
}
