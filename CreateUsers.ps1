#Requires -RunAsAdministrator

Import-Module ActiveDirectory

# Get arguments
$upn = $args[0]
$filename = $args[1]

$users = Import-Csv $filename ","

foreach ($User in $users) {
    $firstname = $User.FirstName
    $lastname = $User.LastName
    $username = $User.FirstName + "." + $User.LastName
    $password = $User.TempPassword
    $ou = $User.OU

    Write-Host "Processing User: $username" -ForegroundColor DarkCyan

    # Check if user already exists
    if (Get-ADUser -Filter { SamAccountName -eq $username }) {
        # User already exists, Display warning
        Write-Warning "Not adding: $username! That user already exists in this active directory instance!"
    } else {
        # User does not exist already
        # Check if OU exists for the user being added
        if (Get-ADOrganizationalUnit -Filter "distinguishedName -eq '$ou'") {
            # OU Exists
            # Add user
            New-ADUser `
                -SamAccountName $username `
                -UserPrincipalName "$username@$upn" `
                -Name "$firstname $lastname" `
                -GivenName $firstname `
                -Surname $lastname `
                -DisplayName "$firstname $lastname" `
                -Enabled $True `
                -Path $ou `
                -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
                -ChangePasswordAtLogon $True

            # Check if user was sucessfully created
            if (Get-ADUser -Filter { SamAccountName -eq $username }) {
                # Was sucessfully created
                Write-Host "User: $username has been created." -ForegroundColor Green
            } else {
                # Was not created successfully, throw error
                Write-Warning "An error occured while adding the user $username"
            }
        } else {
            # Ou does not exist, throw error
            Write-Warning "Not adding: $username! The OU '$ou' does not exist in this active directory instance!"
        }
    }
}