Class {
	#name : #ROBTryLater,
	#superclass : #ROBPage,
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBTryLater >> renderContentOn: html [ 
	
	
	html div 	
		class: 'container middlebig';
		with: [
			html div class: 'hero-unit';
			 with: [   
				html heading: 'Sorry'.
				html paragraph: '   We could not achieve your shopping list. Please try again later. '.
			
				html anchor 
					class: 'btn btn-large btn-primary';
					callback: [  self answer ];
					script: (html jQuery this button);
					with: [ html text: 'Bye...' ]
		]]
	
]
