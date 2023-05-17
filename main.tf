terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.22"
    }
  }
}


provider "newrelic" {}

resource "newrelic_alert_policy" "my_alert_policy_name"{
 name = "My Alert Policy Name"
}
