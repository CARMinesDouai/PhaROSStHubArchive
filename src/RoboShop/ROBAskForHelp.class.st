Class {
	#name : #ROBAskForHelp,
	#superclass : #ROBPage,
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBAskForHelp >> renderContentOn: html [ 
	
	
	html div 	
		class: 'container middlebig';
		with: [
			html div class: 'hero-unit';
			 with: [   
				html heading: 'Error'.
				html paragraph: '   We still having problems to reach the goal. Maybe there is some hardware problem. Please contact the person in charge '.
			
				html anchor 
					class: 'btn btn-large btn-primary';
					callback: [  self answer ];
					script: (html jQuery this button);
					with: [ html text: 'Done' ]
		]]
	
]
