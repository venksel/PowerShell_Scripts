$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To1 = @('psg-gsp@pb.com')
$body= "PSG Team:  Logon to Prod CPE AUX and reprocess file(s) under C:\Exporters\FileExchange\shipmentInbound\error ; check logs under C:\Exporters\FileExchange\log\shipment to learn more about what caused the error and if needed be engage DEV team"
set-location C:\Exporters\FileExchange\shipmentInbound\error
$count=Get-ChildItem *.json | Measure-Object | %{$_.Count}
if($count -gt 0) {            
Send-MailMessage @MailParm -To $To1 -Body "$body" -Subject "Unprocessed AGL manifests found"  | ConvertTo-Html | out-string
} 
else
{
echo $count
}

