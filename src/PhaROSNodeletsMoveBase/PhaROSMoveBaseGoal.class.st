Class {
	#name : #PhaROSMoveBaseGoal,
	#superclass : #Object,
	#instVars : [
		'client',
		'destination',
		'status',
		'callbacks',
		'text',
		'id',
		'stamp'
	],
	#category : #PhaROSNodeletsMoveBase
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseGoal class >> for: aPose [
	^ self new destination: aPose; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseGoal class >> texts [
	|GoalStatusClass|
	GoalStatusClass := 'actionlib_msgs/GoalStatus' asPhaROSTypeClass.

	^ {
		GoalStatusClass aborted -> 'Aborted' .
		GoalStatusClass active -> 'Active' .		
		GoalStatusClass lost -> 'Lost' .
		GoalStatusClass pending -> 'Pending' .
		GoalStatusClass preempted -> 'Preempted' .
		GoalStatusClass preempting  -> 'Preempting' .
		GoalStatusClass recalled -> 'Recalled' .
		GoalStatusClass recalling -> 'Recalling' .
		GoalStatusClass rejected -> 'Rejected' .
		GoalStatusClass succeeded  -> 'Succeded' .
	} asDictionary 
]

{ #category : #manage }
PhaROSMoveBaseGoal >> cancel [ 
	^ client cancelGoal: self.
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> client: aClient [
	client := aClient
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> destination [ 
	^ destination 
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> destination: aPose [
	 destination := aPose 
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> id [
	^ id
]

{ #category : #'initialize-release' }
PhaROSMoveBaseGoal >> initialize [ 
	| stop |
	super initialize.
	id := DateAndTime now asUnixTime asString.
	callbacks := Dictionary new. 
	status := 'actionlib_msgs/GoalStatus' asPhaROSTypeClass pending.
	stop := [ self stopTracking ].
	
	self onSucceeded: stop.
	self onAborted: stop.
	self onRejected: stop.
	
]

{ #category : #events }
PhaROSMoveBaseGoal >> on: aStatus do: aCallback [
	(callbacks 
		at: aStatus 
		ifAbsentPut: [ OrderedCollection new ]) add: aCallback
]

{ #category : #events }
PhaROSMoveBaseGoal >> onAborted: aBlock [
	^ self 
		on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass aborted 
		do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onActive: aBlock [
	^ self 
		on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass active 
		do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onLost: aBlock [
	^ self 
		on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass lost 
		do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onPending: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass pending do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onPreempted: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass preempted  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onPreempting: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass preempting  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onRecalled: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass recalled  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onRecalling: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass recalling  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onRejected: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass rejected  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onSucceeded: aBlock [
	^ self on: 'actionlib_msgs/GoalStatus' asPhaROSTypeClass succeeded  do: aBlock .
]

{ #category : #printing }
PhaROSMoveBaseGoal >> printOn: aStream [
	('{1}-{2}' format: { id . self statusText }) printOn: aStream.
]

{ #category : #manage }
PhaROSMoveBaseGoal >> recall [ 
	^ client goToGoal: self.
]

{ #category : #manage }
PhaROSMoveBaseGoal >> stamp [ 	
	^ stamp 
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> stamp: aStamp [ 
	stamp := aStamp .
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> status [
	^ status 
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> status: aStatus [
	| previous |
	status = aStatus ifFalse: [
		previous := status.
		status := aStatus.
		callbacks at: status  ifPresent: [ : callsFor | 
			callsFor do: [ : callbck | 	callbck cull: self cull: previous ].
		]
	]
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> statusText [
	^ self class texts at: self status. 
]

{ #category : #manage }
PhaROSMoveBaseGoal >> stopTracking [ 
	client remove: self.
]

{ #category : #accessing }
PhaROSMoveBaseGoal >> text: aString [
	text := aString 
]
