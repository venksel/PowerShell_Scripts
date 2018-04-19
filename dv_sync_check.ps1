$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('psg-gsp@pb.com@pb.com','gsp@pitney-bowes.pagerduty.com')
$a = "XBEC_S001 data version is in sync"
$b= "Alert::XBEC_S001 Data Version Is Out Of Sync with PB hosted...Please check OC DE import job"
$errcpe="Error connecting to CPE DB server...please check connectivity"
$erroc1="Error connecting to s1 OC DB server...please check connectivity"


Try
{
$query = " SELECT top 1 * FROM [xbec01p].[dbo].[GlobalVersionInfo] where siteid='xbec_s001' and consumed='y' order by versionNO desc "
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.19.90;Database=xbec01p;user id=psguser;password=psguserBD12"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$errcpe" -Subject "XBEC_S001 DV version Sync Monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

$CPEdvVersion=$DataSet.Tables.versionNO

Try
{
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
Send-MailMessage @MailParm -To $To1 -Body "$erroc1" -Subject "XBEC_S001 DV version Sync Monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$myConnection.Close()
}
$OCdvVersion=$MYSQLDataSet.tables.version

if($CPEdvVersion -ne $OCdvVersion) {            
Send-MailMessage @MailParm -To $To -Body "$b" -Subject "XBEC_S001 DV version Sync Monitor - PB hosted(CPE)=$CPEdvVersion vs OC cache=$OCdvVersion " | ConvertTo-Html | out-string

} 
else
{
echo $a
}