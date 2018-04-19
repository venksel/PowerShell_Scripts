$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('venkatesh.selvaraju@pb.com')
$To1 = @('psg-gsp@pb.com')

$err = "Error connecting to HUB US parcels, please check connectivity"
Try
{
$server = "US1HUSDBPD.pscloud.pvt"
$db = "Parcels"
$sql = "SELECT  count(1) as Last_1_Hour_KEN_Checkins FROM [Parcels].[HubApp].[Parcel] where createdate >= DATEADD(MINUTE,-60,getdate())  and hubid='KEN'"
$auth=@{}
Invoke-SqlCmd -Server $server -Database $db -Query $sql -Verbose @Auth | out-string 
}
Catch
{
$_

Send-MailMessage @MailParm -To $To1 -Body "$err" -Subject "US_KEN Hub Check-ins For Last One Hour" | ConvertTo-Html | out-string

}

Finally
{

$a = Invoke-SqlCmd -Server $server -Database $db -Query $sql -Verbose @Auth | out-string 
Send-MailMessage @MailParm -To $To1 -Body "$a" -Subject "US_KEN Hub Check-ins For Last One Hour" | ConvertTo-Html | out-string
}