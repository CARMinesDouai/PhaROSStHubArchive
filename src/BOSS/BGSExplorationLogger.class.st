"
I log into a file an exploration simulation.
To start logging simply create a logger by evaluating the expression:

	logger := BGSExplorationLogger on: someSimulation 

By default the name of the log file is the class name of the simulation with the current time stamp.
A different can be chosen by evaluating:

	logger := BGSExplorationLogger on: someSimulation logInto: 'myLogFile.txt'

"
Class {
	#name : #BGSExplorationLogger,
	#superclass : #BGSLogger,
	#category : #'BOSS-Exploration'
}

{ #category : #accessing }
BGSExplorationLogger >> frontiersCount [ 
	^self simulation frontierPositionsCount 
]

{ #category : #logging }
BGSExplorationLogger >> logHeader [ 
	#('step' 'frontiers' 'unexplored') 
		do: [:counterName| self log: counterName]
		separatedBy: [self tab].
	self robots do: [:bot|
		self 
			tab;
			log: bot id, '-position';
			tab;
			log: bot id, '-heading'
	].
	self cr.
]

{ #category : #logging }
BGSExplorationLogger >> logStep [
	{self stepCount. self frontiersCount. self unexploredCount}
 		do: [:counter| self log: counter]
		separatedBy: [self tab].

	self robots
		do: [ :bot | 
		self 
			tab
			log: bot position;
			tab;
			log: bot heading
	].
	self cr.
]

{ #category : #accessing }
BGSExplorationLogger >> unexploredCount [ 
	^self simulation unexploredPositionsCount 
]
