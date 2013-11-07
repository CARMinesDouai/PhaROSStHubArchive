Class {
	#name : #ROBWelcomePage,
	#superclass : #ROBPage,
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBWelcomePage >> renderContentOn: html [
	
	| map |
	map := ROBLabMap map526909358: ROBApp robotProxyClass new.
	html div class: 'container-fluid' ; with: [
			html break.
			html div class: 'row-fuild'; with: [  
				
					html label for: (html nextId); with: ' '.
					html textInput id: html lastId; script: 
							(html jQuery this autocomplete 
								search: [ :term| map matchesFor: term   ] 
								callback: [:term : ob | map navigatesToBestMatcher: term. ]).
								
								
				
			].
			(ROBElementRenderer for: html) renderMap: map .
	]
	
	"
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
	] ]"
]
