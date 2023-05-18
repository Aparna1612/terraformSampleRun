# Github Workflow Example
# Based on and with thanks:   https://wahlnetwork.com/2020/05/12/continuous-integration-with-github-actions-and-terraform/


terraform {
  required_version = "~> 1.3.1"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      #version = "~> 2.22.1"
    }
  }
}
provider "newrelic" {
  region = "US"                   
}

terraform {
  backend "s3" {
    bucket = "alo-newrelic-tf-state-test"
    key    = "alo-newrelic-tf-state-test/newrelic.tfstate"
    region = "us-east-1"
    profile = "default"
  }
}

# --- Actual new relic terraform here, try changing the policy name!

resource "newrelic_alert_policy" "workflowtest" {
  name = "Example Github Workflow"
  incident_preference = "PER_POLICY" 
}
