Class {
	#name : #ROBEmployee,
	#superclass : #Object,
	#instVars : [
		'name',
		'office',
		'titles',
		'charge',
		'work'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #accessing }
ROBEmployee >> asDump [
	^ ' {1} new charge: ''{2}''; name: ''{3}'' ; titles: ''{4}''; work: ''{5}'' ' format:  {self class name.  charge . name . titles . work }
]

{ #category : #accessing }
ROBEmployee >> charge [
	
	^ charge
]

{ #category : #accessing }
ROBEmployee >> charge: aString [
	
	charge := aString
]

{ #category : #accessing }
ROBEmployee >> name: aString [
	
	name := aString
]

{ #category : #accessing }
ROBEmployee >> office [
	
	^ office
]

{ #category : #accessing }
ROBEmployee >> office: anOffice [
	office := anOffice.
]

{ #category : #accessing }
ROBEmployee >> titles [
	
	^ titles
]

{ #category : #accessing }
ROBEmployee >> titles: aString [
	
	titles := aString
]

{ #category : #accessing }
ROBEmployee >> work [
	
	^ work
]

{ #category : #accessing }
ROBEmployee >> work: aString [
	
	work := aString
]
