module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-0fa01159713fa201f"]
 
  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-0487393b6e3484f81", "subnet-05d1bf471889bf171"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"
  
  
  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
			name  = "SERVER_AUDIT_EVENTS"
			  value = "CONNECT"
			},
			{
			  name  = "SERVER_AUDIT_FILE_ROTATIONS"
			  value = "37"
			},
      ]
    },
  ]
}

