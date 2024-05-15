# Authenticate to Azure (make sure you have the appropriate permissions)
Connect-AzAccount

# Set variables for your Azure resource group
$resourceGroupName = "MyAVDResourceGroup"
$location = "eastus"

# Create a new resource group
$resourceGroupParams = @{
    Name = $resourceGroupName
    Location = $location
}
New-AzResourceGroup @resourceGroupParams

# Register the AVD provider
Register-AzResourceProvider -ProviderNamespace Microsoft.DesktopVirtualization -Force

# Define parameters for host pool
$hostPoolParams = @{
    ResourceGroupName = $resourceGroupName
    Name = "MyHostPool"
    Location = $location
    HostPoolType = "Pooled"
    MaxSessionLimit = 10
    RegistrationInfo = "WVD PowerShell Sample Host Pool"
    PersonalDesktopAssignmentType = "Automatic"
    CustomRdpProperty = @{
        "audiocapturemode" = "0"
        "audiomode" = "1"
    }
}

# Create the host pool
New-AzWvdHostPool @hostPoolParams

# Define parameters for app group
$appGroupParams = @{
    ResourceGroupName = $resourceGroupName
    Name = "MyAppGroup"
    Location = $location
    HostPoolName = "MyHostPool"
    FriendlyName = "Sample App Group"
    Description = "WVD PowerShell Sample App Group"
    ResourceType = "Desktop"
}

# Create an app group
New-AzWvdApplicationGroup @appGroupParams

# Define parameters for workspace
$workspaceParams = @{
    ResourceGroupName = $resourceGroupName
    Name = "MyWorkspace"
    Location = $location
    FriendlyName = "Sample Workspace"
    Description = "WVD PowerShell Sample Workspace"
    Tags = @{
        Environment = "Test"
    }
}

# Create a workspace
New-AzWvdWorkspace @workspaceParams

# Define users to assign to the app group
$users = @(
    "<user1@example.com>",
    "<user2@example.com>"
)

# Assign users to the app group
foreach ($user in $users) {
    $assignUserParams = @{
        ResourceGroupName = $resourceGroupName
        ApplicationGroupName = "MyAppGroup"
        UserPrincipalName = $user
    }
    Add-AzWvdApplicationGroupUser @assignUserParams
}

Write-Host "Azure Virtual Desktop sample project created successfully."
