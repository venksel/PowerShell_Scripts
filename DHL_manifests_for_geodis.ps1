$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To = @('kimberly.evanoff@pb.com','HubappProductionSupport@pb.com','jason.efken@pb.com','PSG-GSP@pb.com')
$To1 = @('venkatesh.selvaraju@pb.com')



 
$Path = "D:\outbound_ftp\USZ_HUB\Geodis\Manifest"
$Text = "DHL_USZ"
$PathArray = @()

Get-ChildItem $Path -Filter "MANIFEST_*.txt" |
Where-Object { $_.Attributes -ne "Directory"} |
ForEach-Object {
If (Get-Content $_.FullName | Select-String -Pattern $Text) {
$PathArray += $_.FullName
}
}
#Write-Host "Contents of ArrayPath:"
$PathArray | ForEach-Object {$_}

$attachment+=$PathArray

$count=$patharray.count
echo $count
 

#Send-MailMessage @MailParm -To $To  -Body "Hi All, `r`n`r`n AGL Tracking update file(s) found with missing merchant order#: `r`n`r`n $PathArray `r`n`r`n Please notify Tracking DEV `r`n`r`n Regards, `r`n`r`n PSG Team " -Subject "Alert::AGL CIPs found in OMS in ERROR Status" | ConvertTo-Html | out-string


if ($count -gt 0)
{
Send-MailMessage @MailParm -To $To  -Body "Hi All, `r`n`r`n Following USZ Manifest(s) for Geodis Outbound found with DHL_USZ string in it: `r`n`r`n $PathArray `r`n`r`n Manifest(s) are temporarily moved to D:\outbound_ftp\USZ_HUB\Geodis\Manifest\temp_DHL_manifest and also attached in email. `r`n`r`n Regards, `r`n`r`n PSG Team " -Attachment $attachment -Subject "Alert::USZ Manifest for Geodis Outbound found with DHL_USZ string" | ConvertTo-Html | out-string
Move-Item $patharray D:\outbound_ftp\USZ_HUB\Geodis\Manifest\temp_DHL_manifests
}
else
{
echo "None found"
}
 
