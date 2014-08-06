Class {
	#name : #BGSSimulationScriptGenerator,
	#superclass : #Object,
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #generating }
BGSSimulationScriptGenerator class >> generateAt: folderFullPath minBots: minBotsCount maxBots: maxBotsCount [
	"self generateTopLeftInitialPositionAt: folderFullPath minBots: minBotsCount maxBots: maxBotsCount"
	self generateMeanRandomPositionExperimentAt: folderFullPath minBots: minBotsCount maxBots: maxBotsCount

]

{ #category : #generating }
BGSSimulationScriptGenerator class >> generateExperiment: experimentClass at: folderFullPath minBots: minBotsCount maxBots: maxBotsCount [

	minBotsCount to: maxBotsCount do: [:botsCount|
		|fileStr|
		fileStr := FileStream fileNamed: folderFullPath, '/', (botsCount printStringPadded: 3), '.st'.
		fileStr
			nextPutAll: 'NonInteractiveTranscript stdout install.' ; crlf;
			nextPutAll: experimentClass asString;
			nextPutAll: ' runFor:'; 
			space;
			print: botsCount;
			space;
			nextPutAll: 'in: ';
			nextPutAll: ' (BGSCheckerboardLikeTerrain extent: 100@100)  ';
			"nextPutAll: ' (BGSExplorableTerrain extent: 100@100)  ';"
			nextPutAll: 'logFileName:';
			space;
			nextPut: $' ;
			nextPutAll: folderFullPath;
			nextPut: $/ ;
			nextPutAll: 'result-';
			nextPutAll: (botsCount printStringPadded: 3);
			nextPutAll:  '.st''.';
			crlf;
			close
	]
]

{ #category : #generating }
BGSSimulationScriptGenerator class >> generateMeanRandomPositionExperimentAt: folderFullPath minBots: minBotsCount maxBots: maxBotsCount [
	
	self generateExperiment: BGSMeanSimulationWithRandomPosition at: folderFullPath minBots: minBotsCount maxBots: maxBotsCount
]

{ #category : #generating }
BGSSimulationScriptGenerator class >> generateTopLeftInitialPositionAt: folderFullPath minBots: minBotsCount maxBots: maxBotsCount [

	self generateExperiment: BGSSimulationWithTopLeftIinitialPosition at: folderFullPath minBots: minBotsCount maxBots: maxBotsCount

]
