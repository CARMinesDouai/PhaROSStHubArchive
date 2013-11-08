Class {
	#name : #ROBElementRenderer,
	#superclass : #ROBMapRenderer,
	#instVars : [
		'stairs',
		'toilets',
		'map'
	],
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBElementRenderer >> initialize [
	toilets := Dictionary new.
	stairs := false.
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderEmployee: anEmployee [
	
	
		| person | 
		
		
		html div class:'row' ; with:[
			html anchor url:'#'; onClick: (html jQuery ajax callback: [  : value | map navigateTo: value ] value: anEmployee id ;
						  script: [ : s |  ]); with:[
				person := html div.
				person class: 'robo-item'.
				person with: [  
					html image
						class: 'img-rounded span2';
						style: 'margin-top:5px;';
						url: anEmployee image.
					html div style: 'font-size:14px; display: inline-block; margin-left:40px;margin-top:25px;vertical-align:middle' ; 
							  with: anEmployee name.

				].
			]
		]
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderFacility: aFacility [ 
		
	| facility | 
		html div class:'row' ; with:[
			html anchor url:'#'; onClick: (html jQuery ajax callback: [  : value |  map navigateToFacility: value.  ] value: aFacility id ;
						  script: [ : s | ]); with:[
				facility := html div.
				facility class: 'robo-item'.
				facility with: [  
					html image
						class: 'img-rounded span2';
						style:'margin-top:10px;';
						url: aFacility image.
					html div style: 'font-size:14px; display: inline-block; margin-left:40px;margin-top:25px;vertical-align:middle' ; 
							  with: aFacility name.

				].
			]
		].
	
	
]

{ #category : #'as yet unclassified' }
ROBElementRenderer >> renderMap: aMap [
	
	map:= aMap.	
	

	html div class: 'span6' ;with: [
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
			html anchor url:'#'; onClick: (html jQuery ajax callback: [  : value | map navigateTo: value ] value: anOffice id ;
						  script: [ : s | ]); with:[
				office := html div.
				office class: 'robo-item'.
				office with: [  
					html image
						class: 'img-rounded span2';
						style: 'margin-top:5px;';
						url: anOffice image.
					html div style: 'font-size:14px; display: inline-block; margin-left:40px;margin-top:25px;vertical-align:middle' ; 
							  with: anOffice name.

				].
			]
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
