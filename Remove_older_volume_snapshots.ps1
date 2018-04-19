$s1ptde1=Get-EC2Snapshot -region us-east-1 -ProfileName prodtest | Where-Object { $_.Description -like '*oc_de1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ptde2=Get-EC2Snapshot -region us-east-1 -ProfileName prodtest | Where-Object { $_.Description -like '*oc_de2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s2ptde1=Get-EC2Snapshot -region us-west-2 -ProfileName prodtest | Where-Object { $_.Description -like '*oc_de1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s2ptde2=Get-EC2Snapshot -region us-west-2 -ProfileName prodtest | Where-Object { $_.Description -like '*oc_de2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1de1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*oc_de1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1de2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*oc_de2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ukap1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*uk_app1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ukap2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*uk_app2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ukap3=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*uk_app3*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1usap1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*us_app1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1usap2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*us_app2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1usap3=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*us_app3*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ctsap1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*cts_app1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ctsap2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*cts_app2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1cpeaux=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*cpe_aux1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1vrsaux=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*VRS_Aux1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1opsftp=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*op_sftp*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1opsftp1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*Prod_CBS_OP_SFTP D:\*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s2de1=Get-EC2Snapshot -region us-west-2 -ProfileName prod | Where-Object { $_.Description -like '*oc_de1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s2de2=Get-EC2Snapshot -region us-west-2 -ProfileName prod | Where-Object { $_.Description -like '*oc_de2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1rptdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*rpt_db*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1splunk=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*Indexer_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ukdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*UK_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1usdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*US_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1rtpap1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*Reporting_App1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1rtpap2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*Reporting_App2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1hftp=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*HUB_FTP1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ssr2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*SSRS_App2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1grptdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*Reporting_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1pcdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*PC_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ocdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*_OC_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1pimsdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*CPE_DB2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1cpedb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*CPE_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1acc2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*OP_ACC2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1oc1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*OC_APP1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1idpdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*IDP_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1vrsdb=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*VRS_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1oc2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*OC_APP2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ptsd4=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*PTS_DB4*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1cpe4=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*CPE_App4*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1cpe1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*CPE_App1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1cpe3=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*CPE_App3*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ptsd1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*PTS_DB1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ptsd2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*PTS_DB2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1acc1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*OP_ACC*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1opde1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*op_de1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1oms1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*oms_app1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1oms2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*oms_app2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1omsdb1=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*oms_db1*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1cpe2=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*CPE_App2*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1ptsd3=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*PTS_DB3*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1adminserver=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*Admin_Server*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }
$s1opsserver=Get-EC2Snapshot -region us-east-1 -ProfileName prod | Where-Object { $_.Description -like '*prod_PB_ops*' } | Where-Object { $_.Starttime -lt (Get-Date).AddDays(-2) }

foreach($object1 in $s1de1) {
	$localFileName1 = $object1.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName1 -force
}

foreach($object2 in $s1de2) {
	$localFileName2 = $object2.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName2 -force
}

foreach($object3 in $s2de1) {
	$localFileName3 = $object3.SnapshotId
	Remove-EC2Snapshot -region us-west-2 -ProfileName prod -SnapshotId $localFileName3 -force
}

foreach($object4 in $s2de2) {
	$localFileName4 = $object4.SnapshotId
	Remove-EC2Snapshot -region us-west-2 -ProfileName prod -SnapshotId $localFileName4 -force
}

foreach($object5 in $s1ukap1) {
	$localFileName5 = $object5.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName5 -force
}

foreach($object6 in $s1ukap2) {
	$localFileName6 = $object6.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName6 -force
}

foreach($object7 in $s1ukap3) {
	$localFileName7 = $object7.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName7 -force
}

foreach($object8 in $s1usap1) {
	$localFileName8 = $object8.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName8 -force
}

foreach($object9 in $s1usap2) {
	$localFileName9 = $object9.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName9 -force
}

foreach($object10 in $s1usap3) {
	$localFileName10 = $object10.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName10 -force
}

foreach($object11 in $s1ctsap1) {
	$localFileName11 = $object11.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName11 -force
}

foreach($object12 in $s1ctsap2) {
	$localFileName12 = $object12.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName12 -force
}

foreach($object13 in $s1cpeaux) {
	$localFileName13 = $object13.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName13 -force
}

foreach($object14 in $s1vrsaux) {
	$localFileName14 = $object14.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName14 -force
}

foreach($object15 in $s1opsftp) {
	$localFileName15 = $object15.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName15 -force
}

foreach($object16 in $s1rptdb) {
	$localFileName16 = $object16.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName16 -force
}

foreach($object17 in $s1splunk) {
	$localFileName17 = $object17.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName17 -force
}

foreach($object18 in $s1ukdb) {
	$localFileName18 = $object18.SnapshotId
	echo $localFileName18
		Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName18 -force
}

foreach($object19 in $s1rtpap1) {
	$localFileName19 = $object19.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName19 -force
}

foreach($object20 in $s1hftp) {
	$localFileName20 = $object20.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName20 -force
}

foreach($object21 in $s1ssr2) {
	$localFileName21 = $object21.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName21 -force
}

foreach($object22 in $s1grptdb) {
	$localFileName22 = $object22.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName22 -force
}

foreach($object23 in $s1pcdb) {
	$localFileName23 = $object23.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName23 -force
}

foreach($object24 in $s1ocdb) {
	$localFileName24 = $object24.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName24 -force
}

foreach($object25 in $s1pimsdb) {
	$localFileName25 = $object25.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName25 -force
}

foreach($object26 in $s1cpedb) {
	$localFileName26 = $object26.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName26 -force
}

foreach($object27 in $s1acc2) {
	$localFileName27 = $object27.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName27 -force
}

foreach($object28 in $s1oc1) {
	$localFileName28 = $object28.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName28 -force
}

foreach($object29 in $s1idpdb) {
	$localFileName29 = $object29.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName29 -force
}

foreach($object30 in $s1oc2) {
	$localFileName30 = $object30.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName30 -force
}

foreach($object31 in $s1ptsd4) {
	$localFileName31 = $object31.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName31 -force
}

foreach($object32 in $s1cpe4) {
	$localFileName32 = $object32.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName32 -force
}

foreach($object33 in $s1cpe1) {
	$localFileName33 = $object33.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName33 -force
}

foreach($object34 in $s1ptsd1) {
	$localFileName34 = $object34.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName34 -force
}

foreach($object35 in $s1acc1) {
	$localFileName35 = $object35.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName35 -force
}

foreach($object36 in $s1opde1) {
	$localFileName36 = $object36.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName36 -force
}

foreach($object37 in $s1oms1) {
	$localFileName37 = $object37.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName37 -force
}

foreach($object38 in $s1oms2) {
	$localFileName38 = $object38.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName38 -force
}

foreach($object39 in $s1omsdb1) {
	$localFileName39 = $object39.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName39 -force
}

foreach($object40 in $s1cpe2) {
	$localFileName40 = $object40.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName40 -force
}

foreach($object41 in $s1ptsd3) {
	$localFileName41 = $object41.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName41 -force
}

foreach($object42 in $s1cpe3) {
	$localFileName42 = $object42.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName42 -force
}

foreach($object43 in $s1vrsdb) {
	$localFileName43 = $object43.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName43 -force
}

foreach($object44 in $s1rtpap2) {
	$localFileName44 = $object44.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName44 -force
}

foreach($object45 in $s1usdb) {
	$localFileName45 = $object45.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName45 -force
}

foreach($object46 in $s1opde1) {
	$localFileName46 = $object46.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName46 -force
}

foreach($object47 in $s1ptsd2) {
	$localFileName47 = $object47.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName47 -force
}

foreach($object48 in $s1opsftp1) {
	$localFileName48 = $object48.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName48 -force
}

foreach($object49 in $s1ptde1) {
	$localFileName49 = $object49.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prodtest -SnapshotId $localFileName49 -force
}

foreach($object50 in $s1ptde2) {
	$localFileName50 = $object50.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prodtest -SnapshotId $localFileName50 -force
}

foreach($object51 in $s2ptde1) {
	$localFileName51 = $object51.SnapshotId
	Remove-EC2Snapshot -region us-west-2 -ProfileName prodtest -SnapshotId $localFileName51 -force
}

foreach($object52 in $s2ptde2) {
	$localFileName52 = $object52.SnapshotId
	Remove-EC2Snapshot -region us-west-2 -ProfileName prodtest -SnapshotId $localFileName52 -force
}

foreach($object53 in $s1adminserver) {
	$localFileName53 = $object53.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName53 -force
}

foreach($object54 in $s1opsserver) {
	$localFileName54 = $object54.SnapshotId
	Remove-EC2Snapshot -region us-east-1 -ProfileName prod -SnapshotId $localFileName54 -force
}