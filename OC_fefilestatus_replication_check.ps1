$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('venkatesh.selvaraju@pb.com','gsp@pitney-bowes.pagerduty.com')
$To1 = @('psg-gsp@pb.com')
$a = "FE_File_Status DB replication is in sync"
$errs1="Error connecting to OC S1 MySQL DB server, please check connectivity"
$errs2="Error connecting to OC S2 MySQL DB server, please check connectivity"


Try {
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$myConnection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=10.53.17.124;uid=psguser;pwd=psguserBD12;database=fe_file_status'}
$myConnection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$myConnection
$MYSQLCommand.CommandText='SELECT filename FROM fe_file_status.file_status order by updatetime desc limit 1;'
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
}
Catch
{
Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
#Send-MailMessage @MailParm -To $To1 -Body "$errs1" -Subject "fe_file_status cross site replication monitor" | ConvertTo-Html | out-string
exit
}
Finally 
{
$myConnection.Close()
}

$fe1orderno=$MYSQLDataSet.tables.filename



Try {
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$myConnection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=10.53.25.45;uid=psguser;pwd=psguserBD12;database=fe_file_status'}
$myConnection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$myConnection
$MYSQLCommand.CommandText='SELECT filename FROM fe_file_status.file_status order by updatetime desc limit 1;'
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
}
Catch
{
Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
#Send-MailMessage @MailParm -To $To1 -Body "$errs2" -Subject "fe_file_status cross site replication monitor" | ConvertTo-Html | out-string


exit
}
Finally 
{
$myConnection.Close()
}
$fe2orderno=$MYSQLDataSet.tables.filename




if($fe1orderno -ne $fe2orderno) 
{    
$b2= "Replication is NOT in sync between S1 and S2 for fe_file_status DB`r`nPlease check the issue.`r`n`r`nS1 Filename : $fe1orderno`r`n`r`nS2 Filename : $fe2orderno`r`n`r`nRegards`r`nPSG Team"
Send-MailMessage @MailParm -To $To1 -Body $b2 -Subject "fe_file_status cross site replication monitor" | ConvertTo-Html | out-string
} 
else
{
$a2= "Replication is in sync between S1 and S2 for fe_file_status DB`r`n`r`nS1 Filename : $fe1orderno `r`n`r`nS2 Filename : $fe2orderno`r`n`r`nRegards`r`nPSG Team"
#Send-MailMessage @MailParm -To $To1 -Body $a2 -Subject "fe_file_status cross site replication monitor" | ConvertTo-Html | out-string
echo $a2
}
