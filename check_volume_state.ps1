$smtpServer = "smtp.pb.com"
$smtp = New-Object Net.Mail.SmtpClient($SmtpServer, 25) 
$msg = new-object Net.Mail.MailMessage
$msg.From = "psggsp@pb.com"
$msg.IsBodyHTML = $true
$msg.To.Add("psg-gsp@pb.com")

#$msg.Body="Please See Attached Files `n `r "
$msg.Subject = "Weekly Unused EC2 Volumes Report from Production & Prodtest AWS accounts"

Get-EC2Volume -region us-east-1 -ProfileName prod | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone | Export-Csv C:\PB\prod-us-east-1.csv
$a=Get-EC2Volume -region us-east-1 -ProfileName prod | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone
Get-EC2Volume -region us-west-2 -ProfileName prod | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone | Export-Csv C:\PB\prod-us-west-2.csv
$b=Get-EC2Volume -region us-west-2 -ProfileName prod | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone
Get-EC2Volume -region us-east-1 -ProfileName prodtest | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone | Export-Csv C:\PB\prodtest-us-east-1.csv
$c=Get-EC2Volume -region us-east-1 -ProfileName prodtest | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone
Get-EC2Volume -region us-west-2 -ProfileName prodtest | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone | Export-Csv C:\PB\prodtest-us-west-2.csv
$d=Get-EC2Volume -region us-west-2 -ProfileName prodtest | Where-Object { $_.State -eq 'available' } | select-object volumeid, size, AvailabilityZone




if($a) {            
$attachment1 = New-Object System.Net.Mail.Attachment -ArgumentList C:\PB\prod-us-east-1.csv
$msg.Attachments.Add($attachment1)
$msg.Body+=" Production us-east-1 : : <b> Unused volume(s) found. Please see attached report </b>  `n `r <br/> "
} else {            
$msg.Body +="Production us-east-1 : : No unsed volumes found `n `r <br />"       
}

if($b) {            
$attachment2 = New-Object System.Net.Mail.Attachment -ArgumentList C:\PB\prod-us-west-2.csv
$msg.Attachments.Add($attachment2)
$msg.Body+="Production us-west-2 : : <b> Unused volume(s) found. Please see attached report </b> `n `r <br/> "
} else {            
$msg.Body +="Production us-west-2 : : No unsed volumes found  `n `r <br />"       
}

if($c) {            
$attachment3 = New-Object System.Net.Mail.Attachment -ArgumentList C:\PB\prodtest-us-east-1.csv
$msg.Attachments.Add($attachment3)
$msg.Body+="ProdTest us-east-1 : :  <b> Unused volume(s) found. Please see attached report </b>  `n `r <br/> "
} else {            
$msg.Body +="ProdTest us-east-1 : : No unsed volumes found  `n `r <br />"       
}

if($d) {            
$attachment4 = New-Object System.Net.Mail.Attachment -ArgumentList C:\PB\prodtest-us-west-2.csv
$msg.Attachments.Add($attachment4)
$msg.Body+="ProdTest us-west-2 : : <b> Unused volume(s) found. Please see attached report </b> `n `r <br/> "
} else {            
$msg.Body +="ProdTest us-west-2 : : No unsed volumes found  `n `r <br />"       
}
$smtp.Send($msg)
$attachment1.Dispose();
$attachment2.Dispose();
$attachment3.Dispose();
$attachment4.Dispose();
$msg.Dispose()

remove-item C:\PB\prod-us-east-1.csv
remove-item C:\PB\prod-us-west-2.csv
remove-item C:\PB\prodtest-us-east-1.csv
remove-item C:\PB\prodtest-us-west-2.csv