param (
    [string]$ResourceGroupName,
    [string]$Location,
    [string]$HostPoolName,
    [int]$MaxSessionLimit,
    [string]$LoadBalancerType,
    [string]$AppGroupName,
    [string]$WorkspaceName,
    [string[]]$Users
)

# Validate parameters
if (-not $ResourceGroupName -or -not $Location -or -not $HostPoolName -or -not $MaxSessionLimit -or -not $LoadBalancerType -or -not $AppGroupName -or -not $WorkspaceName -or -not $Users) {
    Write-Host "Missing required parameters. Please provide all required parameters."
    exit 1
}

# Deploy ARM template
Write-Host "Deploying ARM template..."
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json" `
    -ResourceGroupName $ResourceGroupName -Location $Location -HostPoolName $HostPoolName -MaxSessionLimit $MaxSessionLimit -LoadBalancerType $LoadBalancerType `
    -AppGroupName $AppGroupName -WorkspaceName $WorkspaceName -Users $Users

# Check deployment status
$status = Get-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName | Select-Object -ExpandProperty Properties.ProvisioningState

if ($status -eq "Succeeded") {
    Write-Host "ARM template deployment completed successfully."
} else {
    Write-Host "ARM template deployment failed. Provisioning state: $status"
    exit 1
}
