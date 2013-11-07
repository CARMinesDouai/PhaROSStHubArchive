Class {
	#name : #ROBRobotBusyPage,
	#superclass : #ROBPage,
	#category : #RoboShop
}

{ #category : #rendering }
ROBRobotBusyPage >> renderContentOn: html [

	
	html div 	
		class: 'middlebig';	
		with: [  
			html 
				heading: 'Sorry, DAN is already busy with someone else. Retry later...'.
			html anchor	
				script: (html jQuery this button);
				callback: [ self answer ];
				with: 'Bye' 
		].


]
