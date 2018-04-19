$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('venkatesh.selvaraju@pb.com','gsp@pitney-bowes.pagerduty.com')
$To1 = @('psg-gsp@pb.com')
$a = "xbec2rates DB replication is in sync"
$b= "Alert::xbec2rates DB replication is out of sync...engage MySQL DBA team"
$errs1="Error connecting to OC S1 MySQL DB server, please check connectivity"
$errs2="Error connecting to OC S2 MySQL DB server, please check connectivity"


Try {
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$myConnection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=10.53.17.124;uid=psguser;pwd=psguserBD12;database=xbec2rates'}
$myConnection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$myConnection
$MYSQLCommand.CommandText='SELECT * FROM xbec2rates.cache_version order by version desc limit 1'
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
}
Catch
{
Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
#Send-MailMessage @MailParm -To $To1 -Body "$errs1" -Subject "xbec2rates cross site replication monitor" | ConvertTo-Html | out-string


exit
}
Finally 
{
$myConnection.Close()
}

$OC1dvVersion=$MYSQLDataSet.tables.version

Try {
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$myConnection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString='server=10.53.25.45;uid=psguser;pwd=psguserBD12;database=xbec2rates'}
$myConnection.Open()
$MYSQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$MYSQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$MYSQLDataSet = New-Object System.Data.DataSet
$MYSQLCommand.Connection=$myConnection
$MYSQLCommand.CommandText='SELECT * FROM xbec2rates.cache_version order by version desc limit 1'
$MYSQLDataAdapter.SelectCommand=$MYSQLCommand
$NumberOfDataSets=$MYSQLDataAdapter.Fill($MYSQLDataSet, "data")
}
Catch
{
Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
#Send-MailMessage @MailParm -To $To1 -Body "$errs2" -Subject "xbec2rates cross site replication monitor" | ConvertTo-Html | out-string


exit
}
Finally 
{
$myConnection.Close()
}
$OC2dvVersion=$MYSQLDataSet.tables.version



if($OC1dvVersion -ne $OC2dvVersion) {            
Send-MailMessage @MailParm -To $To1 -Body "$b" -Subject "xbec2rates cross site replication monitor" | ConvertTo-Html | out-string
} 
else
{
echo $a
}