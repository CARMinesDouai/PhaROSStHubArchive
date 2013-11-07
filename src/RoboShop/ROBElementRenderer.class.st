Class {
	#name : #ROBElementRenderer,
	#superclass : #Object,
	#instVars : [
		'facilities',
		'offices',
		'persons',
		'tours',
		'stairs',
		'toilets'
	],
	#classVars : [
		'html'
	],
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBElementRenderer class >> for: html [
	^ self new html: html; yourself
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> goButton: anElement [
	html anchor 
	class: 'btn btn-success span3';
	onClick: 
		(html jQuery ajax callback: [  : value | self navigateTo: value ] value: anElement id ;
						  script: [ : s | s alert: 'GoingTO ' , anElement  name ])
		
	;
	script: (html jQuery this button);
	with: [ html text: 'GO' ]
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> goButtonFacility: anElement [
	html anchor 
	class: 'btn btn-success span3';
	onClick: 
		(html jQuery ajax callback: [  : value | self navigateToFacility: value ] value: anElement id;
						  script: [ : s | s alert: 'GoingTO ' , anElement  name ])
		
	;
	script: (html jQuery this button);
	with: [ html text: 'GO' ]
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> html: aHtml [
	html := aHtml.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> initialize [
	toilets := Dictionary new.
	stairs := false.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> navigateTo: a [
	self halt.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> navigateToFacility: a [
	self halt.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderElevator: anElevator [
	^ self renderFacility: anElevator.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderEmployee: anEmployee [
	
	
		| person | 
		html div class:'row' ; with:[
		person := html div.
		
		person with: [  
			self goButton: anEmployee.
			html image
				class: 'img-rounded span3';
				url: anEmployee image.
			html span  style: 'font-size:10px' ; with: anEmployee name.
			
		].
	]
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderFacility: aFacility [ 
		
	
		| facility | 
		html div class:'row' ; with:[
		facility := html div.
		
		facility with: [  
			self goButtonFacility: aFacility.
			html image
				class: 'img-rounded span3';
				url: aFacility image.
			html span style:'font-size:13px';  with: ' ' ,aFacility name.
			
		].
	].
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderKitchen: aKitchen [
	^ self renderFacility: aKitchen.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderMap: aMap [
	
	
		
			html div class: 'span4' ;with: [
				html div class: 'row' ;
				id: 'accordion1';
				script: (html jQuery new accordion collapsible: true; autoHeight: false; yourself);
				with: [ 
					html div: [ html anchor: 'Facilities' ]	.
					html div: [ html paragraph: [aMap facilities do: [ :f | f renderWith: self].]].
					
					html div: [ html anchor: 'Offices' ] .
					html div: [ html paragraph: [aMap offices do: [ :f | self renderOffice: f ]. ]].
					
					html div: [ html anchor: 'Persons' ] .
					html div: [ html paragraph: [aMap employees do: [ :p | self renderEmployee: p  ] ]].
					
					html div: [ html anchor: 'Tours' ] .
					html div: [ html paragraph: 'Comming soon'].
				]
			] .
		

]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderOffice: anOffice [
	
		| office | 
		
		html div class:'row' ; with:[
		office := html div.

		office with: [  
			html image
				class: 'pill-image';
				url: anOffice image.
			html span  style: 'font-size:11px' ; with:' ', anOffice name.
			self goButton: anOffice.
		].
	 	].
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderRobot: aRobot [
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderStair: aStair [
	stairs ifFalse: [
		self renderFacility: aStair.
		stairs := true
	].
	
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderToilet: aToilet [
	toilets at: aToilet genre ifAbsentPut:[
		self renderFacility: aToilet.
		true.	
	]
	
]
