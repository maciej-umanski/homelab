# Installation

Procedure needed for correct installation of the devices in the homelab.

## Prerequisites

Install on your workstation: `ansible terraform`

## Workflow

Depending on the device, perform one of the following installation methods, if device contains more than one method,
perform them in the order listed below.

### 1. Manual Installation (`installation.md`)

Manually perform described installation steps on each device.

### 2. Bootstrap (`bootstrap.*`)

Run from each device's terminal.

### 4. Ansible (`ansible`)

The first run requires SSH password — subsequent runs use the deployed SSH key.

```shell
ansible-playbook setup.yml \
  --ask-pass \
  --ask-become-pass # if not root or passwordless sudo
```

### 5. Terraform (`terraform`)

Create `terraform.tfvars` in each device's directory based on the `variables.tf` file. Then apply infrastructure
configuration using:

```shell
terraform init
terraform plan
terraform apply
```
