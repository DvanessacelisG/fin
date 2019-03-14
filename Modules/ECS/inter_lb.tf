resource "aws_lb_target_group" "int-target-group" {
  name = "vane-int-target-group"
  port = "80"

  protocol = "HTTP"
  vpc_id   = "${var.vpc_name}"

   health_check {
       healthy_threshold = 3
       unhealthy_threshold = 2
       timeout = 3
       path = "/"
       interval = 5
   }
  tags {
    Name = "vane-int-target-group"
  }
}

resource "aws_lb" "int-load-balancer" {
  name     = "vane-int-load-balancer-interno"
  subnets  = ["${element(var.private_subnetsp, 2)}","${element(var.private_subnetsp, 3)}"]
  internal = true
  security_groups =["${var.sg_lb}"]
  load_balancer_type = "application" 

  tags {
    Name = "vane-int-load-balancer-interno"
  }
}

resource "aws_lb_listener" "int-alb-listener" {
  #depends_on        = ["aws_lb.int-load-balancer"]
  load_balancer_arn = "${aws_lb.int-load-balancer.arn}"
  count             = "${length(var.port_lb)}"
  port              = "${element(var.port_lb, count.index)}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.int-target-group.arn}"
    type             = "forward"
  }
}
