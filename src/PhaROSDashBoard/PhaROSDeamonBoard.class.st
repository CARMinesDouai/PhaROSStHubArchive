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
	#category : #PhaROSDashBoard
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
	self initializeProcesses.
	
	
]

{ #category : #'as yet unclassified' }
PhaROSDeamonBoard >> initializeProcesses [

	|link|
	processes do:[:e | e terminate].
	processes := OrderedCollection new.
	
	processes add: (
		[
			model nodes: PhaROSSystemInfo instance nodeList.
			model topics: PhaROSSystemInfo instance topicList.
			link := Set new.	
			model nodes do:[:n |
				link addAll: (model extractNodeInfo: n).
			].
			model nodeToTopicLink: link.
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
