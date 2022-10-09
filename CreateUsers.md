# CreateUsers.ps1

Mass create Active Directory users from a CSV file.
This script **must** be ran as an Administrator or it will fail to execute.

### Script usage
Usage: `.\CreateUsers.ps1 <UPN> <CSV FILE>`
Example Usage:  `.\CreateUsers.ps1 trytheitguy.com NewUsers.csv`
CSV Format: `FirstName,LastName,TempPassword,OU`
Example CSV file:
```
FirstName,LastName,TempPassword,OU
Michael,Bergeron,2r9#W95VCOOb,"OU=Accounting,OU=Users,OU=Company,DC=trytheitguy,DC=com"
Allison,Dolby,B&o119MMYZRU,"OU=Accounting,OU=Users,OU=Company,DC=trytheitguy,DC=com"
Alexander,Watkins,48h&TgfP1OmV,"OU=IT,OU=Users,OU=Company,DC=trytheitguy,DC=com"
Ryan,Soresen,25J3fV%GD@Ce,"OU=Engineering,OU=Users,OU=Company,DC=trytheitguy,DC=com"
Scott,Rogers,76AfP7S!7&P3,"OU=Marketing,OU=Users,OU=Company,DC=trytheitguy,DC=com"
```
Any security groups and additional user properties will have to be added manually.
The user must change their password after logon. 
