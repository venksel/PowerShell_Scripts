$MailParm = @{
  SmtpServer = 'smtp.pb.com'
  From = 'PSG_Monitor@pb.com'
} 
$To = @('psg-gsp@pb.com')
#To = @('venkatesh.selvaraju@pb.com')
$string='error'
$links = Get-Content -Path "C:\PB\Powershell_Scripts\Okta_URL_monitoring\tokenprovider_links.txt"

foreach ($link in $links)
{
Try
{
if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type)
{
$certCallback = @"
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback += 
                    delegate
                    (
                        Object obj, 
                        X509Certificate certificate, 
                        X509Chain chain, 
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
"@
    Add-Type $certCallback
 }
[ServerCertificateValidationCallback]::Ignore()
$urlcontent=Invoke-WebRequest -uri $link -TimeoutSec 200
}
Catch
{
$totlinks += $link
$totlinks += " ; "
#write-host $totlinks
Send-MailMessage @MailParm -To $To -Body " `r`n`r`n Team,`r`n`r`n Token Provider URI(s) below is down, please open an ORT bridge and diagnose the problem. `r`n`r`n $totlinks `r`n`r`n Regards, `r`n`r`n PSG Team" -Subject "CRITICAL :: Token Provider URI monitor" | ConvertTo-Html | out-string
}
Finally
{
 if ($urlcontent -match $string )
{
Send-MailMessage @MailParm -To $To -Body "`r`n`r`n Team, `r`n`r`n Token Provider URI status is in ERROR, please hit the URL below to view the error details - open an ORT bridge and diagnose the problem to minimize impact take relevant site offline in Akamai: `r`n`r`n $link `r`n`r`n Regards, `r`n`r`n PSG Team" -Subject "CRITICAL :: Token Provider URI monitor" | ConvertTo-Html | out-string
}
else
{
write-host "Token Provider is working properly"
}
}
}


