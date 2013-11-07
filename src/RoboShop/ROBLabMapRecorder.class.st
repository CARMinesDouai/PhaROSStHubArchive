Class {
	#name : #ROBLabMapRecorder,
	#superclass : #Object,
	#instVars : [
		'map',
		'robot'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBLabMapRecorder class >> for: aRobot [
	^ self new robot: aRobot; map: ROBLabMap new.
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> map: aMap [
	map := aMap.
	aMap robot: robot.
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> record: aPlace [ 
	aPlace location: robot recordPose.
	map register: aPlace.
	^ aPlace
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> recordElevator [
	^ self record: ROBElevator new. 
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> recordFemaleToilet [ 
	^ self record: ROBToilet female.
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> recordKitchen [
	^ self record: ROBKitchen new. 
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> recordMaleToilet [ 
	^ self record: ROBToilet male.
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> recordOffice: aNumber [
	^ self record: (ROBOffice number: aNumber). 
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> recordStairs [
	^ self record: ROBStairs new. 
]

{ #category : #'as yet unclassified' }
ROBLabMapRecorder >> robot: aRobot [
	robot := aRobot
]
