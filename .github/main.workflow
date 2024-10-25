workflow "build_test_deploy" {
  on = "push"
  resolves = ["deploy"]
}

action "build_test" {
  uses = "docker://circleci/python:3.13.0"
  runs = "./.github/build_test.sh"
}


action "deploy" {
  uses = "docker://circleci/python:3.13.0"
  runs = "./.github/deploy.sh"
  needs = "build_test"
  secrets = ["DOCKERHUB_USERNAME", "DOCKER_HUB_TOKEN"]
}
