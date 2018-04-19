$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To = @('psg-gsp@pb.com')
#$To = @('venkatesh.selvaraju@pb.com')
$a = "Zero error'd CIPs found for BFR in last ten days"
$b= "Alert::Error'd CIPs for BFR found"
$erroms="Error connecting to OMS DB server...please check connectivity"

Try
{
$query = "SELECT *  FROM [OMS].[dbo].[message] (nolock) where source='bfr' and status='error' and CreateTime < GETDATE() and  CreateTime > '2018-01-15 00:00:00.000'"
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.17.122;Database=oms;user id=psguser;password=psguserBD12"
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
Send-MailMessage @MailParm -To $To -Body "$erroms" -Subject "Error'ed Order Monitor for BFR" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

$output_file1='C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS\BFR_Orders_In_Error_since_inception.csv'
$DataSet.Tables[0] | Export-Csv  -NoTypeInformation $output_file1

$input="C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS"
$output="C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS\BFR_Orders_In_Error_since_inception.zip"

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($input, $output) 
$zipped_output_file1='C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS\BFR_Orders_In_Error_since_inception.zip'

#$EOI=$DataSet.tables.payloadid

#$count1=$EOI.count

Try
{
#$query = "SELECT count(1)  FROM [OMS].[dbo].[message] (nolock) where source='bfr' and status='error' and CreateTime < GETDATE() and  CreateTime > '2018-01-15 00:00:00.000'"
$query2 = "SELECT *  FROM [OMS].[dbo].[message] (nolock) where source='bfr' and status='error' and CreateTime < GETDATE() and  CreateTime > DATEADD(hh,-2,GETDATE())"
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.17.122;Database=oms;user id=psguser;password=psguserBD12"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query2
$command.Connection = $connection
$command.CommandTimeout = 240
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
}
Catch
{
Send-MailMessage @MailParm -To $To -Body "$erroms" -Subject "Error'ed Order Monitor for BFR" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}
 
$order=$DataSet.tables.payloadid

#echo $DataSet.tables.payloadid

$count2=$order.count

#echo $c
$output_file2='C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS\BFR_Orders_In_Error_In_last_2hour.csv'
$DataSet.Tables[0] | Export-Csv  -NoTypeInformation $output_file2

#$attachment=@($zipped_output_file1,$output_file2)
$attachment=@($output_file2)

echo $count2

if ($count2 -gt 0)
{
#echo "count greater then zero"
Send-MailMessage @MailParm -To $To -Attachment $attachment -Body "Hi All, `r`n`r`n Here are the Orders(s) gotten in ERROR status in the last two hours: `r`n`r`n $order `r`n`r`n Please retry order from message table or suitably engage dev if it's a ERBUS/CPE data issue. `r`n`r`n Chances are some of the orders in ERROR is already being reported to DEV and is under investigation per SOS-8763.   `r`n`r`n Regards, `r`n`r`n PSG Team " -Subject "Alert::BFR Orders found in OMS in ERROR Status" | ConvertTo-Html | out-string
}
else
{
echo "No UPID found in error state"
}


Start-Sleep -s 15

Set-Location C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS
remove-item BFR_Orders_In_Error_since_inception.zip
Set-Location C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS
remove-item BFR_Orders_In_Error_since_inception.csv
Set-Location C:\PB\PowerShell_Scripts\BFR_ORDER_Status_check_in_OMS
remove-item BFR_Orders_In_Error_In_last_2hour.csv
