$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To = @('psg-gsp@pb.com')
#$To = @('venkatesh.selvaraju@pb.com')


$compareDate = $((Get-Date).AddDays(-7))
$comparedate1= $(Get-Date).addminutes(-60)
$filename=gci -path C:\SFTP\ClearPath\CommodityClassificationUpload -filter *.csv  | Where-Object { $_.LastWriteTime -gt $compareDate}  |  Where-Object { $_.LastWriteTime -lt $comparedate1 }
$filename

foreach ($file in $filename)
{
$file1=gci C:\SFTP\ClearPath\CommodityClassificationUpload $file* 
$count=$file1.count
if( $count -lt 2)
{
$file2=$file.name

break
}
else
{
write-host "cotinue..."
}
}


if ($file2 -ne $null)
{
write-host "No corresponding log file generated for $file2"
Send-MailMessage @MailParm -To $To -Body "Hi All, `r`n`r`n Go to C:\SFTP\ClearPath\CommodityClassificationUpload in Prod CPE AUX. `r`n`r`n And check to see why a corresponding log file is not generated for $file2. `r`n`r`n Ensure PB_GSP_CPE_CatalogUpdater_Job is running and engage DEV if needed be  `r`n`r`n Regards, `r`n`r`n PSG Team " -Subject "Alert::Unprocessed File from GDM found" | ConvertTo-Html | out-string
}
else
{
break
}