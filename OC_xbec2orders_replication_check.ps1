$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('venkatesh.selvaraju@pb.com','gsp@pitney-bowes.pagerduty.com')
$To1 = @('psg-gsp@pb.com')
$a = "xbec2orders DB replication is in sync"
$errs1="Error connecting to OC S1 MySQL DB server, please check connectivity"
$errs2="Error connecting to OC S2 MySQL DB server, please check connectivity"

Try {
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$myConnection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=10.53.17.124;uid=psguser;pwd=psguserBD12;database=xbec2orders'}
$myConnection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$myConnection
$MYSQLCommand.CommandText='SELECT ordernumber FROM xbec2orders.order_details order by ReferenceDate desc limit 1;'
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
}
Catch
{
Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
#Send-MailMessage @MailParm -To $To1 -Body "$errs1" -Subject "xbec2orders cross site replication monitor" | ConvertTo-Html | out-string


exit
}
Finally 
{
$myConnection.Close()
}

$OC1orderno=$MYSQLDataSet.tables.ordernumber


Try {
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$myConnection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=10.53.25.45;uid=psguser;pwd=psguserBD12;database=xbec2orders'}
$myConnection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$myConnection
$MYSQLCommand.CommandText='SELECT ordernumber FROM xbec2orders.order_details order by ReferenceDate desc limit 1;'
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
}
Catch
{
Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
#Send-MailMessage @MailParm -To $To1 -Body "$errs2" -Subject "xbec2orders cross site replication monitor" | ConvertTo-Html | out-string


exit
}
Finally 
{
$myConnection.Close()
}
$OC2orderno=$MYSQLDataSet.tables.ordernumber




if($OC1orderno -ne $OC2orderno) 
{    
$b1= "Replication is NOT in sync between S1 and S2 for xbec2orders DB`r`nPlease check the issue.`r`n`r`nS1 Order Number : $OC1orderno`r`n`r`nS2 Order Number : $OC2orderno`r`n`r`nRegards`r`nPSG Team"
Send-MailMessage @MailParm -To $To1 -Body $b1 -Subject "xbec2orders cross site replication monitor" | ConvertTo-Html | out-string
} 
else
{
$a1= "Replication is in sync between S1 and S2 for xbec2orders DB`r`n`r`nS1 Order Number : $OC1orderno `r`n`r`nS2 Order Number : $OC2orderno`r`n`r`nRegards`r`nPSG Team"
#Send-MailMessage @MailParm -To $To1 -Body $a1 -Subject "xbec2orders cross site replication monitor" | ConvertTo-Html | out-string
echo $a1

}