$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('psg-gsp@pb.com')
$body = "Critical::Average time taken for last six iterations is over 90 minutes"




$extractFile = @"
C:\PB\PowerShell_Scripts\PTS_Adapter_Perfmon\output.csv
"@


$query = "select top 6 * from [TrackingService].Cts2.ServiceNotification with(nolock) where CtsServiceId = 24 and NotificationMessage like '%US1CTSA02PWEC2% PTS Adapter finish%' order by NotificationDate desc"
$connectionString = "Server=10.53.17.223;Database=TrackingService;Integrated Security=True"
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$connection.Close()

$DataSet.Tables[0] | Export-Csv  -NoTypeInformation $extractFile



$i1= $dataset.tables.NotificationDate[0]
$i2= $dataset.tables.NotificationDate[1]
$i3= $dataset.tables.NotificationDate[2]
$i4= $dataset.tables.NotificationDate[3]
$i5= $dataset.tables.NotificationDate[4]
$i6= $dataset.tables.NotificationDate[5]


$diff1= ($i1 - $i2).TotalMinutes
$diff2= ($i2 - $i3).TotalMinutes
$diff3= ($i3 - $i4).TotalMinutes
$diff4= ($i4 - $i5).TotalMinutes
$diff5= ($i5 - $i6).TotalMinutes

$avg=$diff1+$diff2+$diff3+$diff4+$diff5 / 5



#echo 'Average=' "$avg"


if($avg -gt 90) {            
Send-MailMessage @MailParm -To $To -Body $body -Attachment $extractFile -Subject "PTS Adapter performance monitor" | ConvertTo-Html | out-string
} 

if($avg -ge 30) {            
write-host $avg
} 

if($avg -le 10) {            
write-host $avg
#Send-MailMessage @MailParm -To $To -Body $body3 -Attachment $extractFile -Subject "PTS Adapter performance monitor" | ConvertTo-Html | out-string
}


remove-item C:\PB\PowerShell_Scripts\PTS_Adapter_Perfmon\output.csv