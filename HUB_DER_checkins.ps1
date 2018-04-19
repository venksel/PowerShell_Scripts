$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'DB_execution@pb.com'
} 
$To = @('venkatesh.selvaraju@pb.com')
$To1 = @('psg-gsp@pb.com')

$err = "Error connecting to HUB UK parcels, please check connectivity"
Try
{
$server = "US1HUKDBPD.pscloud.pvt"
$db = "Parcels"
$sql = "SELECT  count(1) as Last_1_Hour_DER_Checkins FROM [Parcels].[HubApp].[Parcel] where createdate >= DATEADD(MINUTE,-60,getdate())  and hubid='DER'"
$auth=@{}
Invoke-SqlCmd -Server $server -Database $db -Query $sql -Verbose @Auth | out-string 
}
Catch
{
$_

Send-MailMessage @MailParm -To $To1 -Body "$err" -Subject "UK_DER Hub Check-ins For Last One Hour" | ConvertTo-Html | out-string

}

Finally
{

$a = Invoke-SqlCmd -Server $server -Database $db -Query $sql -Verbose @Auth | out-string 
Send-MailMessage @MailParm -To $To1 -Body "$a" -Subject "UK_DER Hub Check-ins For Last One Hour" | ConvertTo-Html | out-string
}