# IaC-lab: Research & Experimentation

Personal workbench for testing local Infrastructure-as-Code (IaC) patterns. 
Hardware: macOS (ARM64) | Driver: Lima VZ | Network: socket_vmnet

## Tools:

- Terraform handles infrastructure provisioning
- Ansible handles machine state management
- Lima handles individual VM instance life-cycle management

## Purpose:

This is a pattern of implementation for a virtual lab that uses realistic network configuration in place of port forwarding to simulate production-like infrastructure on a domain (.vlab)

Infrastructure is provisioned and destroyed using Terraform whereas infrastructure state is managed by Ansible.

