"
This object defines a collection of callbacks for error management
"
Class {
	#name : #PhaROSConfigurableErrorManagement,
	#superclass : #Object,
	#instVars : [
		'errors'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSConfigurableErrorManagement >> errorCallbacksFor: anError [

	^ errors at: anError ifAbsent: [ 
		anError = Exception ifTrue: [ 
			Set new 
		] ifFalse: [ 
			self errorCallbacksFor: anError superclass.
		 ]
	 ].
]

{ #category : #convenience }
PhaROSConfigurableErrorManagement >> errors: anErrorManagementDictionary [
	errors := anErrorManagementDictionary 
]

{ #category : #'as yet unclassified' }
PhaROSConfigurableErrorManagement >> execute: aBlock [
	^ aBlock on: Error do: [ :e |
		self manageError: e.
		e signal.
	]
]

{ #category : #convenience }
PhaROSConfigurableErrorManagement >> initialize [
	super initialize.
	errors := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSConfigurableErrorManagement >> manageError: anError [
	| callbackErrors |

	callbackErrors := Set new.
	
	(self errorCallbacksFor: anError class ) do: [ 
		: ec | [ec cull: anError] on: Error do: [ :e | 
			callbackErrors add: e
		] .	
	].
	callbackErrors size > 0 ifTrue: [ 
		self error: 'Error executing callbacks! Check callbackErrors set '.
		callbackErrors inspect. 
	 ]
	
]

{ #category : #convenience }
PhaROSConfigurableErrorManagement >> on: anErrorClass do: aValuable [
	(errors at: anErrorClass ifAbsentPut: [ Set new ]) add: aValuable.
]
