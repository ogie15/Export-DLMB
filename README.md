# Export-DLMB

### This CMDLET Exports Members in a Distribution List and Mail Enabled Security Group

---

_**Kindly Note**_

This works for ***Exchange Online***

---

Download the ***Export-DLMB.psm1*** Module

Open PowerShell _(Run As Administrator)_ then run this CMDLET _**$env:PSModulePath**_ to check for directories  

Save it in a Folder named **_Export-DLMB_** in either of the directories listed by the output of above CMDLET

**Example of list of directories are below**

* C:\Users\Admin\Documents\PowerShell\Modules

* C:\Program Files\PowerShell\Modules

* c:\program files\powershell\7-preview\Modules

* C:\Program Files\WindowsPowerShell\Modules

* C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

* c:\Users\Admin\.vscode\extensions\ms-vscode.powershell-2020.3.0\modules

---

**How to run CMDLET**

Open PowerShell _(Run As Administrator)_

First Connect to Exchange Online using PowerShell

For More assitance with connecting to Exchange Online vist [LINK](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps)

Run _**Import-Module -Name Export-DLMB**_ to import the module 

Then Run this CMDLET to check if the Module has been Imported _**Get-Module -Name Export-DLMB**_

After importing the module run the CMDLET below to get help on how to use the **_Export-DLMB_** CMDLET

_**Get-Help -Name "Export-DLMB" -Full**_

---
**EXAMPLE IS BELOW**

    EXAMPLE
        Export-DLMB "C:\Users\Public"
        =============================
        Export-DLMB -LocationPath "C:\Users\Public"
        ===========================================
        Export-DLMB -LocationPath "C:\Users\Public" -FileName "myfile"
        ==============================================================
        Export-DLMB -LP "C:\Users\Public" -FN "myfile"
    NOTES
        For this to run you will need to connect to Exchange Online via PowerShell
        If no value is entered for parameter FileName a default file "DL&MESGMembers.csv" is created

☺️ for further inquiries reach out to [Ogie](https://www.linkedin.com/in/ibhadogiemu-okougbo-311a5ab3)
