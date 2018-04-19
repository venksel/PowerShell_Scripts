$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To = @('psg-gsp@pb.com')
#$To = @('venkatesh.selvaraju@pb.com')
$string='error'
$links = Get-Content -Path "C:\PB\Powershell_Scripts\Okta_URL_monitoring\links.txt"

foreach ($link in $links)
{
Try
{
$urlcontent=Invoke-WebRequest -uri $link -TimeoutSec 200
}
Catch
{
$totlinks += $link
$totlinks += " ; "
#write-host $totlinks
Send-MailMessage @MailParm -To $To -Body " `r`n`r`n Team,`r`n`r`n Okta Proxy URI(s) below is down, please open an ORT bridge and diagnose the problem. `r`n`r`n $totlinks `r`n`r`n Regards, `r`n`r`n PSG Team" -Subject "CRITICAL :: Okta Proxy URI monitor" | ConvertTo-Html | out-string
}
Finally
{
 if ($urlcontent -match $string )
{
Send-MailMessage @MailParm -To $To -Body "`r`n`r`n Team, `r`n`r`n Okta Proxy URI status is in ERROR, please hit the URL below to view the error details - open an ORT bridge and diagnose the problem to minimize impact take relevant site offline in Akamai: `r`n`r`n $link `r`n`r`n Regards, `r`n`r`n PSG Team" -Subject "CRITICAL :: Okta Proxy URI monitor" | ConvertTo-Html | out-string
}
else
{
write-host "Okta proxy is working properly"
}
}

}


