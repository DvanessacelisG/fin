/* resource "aws_ecs_service" "back-service" {
  name            = "vane-back-ecs-service"
  iam_role        = "${aws_iam_role.ecs-service-role.name}"
  cluster         = "${aws_ecs_cluster.Vane_cluster.id}"
  task_definition = "${aws_ecs_task_definition.back.arn}"
  desired_count   = 1
}*/


/*resource "aws_ecs_service" "front-service" {
  name            = "vane-front-ecs-service"
  iam_role        = "${aws_iam_role.ecs-service-role.name}"
  cluster         = "${aws_ecs_cluster.Vane_cluster.id}"
  task_definition = "${aws_ecs_task_definition.front.arn}"
  desired_count   = 1

  load_balancer {
      target_group_arn = "${aws_lb_target_group.extern-target-group.arn}"
      container_name = "front"
      container_port =3030


  }
  }*/


  resource "aws_ecs_service" "mongo" {
  name          = "mongo"
  cluster       = "${aws_ecs_cluster.Vane_cluster.id}"
  desired_count = 2

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.mongo.family}"
   load_balancer {
      target_group_arn = "${aws_lb_target_group.extern-target-group.arn}"
      container_name = "front"
      container_port =3030
  }
}
  resource "aws_ecs_service" "back" {
  name          = "back"
  cluster       = "${aws_ecs_cluster.Vane_cluster.id}"
  desired_count = 2

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.back.family}"
   load_balancer {
      target_group_arn = "${aws_lb_target_group.int-target-group.arn}"
      container_name = "front"
      container_port =3000
  }
}