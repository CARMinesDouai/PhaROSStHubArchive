Class {
	#name : #BGSCar2012DoitLogger,
	#superclass : #BGSExplorationLogger,
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #logging }
BGSCar2012DoitLogger >> logHeader [ 
	| columnNames |
	columnNames := #('step' 'frontiers' 'unexplored') asOrderedCollection.
		
	self robots collect: [:bot|
		columnNames add: bot id, '-position'.
		columnNames add: bot id, '-heading'
	].
	self logValues: columnNames asArray
]

{ #category : #logging }
BGSCar2012DoitLogger >> logStep [
	| currentValues |
	
	currentValues := OrderedCollection new.
	
	{self stepCount. self frontiersCount. self unexploredCount}
 		do: [:counter| currentValues add: counter].

	self robots
		do: [ :bot | 
		currentValues add: bot position;
			add: bot heading
	].
	
	self logValues: currentValues
]

{ #category : #'initialize-release' }
BGSCar2012DoitLogger >> logValues: values [
		self log: '{ '.
		values do: [ :aValue | 
				(aValue  isKindOf: String) 
					ifTrue: [ self log: aValue printString ] 
					ifFalse: [ self log: aValue].
				self log: '. '
		].
		self logLf: '}.'
	
]

{ #category : #'initialize-release' }
BGSCar2012DoitLogger >> simulation: aBGSSimulation fileName: aString [
	fileName := aString.
	simulation := aBGSSimulation.
	self stream: (FileStream fileNamed: fileName).
	
	self stream 
		nextPut: $";
		print: DateAndTime now; 
		nextPut: $"; lf;
		nextPut: $";
		nextPutAll: self simulation class name;
		nextPutAll: ' runFor:  ';
		print: self robots size;
		nextPutAll: ' logFileName: ';
		print: fileName; 
		nextPut: $"; lf.
		
	self logValues: {'numberOfRobots'};
		logValues: {self robots size}.
		
	simulation addDependent: self.
	self logHeader
]
