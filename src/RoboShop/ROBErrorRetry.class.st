Class {
	#name : #ROBErrorRetry,
	#superclass : #ROBPage,
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBErrorRetry >> renderContentOn: html [ 
	
	
	html div 	
		class: 'container middlebig';
		with: [
			html div class: 'hero-unit';
			 with: [   
				html heading: 'Error'.
				html paragraph: '    We are having some problems reaching the next destination. Please wait the people sourrounding the robot go and press retry :) '.
			
				html anchor 
					class: 'btn btn-large btn-primary';
					callback: [  self answer ];
					script: (html jQuery this button);
					with: [ html text: 'Retry' ]
		]]
	
]
