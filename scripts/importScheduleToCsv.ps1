<#
NOTE: creates the master CSV for schedules to import into the database

pulls automatically from retrosheet:
https://www.retrosheet.org/schedule/index.html

will clean up everything but the output csv
#>

# make all the column names
$scheduleColumnHeaders =
'GameDate',
'NumberOfGames',
'DayOfWeek',
'VisitingTeam',
'VisitingTeamLeague',
'VisitingTeamGameAmount',
'HomeTeam',
'HomeTeamLeague',
'HomeTeamGameAmount',
'TimeOfDay',
'GameStatus',
'DateOfMakeup';

$zipPath = '../in/SKED.zip';
$schedulePath = '../in/schedules';
$scheduleExport = '../out/exportSKED.csv';

# then use a rest call to get the zip file
Invoke-RestMethod -Uri 'http://www.retrosheet.org/schedule/schedule.zip' -Method Get -ContentType 'application/zip' -OutFile $zipPath;

# then expand the schedules
Expand-Archive -Path $zipPath -DestinationPath $schedulePath;

# import all csvs from the folder
$importedData = Get-ChildItem ($schedulePath + '/*.txt') | Select-Object -ExpandProperty FullName | Import-CSV -Header $scheduleColumnHeaders;

# finally export it to a csv
$importedData | Export-Csv -Path $scheduleExport -Delimiter ',' -NoTypeInformation;

# delete the zip and the input files
Remove-Item $schedulePath -Recurse -Force;
Remove-Item $zipPath -Recurse -Force

# let us know
Write-Output 'Done with game log conversion';