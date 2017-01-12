param(
[string]$filename
)

(Get-Content $filename) `
-replace '&lt;br/&gt;', ` #make the separator more readable 
         ' | ' `
-replace '"Date","Description","Original Description","Amount","Transaction Type","Category","Account Name","Labels","Notes"',` #fix the header
         '"Date","Payee","Category","Memo","Outflow","Inflow"' `
-replace '\"(\d*.\d\d)\"\,\"(debit)\"', `  #move debit to inflow
         '"$1",""' `
-replace '\"(\d*.\d\d)\"\,\"(credit)\"', ` #move credit to outflow
         '"","$1"' `
-replace '(AMAZON MARKETPLACE SEATTLE WA \| )|(AMAZON RETAIL SEATTLE WA \| )|(AMAZON DIGITAL SEATTLE WA \| )', ` #there are not necessary for me
         '' `
-replace '\"(?<date>[^\"]*)\",\"(?<store>[^\"]*)\",\"(?<description>[^\"]*)\",\"(?<outflow>[^\"]*)\",\"(?<inflow>[^\"]*)\",\"(?<category>[^\"]*)\",\"(?<reference>[^\"]*)\",\"(?<labels>[^\"]*)\",\"(?<notes>[^\"]*)\"',
         '"${date}","${description}","${category}","${reference}","${outflow}","${inflow}"' `
-replace '&amp;', `       #fix the '&' char
         '&' `
-replace '&#34;', `       #fix the '"' char
         '"' | 
Set-Content $filename

