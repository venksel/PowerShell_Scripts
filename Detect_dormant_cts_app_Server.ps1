$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To = @('venkatesh.selvaraju@pb.com')
#$To = @('psg-gsp@pb.com')

$smtpServer = "smtp.pb.com"
$smtp = New-Object Net.Mail.SmtpClient($SmtpServer, 25) 
$msg = new-object Net.Mail.MailMessage
$msg.From = "psg_monitor@pb.com"
$msg.IsBodyHTML = $true
$msg.To.Add("psg-gsp@pb.com")
$msg.Subject = "PTS Adapter activity monitor"


$err1="Error connecting to TrackingService DB - please check"

Try
{
$query = "select count(1) as ctsapp1 from [TrackingService].Cts2.ServiceNotification with(nolock) where CtsServiceId = 24 and NotificationMessage like '%US1CTSA01PWEC2% PTS Adapter finish%' and NotificationDate >= DATEADD(MINUTE,-60,getdate())"
$connectionString = "Server=10.53.17.223;Database=TrackingService;Integrated Security=True"
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$command.CommandTimeout = 240
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$err1" -Subject "CTS App server activity monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

$var1= $dataset.tables.ctsapp1




Try
{
$query = "select count(1) as ctsapp2 from [TrackingService].Cts2.ServiceNotification with(nolock) where CtsServiceId = 24 and NotificationMessage like '%US1CTSA02PWEC2% PTS Adapter finish%' and NotificationDate >= DATEADD(MINUTE,-60,getdate())"
$connectionString = "Server=10.53.17.223;Database=TrackingService;Integrated Security=True"
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$command.CommandTimeout = 240
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$err1" -Subject "CTS App server activity monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

$var2= $dataset.tables.ctsapp2

$ctr1=0
$ctr2=0
#echo $var1
#echo $var2

if($var1 -eq 0) {            
$msg.Body+=" `r`n`r`n CTS app1 server is not actively involved in CTS to PTS Adapter push in the last one hour. `r`n`r`n  For troubleshooting purpose, please recycle CTS Application service and or engage DEV team `r`n`r`n"

 

} else {            
$ctr1+=1
}

if($var2 -eq 0) {            
$msg.Body+=" `r`n`r`n CTS app2 server is not actively involved in CTS to PTS Adapter push in the last one hour. `r`n`r`n  For troubleshooting purpose, please recycle CTS Application service and or engage DEV team `r`n`r`n  "
} else {            
$ctr2+=1
}

if ($ctr1 -gt 0 -AND $ctr2 -gt 0)
{
exit
}
else
{
$smtp.Send($msg)
$msg.Dispose()
}
