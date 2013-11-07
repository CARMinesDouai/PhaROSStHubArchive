Class {
	#name : #ROBCheckouPage,
	#superclass : #ROBPage,
	#instVars : [
		'cart'
	],
	#category : #RoboShop
}

{ #category : #'instance creation' }
ROBCheckouPage class >> forCart: aCart [
	^self new
		cart: aCart;
		yourself
]

{ #category : #accessing }
ROBCheckouPage >> cart [
	^ cart
]

{ #category : #accessing }
ROBCheckouPage >> cart: anObject [
	cart := anObject
]

{ #category : #rendering }
ROBCheckouPage >> renderContentOn: html [ 
	
	
	html div 	
		class: 'container middlebig';
		with: [
			html div class: 'hero-unit';
			 with: [   
				html heading: 'Thanks for your visit!'.
				html paragraph: '     and we hope that you enjoyed this demo.'.
			
				html anchor 
					class: 'btn btn-large btn-primary';
					callback: [  self answer ];
					script: (html jQuery this button);
					with: [ html text: 'Bye...' ]
		]]
	
]
