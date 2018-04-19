$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'Network_monitor@pb.com'
} 
$To = @('psg-gsp@pb.com','gsp@pitney-bowes.pagerduty.com')

$test=Test-Connection 10.53.25.45 -Count 5 -ea silentlycontinue

if ($test.count -lt 3)
{
Send-MailMessage @MailParm -To $To -Body "Network connectivity betweeen US east and US west is lost or S2 OC DB server is offline...please check" -Subject "Network Connectivity between US East and US West regions" | ConvertTo-Html | out-string
Write-Warning ""
}
else
{
write-Host "$S2 is alive and Pinging " -ForegroundColor Green
}