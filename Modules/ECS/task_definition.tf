

/*resource "aws_ecs_task_definition" "back" {
  family = "BACK"
  container_definitions= "${data.template_file.back_json.rendered}"  
}*/


resource "aws_ecs_task_definition" "front" {
  family = "FRONT"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "essential": true,
    "image": "905326150904.dkr.ecr.us-east-1.amazonaws.com/front:latest",
    "memory": 128,
    "portMappings": [
          {
              "containerPort": 3030,
              "hostPort": 3030,
              "protocol": "tcp"
          }],
    "memoryReservation": 64,
    "name": "front"
  }
]
DEFINITION
}



resource "aws_ecs_task_definition" "back" {
  family = "BACK"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "essential": true,
    "image": "905326150904.dkr.ecr.us-east-1.amazonaws.com/backend:latest",
    "memory": 128,
    "portMappings": [
          {
              "containerPort": 3000,
              "hostPort": 3000,
              "protocol": "tcp"
          }],
    "memoryReservation": 64,
    "name": "back"
  }
]
DEFINITION
}

/*data "template_file" "back_json"{
    template = "${file("${path.module}/back_package.json")}"

 }*/

 /*data "template_file" "front_json"{
    template = "${file("./Modules/ECS/front_package.json")}"

 }*/
