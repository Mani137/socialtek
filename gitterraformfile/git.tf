#Git hub provider to create repo in git hub using terraform
terraform {
  required_providers {
    github = {
      source = "integrations/github"
     
    }
  }
}
#configure the GITHUB provider
provider "github" {
  token = "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"
}
resource "github_repository" "git_repo" {
  name        = "socialtek"
  description = "My awesome codebase for git_repo"

  visibility = "public"
}

