Class {
	#name : #ROBToilet,
	#superclass : #ROBLabElement,
	#instVars : [
		'genre'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #constructor }
ROBToilet class >> female [
	^ self new genre: #female; yourself.
]

{ #category : #constructor }
ROBToilet class >> male [
	^ self new genre: #male; yourself.
]

{ #category : #'as yet unclassified' }
ROBToilet >> asDump [
	^ super asDump, '; genre: #{1} ' format: {genre asString}.
]

{ #category : #accessing }
ROBToilet >> genre [
	^ genre
]

{ #category : #accessing }
ROBToilet >> genre: aGenre [
	genre := aGenre
]
