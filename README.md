# Azure Infrastructure Using Terraform Project

A modular Terraform project that provisions a production-ready Azure infrastructure using reusable, independently managed modules. Built with the **AzureRM provider v4.73.0**, this project separates each resource type into its own module, enabling clean separation of concerns, easy reuse, and environment-specific deployments.

---

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Modules](#modules)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Environment Configuration](#environment-configuration)
- [Provider & Version Info](#provider--version-info)
- [Author](#author)

---

## Overview

This project automates the deployment of a comprehensive Azure environment including networking, compute, storage, database, security, and load balancing resources — all through Terraform. The modular design means each resource type can be provisioned, updated, or destroyed independently without impacting others.

---

## Project Structure

```
.
├── env/
│   └── dev/                    # Dev environment root configuration
│       └── .terraform/
│           ├── modules/        # Cached module references
│           └── providers/      # AzureRM provider (v4.73.0, windows_amd64)
│
└── module_class/               # Reusable Terraform modules
    ├── KeyVault/
    ├── KeyVaultSecret/
    ├── LoadBalancer/
    ├── NatGateway/
    ├── NSGRules/
    ├── PuplicIP/
    ├── ResourceGroup/
    ├── SQLDB/
    ├── SQLServer/
    ├── StorageAccount/
    ├── SubNetwork/
    ├── VirtualMachine/
    └── VirtualNetwork/
```

---

## Modules

| Module | Description |
|---|---|
| `ResourceGroup` | Creates and manages Azure Resource Groups |
| `VirtualNetwork` | Provisions VNets with custom address spaces |
| `SubNetwork` | Creates subnets within VNets |
| `NSGRules` | Defines and attaches Network Security Group rules |
| `NatGateway` | Sets up NAT Gateway for outbound internet connectivity |
| `PuplicIP` | Allocates Public IP addresses (static/dynamic) |
| `LoadBalancer` | Configures Azure Load Balancer with backend pools and rules |
| `VirtualMachine` | Deploys Linux/Windows VMs with configurable sizing |
| `StorageAccount` | Creates Azure Storage Accounts with configurable tiers |
| `SQLServer` | Provisions Azure SQL Server instances |
| `SQLDB` | Creates and configures Azure SQL Databases |
| `KeyVault` | Deploys Azure Key Vaults with access policies |
| `KeyVaultSecret` | Manages secrets stored within Key Vault |

---

## Prerequisites

Before deploying, ensure the following are installed and configured:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) `>= 1.x`
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (authenticated via `az login`)
- An active Azure subscription
- Sufficient IAM permissions (Contributor or Owner on the target subscription)

---

## Getting Started

**1. Clone the repository**

```bash
git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>
```

**2. Authenticate with Azure**

```bash
az login
az account set --subscription "<your-subscription-id>"
```

**3. Navigate to the target environment**

```bash
cd env/dev
```

**4. Initialize Terraform**

```bash
terraform init
```

**5. Review the execution plan**

```bash
terraform plan
```

**6. Apply the configuration**

```bash
terraform apply
```

---

## Environment Configuration

Environment-specific variables are defined in the `env/dev/` directory. Update `terraform.tfvars` with values appropriate for your target environment before running `terraform plan` or `terraform apply`.

Each module accepts its own set of input variables. Refer to the `variables.tf` file within each module directory for the full list of configurable parameters.

---

## Provider & Version Info

| Property | Value |
|---|---|
| Provider | `hashicorp/azurerm` |
| Version | `4.73.0` |
| Platform | `windows_amd64` |

---

## Author

**Rishi Kejriwal**
---
