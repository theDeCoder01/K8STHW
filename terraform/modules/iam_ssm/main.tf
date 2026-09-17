terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Structural Plan:
# For the system manager to be able to manage our 4 EC2s,
# we shall create an IAM role that has SSM permessions
# (not SSH, as per the tutorial) (Amazon has an existing SSM
# permission policy that we can use).
# This IAM role shall be contained in a profile,
# and that profile shall be attached to the EC2s.
# The EC2s will then be able to use the SSM agent to communicate
# with AWS Systems Manager.


#The role:
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

#The policy mentioned in the role:
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#Attching the SSM policy to the role:
resource "aws_iam_role_policy_attachment" "SSMManaged" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#creaying a profile:
resource "aws_iam_instance_profile" "this" {
  name = "${var.role_name}-profile"
  role = aws_iam_role.this.name
}