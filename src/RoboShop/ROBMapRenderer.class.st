Class {
	#name : #ROBMapRenderer,
	#superclass : #Object,
	#instVars : [
		'html'
	],
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBMapRenderer class >> for: html [
	^ self new html: html; yourself
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> html: aHtml [
	html := aHtml.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderElevator: anElevator [
	^ self renderFacility: anElevator.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderEmployee: anEmployee [
	^ self renderRendereable: anEmployee.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderFacility: aFacility [ 
	^ self renderRendereable: aFacility.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderKitchen: aKitchen [
	^ self renderFacility: aKitchen.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderMap: aMap [
	aMap places do: [ :p | p  renderWith: self ]

]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderOffice: anOffice [
	self renderRendereable: anOffice
		
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderRendereable:  aRendereble [
	
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderRobot: aRobot [
	self renderRendereable: aRobot.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderStair: aStair [
	self renderRendereable: aStair.
]

{ #category : #'as yet unclassified' }
ROBMapRenderer >> renderToilet: aToilet [
	self renderRendereable: aToilet
]
