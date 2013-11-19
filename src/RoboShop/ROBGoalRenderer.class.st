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
		html div class:'row-fluid' ; style:'margin-top: 30px; margin-left: 10px'; with: [
			html orderedList style:'font-size: 14px; width: 300px;' ;  with: 
			[ 
				html listItem: 'Browse the interest points by criteria: persons, facilities, etc)'.
				html listItem: 'Click over each of your interests!(There is a limit of 10 points per time)'.
				html listItem: 'Click on let''s Go'. 
			].
			html break.
			html blockquote: [ html paragraph style:'color: #3a87ad;'; with: 'In case of panic, press the red button on top of the robot'.]
				
				
		].
	] .

	goals ifNotEmpty: [
	html div class:'row-fluid' ; with: [
		
		html div class:'span3' ; with: [
			map moving ifFalse: [
				html anchor class:'btn btn-large btn-success  '; 
						style:'margin-top: 5px; height:80px; font-size: 15px'; url:'#'; 
						onClick: (html jQuery ajax callback: [  : value | 
								map moving ifFalse: [map startGuidance ]
						] value: true value ;  
						script: [ : s | ]); with: [ html div style: 'vertical-align: middle; height:80px; padding-top: 20px;' ; with: ('Let''s go!')].
			]ifTrue: [ 
			
				html anchor class:'btn btn-large btn-danger '; 
						style:'margin-top: 5px; height:80px; font-size: 15px'; url:'#'; 
						onClick: (html jQuery ajax callback: [  : value | 
								map removeAllGoals.
								map stop.
								map removeAllGoals.
						] value: true value ;  
						script: [ : s | ]); with: [ html div style: 'vertical-align: middle; height:80px; padding-top: 20px;' ; with: ('STOP!')].
		
			
			 ].
		].
			
		html div class:'span3' ; with:
		[
			html anchor class:'btn btn-large  ', (map moving ifTrue:['disabled'] ifFalse:['']); 
					style:'margin-top: 5px;height:80px; font-size: 15px'; url:'#'; 
					onClick: (html jQuery ajax callback: [  : value | 
							map moving ifFalse: [map removeAllGoals ]
					] value: true value ;  
					script: [ : s | ]);  with: [ html div style: 'vertical-align: middle; height:80px; padding-top: 20px;' ; with: ('Remove goals')].
		].		
		
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


	html div class: ' robot-goal span3 ', (aBool ifTrue:['active'] ifFalse:['waiting']) ;  with: [ 
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
