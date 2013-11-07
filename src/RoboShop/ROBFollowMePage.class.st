Class {
	#name : #ROBFollowMePage,
	#superclass : #ROBPage,
	#instVars : [
		'stargazerId',
		'refreshCounter'
	],
	#category : #RoboShop
}

{ #category : #'instance creation' }
ROBFollowMePage class >> toStargazerId: id [
	^self new 
		stargazerId: id;
		yourself
]

{ #category : #initialization }
ROBFollowMePage >> initialize [ 
	super initialize.
	refreshCounter := 0.

]

{ #category : #rendering }
ROBFollowMePage >> renderContentOn: html [

	
	html div 	
		class: 'container';	
		with: [  
			html div
				class: 'hero-unit';
				with: [ 
			
					html heading: 'Follow Me';
						paragraph: 'going to id ', self stargazerId asString.
					self renderStop: html.
					self renderCurrentRobotPositionOn: html
					
		]]


]

{ #category : #rendering }
ROBFollowMePage >> renderCurrentRobotPositionOn: html [

	html div 
		script: (html jQuery this load html: [ :r | 
					refreshCounter := refreshCounter + 1.
					self renderCurrentRobotPositionOn: r
				];
				interval: 4 seconds;
				onComplete: (html javascript callback: [ 
					(self robotProxy isRobotArrived or:[ self robotProxy hasError ]) ifTrue: [ 
						self answer ] ])
				);
		with: [ 				
			"html anchor
				script: (html jQuery this button);
				callback: [ self answer ];
				with: 'We are arrived!'."
			
			"refreshCounter > 0 ifTrue: [ 				
				html paragraph: refreshCounter asString, ' x refresh but still not arrived' 
			 ]"
	 	]
 
]

{ #category : #accessing }
ROBFollowMePage >> stargazerId [
	^ stargazerId
]

{ #category : #accessing }
ROBFollowMePage >> stargazerId: anObject [
	stargazerId := anObject
]
