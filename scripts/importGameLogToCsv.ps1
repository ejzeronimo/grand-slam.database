<#
NOTE: creates the master CSV for gamelogs to import into the database

pulls automatically from retrosheet:
https://www.retrosheet.org/gamelogs/index.html

will clean up everything but the output csv
#>

# make all the column names
$gameLogColumnHeaders =
'GameDate', 
'GameNumber', 
'DayOfWeek', 
'VisitingTeam',
'VisitingLeague',
'VisitingGameNumber', 
'HomeTeam',
'HomeLeague',
'HomeGameNumber', 
'VisitingScore', 
'HomeScore', 
'LengthInOuts', 
'DayOrNight', 
'CompletionInformation', 
'ForfeitInformation', 
'ProtestInformation', 
'ParkId', 
'Attendance', 
'TimeInMinutes', 
# line scores
'VisitingLineScore', 
'HomeLineScore', 
# visiting team offensive stats
'VisitingAtBats',
'VisitingHits',
'VisitingDoubles',
'VisitingTriples',
'VisitingHomeRuns',
'VisitingRBI',
'VisitingSacrificeHits',
'VisitingSacrificeFlies',
'VisitingHitByPitch',
'VisitingWalks',
'VisitingIntentionalWalks',
'VisitingStrikeouts',
'VisitingStolenBases',
'VisitingCaughtStealing',
'VisitingGroundIntoDoublePlays',
'VisitingAwardedFirstOnCatchInt',
'VisitingLeftOnBase',
# visiting team pitching stats
'VisitingPitchersUsed',
'VisitingIndividualEarnedRuns',
'VisitingTeamEarnedRuns',
'VisitingWildPitches',
'VisitingBalks',
# visiting team defensive stats
'VisitingPutouts',
'VisitingAssists',
'VisitingErrors',
'VisitingPassedBalls',
'VisitingDoublePlays',
'VisitingTriplePlays',
# home team offensive stats
'HomeAtBats',
'HomeHits',
'HomeDoubles',
'HomeTriples',
'HomeHomeRuns',
'HomeRBI',
'HomeSacrificeHits',
'HomeSacrificeFlies',
'HomeHitByPitch',
'HomeWalks',
'HomeIntentionalWalks',
'HomeStrikeouts',
'HomeStolenBases',
'HomeCaughtStealing',
'HomeGroundIntoDoublePlays',
'HomeAwardedFirstOnCatchInt',
'HomeLeftOnBase',
# home team pitching stats
'HomePitchersUsed',
'HomeIndividualEarnedRuns',
'HomeTeamEarnedRuns',
'HomeWildPitches',
'HomeBalks',
# home team defensive stats
'HomePutouts',
'HomeAssists',
'HomeErrors',
'HomePassedBalls',
'HomeDoublePlays',
'HomeTriplePlays',
# umpires
'HomePlateUmpireId',
'HomePlateUmpireName',
'FirstBaseUmpireId',
'FirstBaseUmpireName',
'SecondBaseUmpireId',
'SecondBaseUmpireName',
'ThirdBaseUmpireId',
'ThirdBaseUmpireName',
'LfUmpireId',
'LfUmpireName',
'RfUmpireId',
'RfUmpireName',
# managers
'VisitingTeamManagerId',
'VisitingTeamManagerName',
'HomeTeamManagerId',
'HomeTeamManagerName',
# pitchers
'WinningPitcherId',
'WinningPitcherName',
'LosingPitcherId',
'LosingPitcherName',
'SavingPitcherId',
'SavingPitcherName',
# batters
'GameWinningRBIBatterId',
'GameWinningRBIBatterName',
# starting pitchers
'VisitingStartingPitcherId',
'VisitingStartingPitcherName',
'HomeStartingPitcherId',
'HomeStartingPitcherName',
# visiting starting players
'VisitingStartingPlayer1Id',
'VisitingStartingPlayer1Name',
'VisitingStartingPlayer1Pos',
'VisitingStartingPlayer2Id',
'VisitingStartingPlayer2Name',
'VisitingStartingPlayer2Pos',
'VisitingStartingPlayer3Id',
'VisitingStartingPlayer3Name',
'VisitingStartingPlayer3Pos',
'VisitingStartingPlayer4Id',
'VisitingStartingPlayer4Name',
'VisitingStartingPlayer4Pos',
'VisitingStartingPlayer5Id',
'VisitingStartingPlayer5Name',
'VisitingStartingPlayer5Pos',
'VisitingStartingPlayer6Id',
'VisitingStartingPlayer6Name',
'VisitingStartingPlayer6Pos',
'VisitingStartingPlayer7Id',
'VisitingStartingPlayer7Name',
'VisitingStartingPlayer7Pos',
'VisitingStartingPlayer8Id',
'VisitingStartingPlayer8Name',
'VisitingStartingPlayer8Pos',
'VisitingStartingPlayer9Id',
'VisitingStartingPlayer9Name',
'VisitingStartingPlayer9Pos',
# home starting players
'HomeStartingPlayer1Id',
'HomeStartingPlayer1Name',
'HomeStartingPlayer1Pos',
'HomeStartingPlayer2Id',
'HomeStartingPlayer2Name',
'HomeStartingPlayer2Pos',
'HomeStartingPlayer3Id',
'HomeStartingPlayer3Name',
'HomeStartingPlayer3Pos',
'HomeStartingPlayer4Id',
'HomeStartingPlayer4Name',
'HomeStartingPlayer4Pos',
'HomeStartingPlayer5Id',
'HomeStartingPlayer5Name',
'HomeStartingPlayer5Pos',
'HomeStartingPlayer6Id',
'HomeStartingPlayer6Name',
'HomeStartingPlayer6Pos',
'HomeStartingPlayer7Id',
'HomeStartingPlayer7Name',
'HomeStartingPlayer7Pos',
'HomeStartingPlayer8Id',
'HomeStartingPlayer8Name',
'HomeStartingPlayer8Pos',
'HomeStartingPlayer9Id',
'HomeStartingPlayer9Name',
'HomeStartingPlayer9Pos',
'AdditionalInformation',
'AquisitionInformation';

$zipPath = '../in/GLs.zip';
$gameLogsPath = '../in/gamelogs';
$gameLogExport = '../out/exportGL.csv';

# then use a rest call to get the zip file
Invoke-RestMethod -Uri 'https://www.retrosheet.org/gamelogs/gl1871_2021.zip' -Method Get -ContentType 'application/zip' -OutFile $zipPath;

# then expand the gamelogs
Expand-Archive -Path $zipPath -DestinationPath $gameLogsPath;

# import all csvs from the folder
$importedData = Get-ChildItem ($gameLogsPath + '/GL*.txt') | Select-Object -ExpandProperty FullName | Import-CSV -Header $gameLogColumnHeaders;

# then remove every property with "Name" in the property name
$formattedData = $importedData | Select-Object  -ExcludeProperty '*Name' -Property '*' , @{Name = 'GameId'; Expression = { $_.HomeTeam + $_.GameDate + $_.GameNumber } };

# finally export it to a csv
$formattedData | Export-Csv -Path $gameLogExport -Delimiter ',' -NoTypeInformation;

# delete the zip and the input files
Remove-Item $gameLogsPath -Recurse -Force;
Remove-Item $zipPath -Recurse -Force

# let us know
Write-Output 'Done with game log conversion' ;