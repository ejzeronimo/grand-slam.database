<#
NOTE: creates the master CSV for biofile to import into the database

pulls automatically from retrosheet:
https://www.retrosheet.org/biofile.htm

will clean up everything but the output csv
#>

$dataPath = '../in/BIOs.txt';
$transactionExport = '../out/exportBIO.csv';

# then use a rest call to get the zip file
Invoke-RestMethod -Uri 'https://www.retrosheet.org/BIOFILE.TXT' -Method Get -ContentType 'application/text' -OutFile $dataPath;

# import all csvs from the folder
$importedData = Get-ChildItem $dataPath | Select-Object -ExpandProperty FullName | Import-CSV;

# finally export it to a csv
$importedData | Export-Csv -Path $transactionExport -Delimiter ',' -NoTypeInformation;

# delete the zip and the input files
Remove-Item $dataPath -Recurse -Force

# let us know
Write-Output 'Done with game log conversion';