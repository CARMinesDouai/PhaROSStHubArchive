Class {
	#name : #PhaROSDeamonBoard,
	#superclass : #RTBuilder,
	#instVars : [
		'model',
		'refreshTime'
	],
	#classVars : [
		'Instance',
		'processes'
	],
	#category : #'PhaROSDashBoard-Process'
}

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> instance [

	^ Instance ifNil: [ Instance := super new ]
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> new [

	self error: 'Please, use instance instead.'
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> processes [ 

	^ processes ifNil:[processes := OrderedCollection new].
	
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> start [

	PhaROSDeamonBoard instance initializeProcesses.
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> stop [

	Instance := nil.
	self stopProcesses.
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> stopProcesses [

	processes do:[:e | e terminate].
	processes := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> testProcess [

|thread process output err|
thread := nil.
process:= nil.
output := nil.
"thread := [process := (PipeableOSProcess command: 'ping localhost').] fork.
"thread := [process := (PipeableOSProcess command: 'rostopic bw /turtle1/pose &').] fork.
1 second wait.
"process processProxy sigint.
process processProxy terminate.
"
process processProxy sigint.

"[output isNil or: [output isEmpty]] whileTrue:["
output := process upToEnd.
err:= process errorUpToEnd.
"]."

"process close. "
1 second wait.

	
Transcript show: '==='.
Transcript show: output.
Transcript show: '==='.
Transcript show: err.
Transcript show: process.

process processProxy terminate.
process close.
thread terminate.


thread := nil.
process:= nil.
output := nil.
]

{ #category : #accessing }
PhaROSDeamonBoard >> changeRefreshTime: anObject [
	
	refreshTime := anObject.
	self initializeProcesses
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard >> initialize [
	super initialize.
	model := PhaROSModel instance.
	refreshTime := 2.
	
	processes := OrderedCollection new.
	self initializeProcesses
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard >> initializeProcesses [

	processes do:[:e | e terminate].
	processes := OrderedCollection new.
	
	processes add: (
		[
			model initializeRealLinks.
			model nodesFromStrings: PhaROSSystemInfo instance nodeList.
			model topicsFromStrings: PhaROSSystemInfo instance topicList.
			model nodes do:[:n |
				model extractNodeInfo: n.
				(PhaROSSystemInfo instance pingNode: n rosName) size = 3 
					ifTrue:[n pingable: true]
					ifFalse: [n pingable: false]
			].
			model cleanLinks.
		] valueWithInterval: (refreshTime * 1000) milliseconds)
	
	
]

{ #category : #accessing }
PhaROSDeamonBoard >> model [
	^ model
]

{ #category : #accessing }
PhaROSDeamonBoard >> model: anObject [
	model := anObject
]

{ #category : #accessing }
PhaROSDeamonBoard >> refreshTime [
	
	^ refreshTime
]

{ #category : #accessing }
PhaROSDeamonBoard >> refreshTime: anObject [
	
	refreshTime := anObject
]
