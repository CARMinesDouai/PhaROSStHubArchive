Class {
	#name : #ROBFetchCartItemPage,
	#superclass : #ROBPage,
	#instVars : [
		'cartItem'
	],
	#category : #RoboShop
}

{ #category : #'instance creation' }
ROBFetchCartItemPage class >> with: aCartItem [
	^self new 
		cartItem: aCartItem ;
		yourself
]

{ #category : #accessing }
ROBFetchCartItemPage >> cartItem [
	^ cartItem
]

{ #category : #accessing }
ROBFetchCartItemPage >> cartItem: anObject [
	cartItem := anObject
]

{ #category : #rendering }
ROBFetchCartItemPage >> renderCartItem: aCartItem on: html [
	html div
		class: 'product';
  		with: [ 
			html span
				class: 'numberOfProducts';
				with: [ 
					html span
				class: 'numberOfProductsQuantity';
				with: [ 
					html
						text: cartItem quantity].	
						html text: ' x ' ].
			html image
				class: 'productImageBig';
				url:  aCartItem product imageURL.
			html span
				class: 'productLabel';
				with: aCartItem product label.
		 ]
]

{ #category : #rendering }
ROBFetchCartItemPage >> renderContentOn: html [

	html div 	
		class: 'container middlebig';
		with: [  
			html div 	
		class: 'hero-unit';
		with: [  
			html heading: 'Get'.
	
			self renderCartItem: self cartItem on: html.
	
			html anchor
				class: 'btn btn-large btn-primary';
				callback: [ self answer ];
				script: (html jQuery this button);
				with: 'Ok Done!'.
			self renderStop: html.
		]
	
		]
]
