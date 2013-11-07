Class {
	#name : #ROBElevator,
	#superclass : #ROBLabElement,
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBElevator >> image [
	^ ROBFileLibrary / #ElevatorPng
]

{ #category : #'as yet unclassified' }
ROBElevator >> isFacility [ 
	^true 
]

{ #category : #'as yet unclassified' }
ROBElevator >> name [
	^ 'Elevator'
]

{ #category : #'as yet unclassified' }
ROBElevator >> renderWith: aRenderer [
	aRenderer renderElevator: self.
]
