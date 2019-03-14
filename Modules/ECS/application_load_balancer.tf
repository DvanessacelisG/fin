resource "aws_lb" "extern-load-balancer" {
  name    = "vane-extern-load-balancer"
  load_balancer_type = "application"
  security_groups =["${var.sg_lb}"]
  subnets = ["${element(var.public_subnetsp, 1)}", "${element(var.public_subnetsp, 2)}"]
  internal= false
  tags {
    Name = "vane-extern-load-balancer"
  }
}

resource "aws_lb_target_group" "extern-target-group" {
  name     = "vane-extern-target-group"
  port     = "80"
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
    Name = "vane-extern-target-group"
  }
}

resource "aws_lb_listener" "extern-alb-listener" {
  depends_on        = ["aws_lb.extern-load-balancer"]
  load_balancer_arn = "${aws_lb.extern-load-balancer.arn}"
  count             = "${length(var.port_lb)}"
  port              = "${element(var.port_lb, count.index)}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.extern-target-group.arn}"
    type             = "forward"
  }
}
