$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'GSP-Service-Monitor@pb.com'
} 
$To1 = @('psg-gsp@pb.com')
$a = "FileExchange is working properly"
$restart="PSG: Please restart PB_GSP_FE_JobScheduler_Job in Prod CPE AUX"
$errcpe="Error connecting to FE_SPRINGBATCH_QUARTZ DB server...please check connectivity"


Try
{
$query = " select count(1) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_EXECUTION] (nolock) where JOB_INSTANCE_ID = (SELECT MAX(JOB_INSTANCE_ID) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_INSTANCE] where JOB_NAME = 'inboundFeedProcessorJob') and START_TIME > dateadd(hour,-1,getdate()) AND END_TIME is null "
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.19.90;Database=FE_SPRINGBATCH_QUARTZ;user id=feapp;password=feappBD12"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$var1= $dataset.tables.column1
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$errcpe" -Subject "FileExchange Service activity monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

Try
{
$query = " select count(1) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_EXECUTION] (nolock) where JOB_INSTANCE_ID = (SELECT MAX(JOB_INSTANCE_ID) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_INSTANCE] where JOB_NAME = 'inboundFeedSchedulerPIJob') and START_TIME > dateadd(hour,-3,getdate()) AND END_TIME is null "
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.19.90;Database=FE_SPRINGBATCH_QUARTZ;user id=feapp;password=feappBD12"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$var2= $dataset.tables.column1
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$errcpe" -Subject "FileExchange Service activity monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

Try
{
$query = " select count(1) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_EXECUTION] (nolock) where JOB_INSTANCE_ID = (SELECT MAX(JOB_INSTANCE_ID) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_INSTANCE] where JOB_NAME = 'inboundFeedSchedulerPIJob') and START_TIME > dateadd(hour,-3,getdate()) AND END_TIME is null "
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.19.90;Database=FE_SPRINGBATCH_QUARTZ;user id=feapp;password=feappBD12"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$var3= $dataset.tables.column1
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$errcpe" -Subject "FileExchange Service activity monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}

Try
{
$query = " select count(1) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_EXECUTION] (nolock) where JOB_INSTANCE_ID = (SELECT MAX(JOB_INSTANCE_ID) FROM [FE_SPRINGBATCH_QUARTZ].[dbo].[BATCH_JOB_INSTANCE] where JOB_NAME = 'shipmentDetailsJob') and START_TIME > dateadd(hour,-1,getdate()) AND END_TIME is null "
$connectionTemplate = "Data Source={0};Integrated Security=SSPI;Initial Catalog={1};"
$connectionString = "Server=10.53.19.90;Database=FE_SPRINGBATCH_QUARTZ;user id=feapp;password=feappBD12"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$var3= $dataset.tables.column1
}
Catch
{
Send-MailMessage @MailParm -To $To1 -Body "$errcpe" -Subject "FileExchange Service activity monitor" | ConvertTo-Html | out-string
exit
}
Finally
{
$connection.Close()
}


if($var1 -gt 0) {            
Send-MailMessage @MailParm -To $To1 -Body "$restart" -Subject "FileExchange inboundFeedProcessorJob has started and has not yet completed (likely to be in hung state)"  | ConvertTo-Html | out-string
} 
else
{
echo $a
}

if($var2 -gt 0) {            
Send-MailMessage @MailParm -To $To1 -Body "$restart" -Subject "FileExchange inboundFeedSchedulerPIJob has started and has not yet completed (likely to be in hung state)"  | ConvertTo-Html | out-string
} 
else
{
echo $a
}

if($var3 -gt 0) {            
Send-MailMessage @MailParm -To $To1 -Body "$restart" -Subject "FileExchange shipmentDetailsJob has started and has not yet completed (likely to be in hung state)"  | ConvertTo-Html | out-string
} 
else
{
echo $a
}

