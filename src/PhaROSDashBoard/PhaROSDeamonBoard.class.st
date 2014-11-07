Class {
	#name : #PhaROSDeamonBoard,
	#superclass : #RTBuilder,
	#instVars : [
		'nodes',
		'topics',
		'refreshTime'
	],
	#classVars : [
		'Instance',
		'processes'
	],
	#category : #PhaROSDashBoard
}

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard class >> initProcesses [

	processes do:[:e | e terminate].
	processes := OrderedCollection new.
]

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
	self initProcesses.
]

{ #category : #accessing }
PhaROSDeamonBoard >> changeRefreshTime: anObject [
	
	refreshTime := anObject.
	self initializeProcesses
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	topics := OrderedCollection new.
	refreshTime := 1.
	
	
	nodes := PhaROSSystemInfo instance nodeList.
	topics := PhaROSSystemInfo instance topicList.
	
	processes := OrderedCollection new.
	self initializeProcesses.
	
	
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard >> initializeProcesses [

	processes do:[:e | e terminate].
	processes := OrderedCollection new.
	
	processes add: (
		[
			nodes := PhaROSSystemInfo instance nodeList.
			topics := PhaROSSystemInfo instance topicList.
		] valueWithInterval: refreshTime second)
	
	
]

{ #category : #accessing }
PhaROSDeamonBoard >> nodes [
	
	^ nodes
]

{ #category : #accessing }
PhaROSDeamonBoard >> nodes: anObject [
	
	nodes := anObject
]

{ #category : #accessing }
PhaROSDeamonBoard >> refreshTime [
	
	^ refreshTime
]

{ #category : #accessing }
PhaROSDeamonBoard >> refreshTime: anObject [
	
	refreshTime := anObject
]

{ #category : #accessing }
PhaROSDeamonBoard >> topics [
	
	^ topics
]

{ #category : #accessing }
PhaROSDeamonBoard >> topics: anObject [
	
	topics := anObject
]
