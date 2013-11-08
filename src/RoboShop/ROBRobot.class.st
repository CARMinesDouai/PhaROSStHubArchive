Class {
	#name : #ROBRobot,
	#superclass : #ROBLabElement,
	#instVars : [
		'name',
		'positionFetcher'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #constructor }
ROBRobot class >> name: aByteSymbol pose: aBlockClosure [ 
	^ self new name: aByteSymbol ; position: aBlockClosure; yourself 
]

{ #category : #accessing }
ROBRobot >> asDump [ 	
	^ ''
]

{ #category : #accessing }
ROBRobot >> id [
	^ -1
]

{ #category : #accessing }
ROBRobot >> image [
	^ ROBFileLibrary / #kcronPng
]

{ #category : #accessing }
ROBRobot >> name: aName [
	name := aName
]

{ #category : #accessing }
ROBRobot >> position [
	^ positionFetcher value.
]

{ #category : #accessing }
ROBRobot >> position: aPositionFetchBlock [
	positionFetcher := aPositionFetchBlock 
]

{ #category : #accessing }
ROBRobot >> renderWith: aRenderer [
	aRenderer renderRobot: self.
]
