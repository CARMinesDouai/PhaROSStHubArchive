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
	#category : #'PhaROS-Nodelets-MoveBase'
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseGoal class >> for: aPose [
	^ self new destination: aPose; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseGoal class >> texts [
	^ {
		Actionlib_msgsGoalStatus aborted -> 'Aborted' .
		Actionlib_msgsGoalStatus active -> 'Active' .		
		Actionlib_msgsGoalStatus lost -> 'Lost' .
		Actionlib_msgsGoalStatus pending -> 'Pending' .
		Actionlib_msgsGoalStatus preempted -> 'Preempted' .
		Actionlib_msgsGoalStatus preempting  -> 'Preempting' .
		Actionlib_msgsGoalStatus recalled -> 'Recalled' .
		Actionlib_msgsGoalStatus recalling -> 'Recalling' .
		Actionlib_msgsGoalStatus rejected -> 'Rejected' .
		Actionlib_msgsGoalStatus succeeded  -> 'Succeded' .
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
	status := Actionlib_msgsGoalStatus pending.
	stop := [ self stopTracking ].
	self onSucceeded: stop.
	self onAborted: stop.
	self onRejected: stop.
	
]

{ #category : #events }
PhaROSMoveBaseGoal >> on: aStatus do: aCallback [
	(callbacks at: aStatus ifAbsentPut: [ Set new ]) add: aCallback.
]

{ #category : #events }
PhaROSMoveBaseGoal >> onAborted: aBlock [
	^ self on: Actionlib_msgsGoalStatus aborted do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onActive: aBlock [
	^ self on: Actionlib_msgsGoalStatus active do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onLost: aBlock [
	^ self on: Actionlib_msgsGoalStatus lost do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onPending: aBlock [
	^ self on: Actionlib_msgsGoalStatus pending do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onPreempted: aBlock [
	^ self on: Actionlib_msgsGoalStatus preempted  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onPreempting: aBlock [
	^ self on: Actionlib_msgsGoalStatus preempting  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onRecalled: aBlock [
	^ self on: Actionlib_msgsGoalStatus recalled  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onRecalling: aBlock [
	^ self on: Actionlib_msgsGoalStatus recalling  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onRejected: aBlock [
	^ self on: Actionlib_msgsGoalStatus rejected  do: aBlock .
]

{ #category : #events }
PhaROSMoveBaseGoal >> onSucceeded: aBlock [
	^ self on: Actionlib_msgsGoalStatus succeeded   do: aBlock .
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
	previous := status.
	status := aStatus.
	callbacks at: status  ifPresent: [ : callsFor | 
		callsFor do: [ : callbck | 	callbck cull: self cull: previous ].
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
