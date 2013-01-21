Class {
	#name : #IONotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'analogicInputs',
		'inputs'
	],
	#category : #'PureNoLog-Notifications'
}

{ #category : #'as yet unclassified' }
IONotification >> analogicInputs: anAmountOfInputs [
	analogicInputs := anAmountOfInputs.
]

{ #category : #'as yet unclassified' }
IONotification >> initialize [
	inputs := Dictionary new. 
	
]

{ #category : #'as yet unclassified' }
IONotification >> load: notificationSource [
	| decoder |
	super load: notificationSource.
	decoder := notificationSource decoder.	
	self shouldBeImplemented.
	" The documentation doent make much sense about the definition of this data. It talk about inputs but in very generical way "
	
	self flag: #LookAtTheComment.
]
