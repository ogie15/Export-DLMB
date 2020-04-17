function Export-DLMB {
    <#
    .SYNOPSIS
        This CMDLET Exports Members in a Distribution List and Mail Enabled Security Group
    .DESCRIPTION
        Exports Members in a Distribution List and Mail Enabled Security Group 
        To a CSV File called (DL&MESGMembers.csv or to a specified CSV File and File Path)
    .EXAMPLE
        Export-DLMB "C:\Users\Public"
        =============================
        Export-DLMB -LocationPath "C:\Users\Public"
        ===========================================
        Export-DLMB -LocationPath "C:\Users\Public" -FileName "myfile"
        ==============================================================
        Export-DLMB -LP "C:\Users\Public" -FN "myfile"
    .INPUTS
        None
    .OUTPUTS
        CSV file named DL&MESGMembers.csv Or the specified file stated in Parameter -FileName
        CSV contains DL&MESGName, NameOfMembers, PrimarySmtpAddress, RecipientTypeDetails 
    .NOTES
        For this to run you will need to connect to Exchange Online via PowerShell
        If no value is entered for parameter FileName a default file "DL&MESGMembers.csv" is created 
    #>
    [CmdletBinding()]
    param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory = $true,
            Position = 0,
            ParameterSetName = "Location",
            ValueFromPipeline = $false,
            ValueFromPipelineByPropertyName = $false,
            HelpMessage = "Please enter a valid Location")]
        [Alias("LP")]
        [ValidateNotNullOrEmpty()]
        [string]
        $LocationPath,

        # Specifies a path to one or more locations.
        [Parameter(Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $false,
            ValueFromPipelineByPropertyName = $false,
            HelpMessage = "Please enter the File Name")]
        [Alias("FN")]
        [ValidateNotNullOrEmpty()]
        [string]
        $FileName = "DL&MESGMembers"
    )
    
    # begin {
        
    # }
    
    process {
        #Get Distribution Groups/Mail Enabled Security Groups
        $DlGroups = Get-DistributionGroup -ResultSize Unlimited | Select-Object PrimarySmtpAddress 
        #Creating an array
        $FinalArray = @()
        #Loop through the List of DL/MESG 
        Foreach ($DlGroup in $DlGroups) {
            $Upn = $DlGroup.PrimarySmtpAddress.ToString()
            #Get Distribution Groups Members/Mail Enabled Security Groups Members
            $Members = Get-DistributionGroupMember -ResultSize Unlimited -Identity $Upn | Select-Object Name, PrimarySmtpAddress, RecipientTypeDetails  
            #Create a HashTable for the values
            $FinalArray += [PSCustomObject][Ordered]@{
                "DL&MESGName"          = $Upn
                "NameOfMembers"        = ($Members.Name | Out-String).Trim()
                "PrimarySmtpAddress"   = ($Members.PrimarySmtpAddress | Out-String).Trim()
                "RecipientTypeDetails" = ($Members.RecipientTypeDetails | Out-String).Trim()
            }
        }
    }
    
    end {
        #_Path parameter for Export-CSV
        [string]$Script:FinalName = ($LocationPath + "\" + $FileName + ".csv")
        #Export all members to CSV called variable $FinalName
        $FinalArray | Export-Csv -Path $FinalName -Delimiter "," -NoTypeInformation
        #Writes Output to Screen
        Write-Output $FinalArray
        Write-Host ("`n`r Kindly Check this Location " + $FinalName) -BackgroundColor Green -ForegroundColor DarkBlue
    }
}
