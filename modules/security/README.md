## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"East US"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | `"myResourceGroup"` | no |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | A list of security rules to apply to the NSG. | <pre>list(object({<br/>    name                       = string<br/>    priority                   = number<br/>    direction                  = string<br/>    access                     = string<br/>    protocol                  = string<br/>    source_port_range         = string<br/>    destination_port_range    = string<br/>    source_address_prefix     = string<br/>    destination_address_prefix = string<br/>  }))</pre> | `[]` | no |
| <a name="input_sub_id"></a> [sub\_id](#input\_sub\_id) | Subscription id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Network Security Group. |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the Network Security Group. |
