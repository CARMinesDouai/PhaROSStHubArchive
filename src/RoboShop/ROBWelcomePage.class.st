Class {
	#name : #ROBWelcomePage,
	#superclass : #ROBPage,
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBWelcomePage >> renderContentOn: html [
	
	html div 	
		class: 'container';
		with: [  
			
			html div 	
		class: 'hero-unit';
		with: [  
			html
				heading: 'Hello, World!';
				paragraph: 'I am a robot assistant to ease product picking in a shopping mall. '.
		html anchor
		class: 'btn btn-large btn-primary';
		type: 'button';
      	callback: [ self answer ];
      	with: 'Show me a demo »'.
	] ]
]
