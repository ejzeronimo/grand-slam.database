# make all the column names
$gameLogColumnHeaders =
'Date', 
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
'VisitingGroundedIntoDoublePlays',
'VisitingAwardedFirstOnCatcherInterference',
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
'HomeGroundedIntoDoublePlays',
'HomeAwardedFirstOnCatcherInterference',
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
'1bUmpireId',
'1bUmpireName',
'2bUmpireId',
'2bUmpireName',
'3bUmpireId',
'3bUmpireName',
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
'VisitingStartingPlayer1Position',
'VisitingStartingPlayer2Id',
'VisitingStartingPlayer2Name',
'VisitingStartingPlayer2Position',
'VisitingStartingPlayer3Id',
'VisitingStartingPlayer3Name',
'VisitingStartingPlayer3Position',
'VisitingStartingPlayer4Id',
'VisitingStartingPlayer4Name',
'VisitingStartingPlayer4Position',
'VisitingStartingPlayer5Id',
'VisitingStartingPlayer5Name',
'VisitingStartingPlayer5Position',
'VisitingStartingPlayer6Id',
'VisitingStartingPlayer6Name',
'VisitingStartingPlayer6Position',
'VisitingStartingPlayer7Id',
'VisitingStartingPlayer7Name',
'VisitingStartingPlayer7Position',
'VisitingStartingPlayer8Id',
'VisitingStartingPlayer8Name',
'VisitingStartingPlayer8Position',
'VisitingStartingPlayer9Id',
'VisitingStartingPlayer9Name',
'VisitingStartingPlayer9Position',
# home starting players
'HomeStartingPlayer1Id',
'HomeStartingPlayer1Name',
'HomeStartingPlayer1Position',
'HomeStartingPlayer2Id',
'HomeStartingPlayer2Name',
'HomeStartingPlayer2Position',
'HomeStartingPlayer3Id',
'HomeStartingPlayer3Name',
'HomeStartingPlayer3Position',
'HomeStartingPlayer4Id',
'HomeStartingPlayer4Name',
'HomeStartingPlayer4Position',
'HomeStartingPlayer5Id',
'HomeStartingPlayer5Name',
'HomeStartingPlayer5Position',
'HomeStartingPlayer6Id',
'HomeStartingPlayer6Name',
'HomeStartingPlayer6Position',
'HomeStartingPlayer7Id',
'HomeStartingPlayer7Name',
'HomeStartingPlayer7Position',
'HomeStartingPlayer8Id',
'HomeStartingPlayer8Name',
'HomeStartingPlayer8Position',
'HomeStartingPlayer9Id',
'HomeStartingPlayer9Name',
'HomeStartingPlayer9Position',
'AdditionalInformation',
'AquisitionInformation';

# import all csvs from the folder
$importedData = Get-ChildItem '../in/GL*.csv' | Select-Object -ExpandProperty FullName | Import-CSV -Header $gameLogColumnHeaders;

# then remove every property with the Name in the property name
$formattedData = $importedData | Select-Object -Property '*' -ExcludeProperty '*Name';

$formattedData | Export-Csv -Path '../out/GL.csv' -Delimiter ',' -NoTypeInformation

Write-Output 'Done with conversion' ;