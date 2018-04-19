$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'HUB-Service-Monitor@pb.com'
   To = 'samrit.rout@pb.com','PSG-HUB@pb.com'
       Subject = 'CRITICAL ALERT : The SERVICE was in stopped state'
}

get-service 'Splunkd' | ? { $_.Status -eq 'Stopped'  } | % {
Get-Service splunkd | Where {$_.status –eq 'Stopped'} |  Start-Service 
    Send-MailMessage @MailParm -Body "Service	 ''$($_.ServiceName)'' FYI: service was in stopped state and it has been restarted. 
	
	
	Below is the Server Details.`r`n
	Prod_AWS_OP_DE1`r`n
	Host Name: US1XOPDE1PDWEC2`r`n
	LAN IP: 10.53.16.207
	`r`n`r`nRegards`r`nSamrit"
}

# ,'HangFireWindowsService'