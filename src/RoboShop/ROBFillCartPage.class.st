Class {
	#name : #ROBFillCartPage,
	#superclass : #ROBPage,
	#instVars : [
		'shoppingCart'
	],
	#category : #RoboShop
}

{ #category : #actions }
ROBFillCartPage >> addProductInShoppingCart: aProduct [
	
	| shoppingCartItem |
	shoppingCartItem := self shoppingCart 
			detect: [ :cartItem | cartItem product = aProduct ] 
			ifNone: [ ^self shoppingCart add: (ROBShoppingCartItem on: aProduct) ].
	
	shoppingCartItem incrementQuantity 
]

{ #category : #initialization }
ROBFillCartPage >> initialize [
	super initialize.
	shoppingCart := SortedCollection new
]

{ #category : #accessing }
ROBFillCartPage >> products [
	^ROBProduct all
]

{ #category : #rendering }
ROBFillCartPage >> renderContentOn: html [
	
	html div 	
		class: 'container';
		with: [  

	html div 	
		class: 'row';
		with: [  
	
	html div 	
		class: 'span5';
		with: [  
			html heading: 'Product List'.
			self renderProductListOn: html
	].
	html div 	
		class: 'span2';
		with: [  
			self renderHelpOn: html.
	].
	html div 	
		class: 'span5';
		with: [  
			html heading: 'Your Shopping List'.
			self renderShoppingCartOn: html.
			self shoppingCart notEmpty ifTrue: [ 
				self renderShoppingCartTotalAmountOn: html  ].
			self renderFetchProductsButtonOn: html.
	].
	] ]

]

{ #category : #rendering }
ROBFillCartPage >> renderFetchProductsButtonOn: html [
	
	html anchor
		id: 'fetchButton';
		class: 'btn btn-large btn-primary';
		type: 'button';
		script: (html jQuery this button);
      	callback: [ self validateShoppingCart ];
      	with: 'Help me to find these products'.
	

]

{ #category : #rendering }
ROBFillCartPage >> renderHelpOn: html [

	html div 
		class: 'help';
		with: [ html paragraph: 'add products into -->' ]
]

{ #category : #'rendering-products' }
ROBFillCartPage >> renderProduct: product on: html [

	html div
		class: 'product';
		passenger: product;
		script: (html jQuery new draggable revert: true);
  		with: [ 

					html anchor
						class: 'ui-corner-all';
						class: 'ui-state-default';
						script:	(html jQuery new
								hover: (html jQuery new addClass: 'ui-state-hover')
								out: (html jQuery new removeClass: 'ui-state-hover'));
						callback: [ self addProductInShoppingCart: product ];
						with: [
							html span 
								class: 'ui-icon';
								class: 'ui-icon-circle-plus'
						].			
			html image
				class: 'productImage';
				url: product imageURL.
			html span
				class: 'productLabel';
				with: product label.
			html span
				class: 'productPrice';
				with: product price.
		 ]
]

{ #category : #'rendering-shoppingcart' }
ROBFillCartPage >> renderProductInShoppingCart: cartItem on: html [
	| product |
	product := cartItem product.
	html div
		class: 'product';
		with: [ 
					self renderQuantityOfCartItem: cartItem on: html.
					html image
						class: 'productImage';
						url: product imageURL.
					html span
						class: 'productLabel';
						with: product label.
					html span
						class: 'productPrice';
						with: cartItem price ]
]

{ #category : #'rendering-products' }
ROBFillCartPage >> renderProductListOn: html [
	
	html div class: 'products ui-corner-all'; with: [ 
		self products do: [ :product |	
			self renderProduct: product on: html
		]
	]
]

{ #category : #'rendering-shoppingcart' }
ROBFillCartPage >> renderQuantityOfCartItem: cartItem on: html [
	html span
		class: 'quantityModifiers';
		with: [ 
			html anchor
				class: 'ui-corner-all';
				class: 'ui-state-default';
				script:	(html jQuery new
								hover: (html jQuery new addClass: 'ui-state-hover')
								out: (html jQuery new removeClass: 'ui-state-hover'));
				callback: [ cartItem incrementQuantity ];
				with: [
					html span 
						class: 'ui-icon';
						class: 'ui-icon-circle-triangle-n'
				].
						
			html anchor
				class: 'ui-corner-all';
				class: 'ui-state-default';
				callback: [ [ cartItem decrementQuantity ]
							on: Error
							do: [ self shoppingCart remove: cartItem ].
				];
				script: (html jQuery new
							hover: (html jQuery new addClass: 'ui-state-hover')
							out: (html jQuery new removeClass: 'ui-state-hover'));
				with: [
					html span
               				class: 'ui-icon';
               				class: 'ui-icon-circle-triangle-s' 
				].
		].	
		html span
				class: 'numberOfProducts';
			with: [ 
				html
					text: cartItem quantity;
					text: ' x ' ] 
		
		
]

{ #category : #'rendering-shoppingcart' }
ROBFillCartPage >> renderShoppingCartItemsOn: html [
	self shoppingCart do: [ :cartItem |
 		self renderProductInShoppingCart: cartItem on: html
	 ].
 	
]

{ #category : #'rendering-shoppingcart' }
ROBFillCartPage >> renderShoppingCartOn: html [
	
	html div
		class: 'shoppingcart ui-corner-all'; 
		script: (html jQuery new droppable
			onDrop: (html jQuery this load
				callbackDroppable: [ :event | 
					self addProductInShoppingCart: (event at: #draggable) ];
				html: [ :r | self renderShoppingCartItemsOn: r ]));
		with: [ 
			self renderShoppingCartItemsOn: html. 
		].

	

]

{ #category : #'rendering-shoppingcart' }
ROBFillCartPage >> renderShoppingCartTotalAmountOn: html [
	html div
		class: 'shoppingcartSum';
		with: [ 
			html
				span: 'Total : ';
				span: self shoppingCartTotalAmount ]
]

{ #category : #accessing }
ROBFillCartPage >> shoppingCart [
	^shoppingCart
]

{ #category : #accessing }
ROBFillCartPage >> shoppingCartTotalAmount [
	^ (self shoppingCart inject: 0 into: [ :acc :next | acc + (next product price * next quantity) ]) round: 2
]

{ #category : #actions }
ROBFillCartPage >> validateShoppingCart [
	self shoppingCart  isEmpty ifTrue: [  ^self  ].

	self answer: self shoppingCart 
]
