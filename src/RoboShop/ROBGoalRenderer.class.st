Class {
	#name : #ROBGoalRenderer,
	#superclass : #ROBMapRenderer,
	#instVars : [
		'map'
	],
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBGoalRenderer >> renderEventsFrom: aMap on: aHtml [
	| goals |
	map := aMap.
	self html: aHtml.
	
	goals := map navigationGoals.
	goals ifEmpty: [ 
		html div class:'row-fluid' ; style:'margin-top: 30px; margin-left: 30px'; with: [
			 html span style:'font-size: 14px;' ; with: 'Click over something/someone you want to visit'
		].
	] .
	goals ifNotEmpty: [
	html div class:'row-fluid' ; with: [
		html anchor class:'btn btn-large btn-success span3 ', (map moving ifTrue:['disabled'] ifFalse:['']); 
					style:'margin-top: 5px'; url:'#'; 
					onClick: (html jQuery ajax callback: [  : value | 
							map moving ifFalse: [map startGuidance ]
					] value: true value ;  
					script: [ : s | ]); with: (map waitingForNext ifTrue:['I''m ready Let''s go!'] ifFalse: ['Please guide me!']).
		self renderRendereable: goals first isActive: true.
		goals allButFirstDo: [ :p | p renderWith: self  ].
		
	]]
]

{ #category : #'as yet unclassified' }
ROBGoalRenderer >> renderRendereable: aRenderable [

	^ self renderRendereable: aRenderable isActive: false.
]

{ #category : #'as yet unclassified' }
ROBGoalRenderer >> renderRendereable: aRenderable isActive: aBool [


	html div class: ' robot-goal span3 ', (aBool ifTrue:['active'] ifFalse:['']) ;  with: [ 
		html anchor url:'#';
					onClick: (html jQuery ajax callback: [  : value | map removeGoal: value ] value: aRenderable id ;  script: [ : s | ]);
		 with: [
			html div: [
			html span class:'row-fluid'; with: aRenderable shortName.
			html image	class: 'img-rounded row-fluid';
						style: 'margin-top:5px;';
						url: aRenderable image.]
		]
	]
]
