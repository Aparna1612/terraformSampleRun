# Github Workflow Example
# Based on and with thanks:   https://wahlnetwork.com/2020/05/12/continuous-integration-with-github-actions-and-terraform/


terraform {
  required_version = ">= 1.3.1"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.23"
    }
  }
}
provider "newrelic" {
  account_id = 3826875
  api_key = "NRAK-BY52LCHM4JNZWY59IXOZXW7J73A"
  region = "US"
}


# --- Actual new relic terraform here, try changing the policy name!
resource "newrelic_alert_policy" "workflowtest" {
  name = "Example Github Workflow terraform"
  incident_preference = "PER_POLICY"
}

}
