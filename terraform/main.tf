terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>3.27"
    }
  }
  required_version = ">=0.14.9"

}
provider "aws" {
  version = "~>3.0"
  region  = "east-us-1"
}


provider  "newrelic"{
    account_id = 3826875
    api_key = "NRAK-BY52LCHM4JNZWY59IXOZXW7J73A"
    region = "US"
}
terraform {
  required_version = ">= 0.13"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">= 2.22"
      #constraints = "~> 3.23"
    }
  }
}

#newrelic_alert_condition
data "newrelic_entity" "app" {
  name = "FoodME"
  type = "APPLICATION"
  domain = "APM"
}

resource "newrelic_alert_policy" "alert_policy_git" {
  name = "alert_policy_git_demo"
}

resource "newrelic_alert_condition" "alert_policy_git" {
  policy_id = newrelic_alert_policy.alert_policy_git.id

  name        = "alert_condition_git"
  type        = "apm_app_metric"
  entities    = [data.newrelic_entity.app.application_id]
  metric      = "apdex"
  #runbook_url = "https://www.example.com"
  condition_scope = "application"

  term {
    duration      = 5
    operator      = "below"
    priority      = "critical"
    threshold     = "0.75"
    time_function = "all"
  }
}


resource "newrelic_notification_destination" "email" {
  account_id = 3826875
  name = "email-example"
  type = "EMAIL"

  property {
    key = "email"
    value = "aparna@litmus7.com"
  }
}
resource "newrelic_notification_channel" "email" {
  account_id = 3826875
  name = "email-example"
  type = "EMAIL"
  destination_id = newrelic_notification_destination.email.id
  product = "IINT"

  property {
    key = "subject"
    value = "New Subject Title"
  }
}

resource "newrelic_workflow" "foo" {
  name = "workflow-git_demo"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "filter-name"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator = "EXACTLY_MATCHES"
      values = [ newrelic_alert_policy.alert_policy_git.id ]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.email.id
  }
}
