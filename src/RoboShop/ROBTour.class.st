Class {
	#name : #ROBTour,
	#superclass : #ROBLabElement,
	#instVars : [
		'places',
		'name'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #tours }
ROBTour class >> evaluationTourA: aMap [
	^ self new name: 'Demo Tour' ; 
		image: ROBFileLibrary / #tourPng;
		register: (aMap searchOneForId: ROBOffice office3130 id) ;
		register: (aMap searchOneForId: ROBOffice office3130B id) ; 
		register: (aMap searchOneForId: ROBOffice office3103 id) ; 
		register: (aMap searchOneForId: ROBStairs centralStairs id).
]

{ #category : #tours }
ROBTour class >> pharoTeamTour: aMap [
	^ self new name: 'Pharo team' ; 
		image: ROBFileLibrary / #pharoPng;
		register: (aMap searchOneForId: ROBEmployee NouryBOURAQADI id) ;
		register: (aMap searchOneForId: ROBEmployee LucFABRESSE id) ;
		register: (aMap searchOneForId: ROBEmployee JannikLAVAL id) ;
		register: (aMap searchOneForId: ROBEmployee GuillermoPOLITO id) ;
		register: (aMap searchOneForId: ROBEmployee NickolaosPAPOULIAS id) ;
		register: (aMap searchOneForId: ROBEmployee ZhiYAN id) ;
		register: (aMap searchOneForId: ROBEmployee SantiagoBRAGAGNOLO id) .
]

{ #category : #tours }
ROBTour class >> roboticTeamTour: aMap [
	^ self new name: 'RoboShop team' ; 
		image: ROBFileLibrary / #roboticTeamPng;
		register: (aMap searchOneForId: ROBEmployee SantiagoBRAGAGNOLO id) ; 
		register: (aMap searchOneForId: ROBEmployee NouryBOURAQADI id) ; 
		register: (aMap searchOneForId: ROBEmployee LucFABRESSE id) ; 
		register: (aMap searchOneForId: ROBEmployee ZhiYAN id) ; 
		register: (aMap searchOneForId: ROBEmployee JannikLAVAL id) ; 
		register: (aMap searchOneForId: ROBEmployee AnthonyFLEURY id) ; 
		register: (aMap searchOneForId: ROBEmployee ArnaudDONIEC id) .
]

{ #category : #'as yet unclassified' }
ROBTour >> id [
	^ name.
]

{ #category : #'as yet unclassified' }
ROBTour >> initialize [
	places := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ROBTour >> isTour [
	^ true.
]

{ #category : #'as yet unclassified' }
ROBTour >> name [
	^ name
]

{ #category : #'as yet unclassified' }
ROBTour >> name: aName [
	name:= aName
]

{ #category : #'as yet unclassified' }
ROBTour >> places [
	^ places.
]

{ #category : #'as yet unclassified' }
ROBTour >> register: aPlace [
	places add: aPlace
]

{ #category : #'as yet unclassified' }
ROBTour >> renderWith: aRenderer [
	aRenderer renderTour: self.
]
