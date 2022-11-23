<#
NOTE: creates the master CSV for transactions to import into the database

pulls automatically from retrosheet:
https://www.retrosheet.org/transactions/readme.txt

will clean up everything but the output csv
#>

# make all the column names
$transactionColumnHeaders =
'PrimaryDate',
'Time',
'PrimaryApprox',
'SecondaryDate',
'SecondaryApprox',
'TransactionId',
'PlayerId',
'Type',
'FromTeam',
'FromLeague',
'ToTeam',
'ToLeague',
'DraftType',
'DraftRound',
'PickNumber',
'OtherInformation';

$zipPath = '../in/TRANs.zip';
$transactionPath = '../in/transactions';
$transactionExport = '../out/exportTRAN.csv';

# then use a rest call to get the zip file
Invoke-RestMethod -Uri 'https://www.retrosheet.org/transactions/tranDB.zip' -Method Get -ContentType 'application/zip' -OutFile $zipPath;

# then expand the transactions
Expand-Archive -Path $zipPath -DestinationPath $transactionPath;

# import all csvs from the folder
$importedData = Get-ChildItem ($transactionPath + '/tran.txt') | Select-Object -ExpandProperty FullName | Import-CSV -Header $transactionColumnHeaders;

# then replace every property with "Approx" in the property name
$formattedData = $importedData | Select-Object -ExcludeProperty '*Approx' -Property '*', @{Name = 'PrimaryDateIsApproximate'; Expression = { $_.PrimaryApprox -replace "@", 1 } }, @{Name = 'SecondaryDateIsApproximate'; Expression = { $_.SecondaryApprox -replace "@", 1 } };

# finally export it to a csv
$formattedData | Export-Csv -Path $transactionExport -Delimiter ',' -NoTypeInformation;

# delete the zip and the input files
Remove-Item $transactionPath -Recurse -Force;
Remove-Item $zipPath -Recurse -Force

# let us know
Write-Output 'Done with game log conversion';