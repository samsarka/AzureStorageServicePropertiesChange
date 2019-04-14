$storage_account_name = ""
$storage_shared_key = ""

$Ctx = New-AzureStorageContext -StorageAccountName $storage_account_name -StorageAccountKey $storage_shared_key

$cntnrs = Get-AzureStorageContainer -Context $Ctx 

foreach($cntnr in $cntnrs)

{
    Write-Host "***" $cntnr.Name "***"
    $blobs = Get-AzureStorageBlob -Context $Ctx -Name $cntnr.Name 

    foreach($blob in $blobs)
    {

        Write-Host $blob.Name 
        # Use the ServiceClient to retrieve the service properties
        $svcprops = $blob.ICloudBlob.ServiceClient.GetServiceProperties()

        # Change the default service version
        $svcprops.DefaultServiceVersion = ""

        # Update the service properties
       $blob.ICloudBlob.ServiceClient.SetServiceProperties($svcprops)

        # Check the service properties
       $blob.ICloudBlob.ServiceClient.GetServiceProperties()

    }
}
