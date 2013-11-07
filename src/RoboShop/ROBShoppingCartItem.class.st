Class {
	#name : #ROBShoppingCartItem,
	#superclass : #Object,
	#instVars : [
		'product',
		'quantity'
	],
	#category : #'RoboShop-Model'
}

{ #category : #'instance creation' }
ROBShoppingCartItem class >> on: product [
	^self new
		product: product;
		yourself
]

{ #category : #comparing }
ROBShoppingCartItem >> <= aShopppingCartItem [
	^self product label <= aShopppingCartItem product label
]

{ #category : #quantity }
ROBShoppingCartItem >> decrementQuantity [
	quantity := self quantity - 1.
	self quantity = 0 ifTrue: [ self error: 'this shopping item should be removed' ].
]

{ #category : #quantity }
ROBShoppingCartItem >> incrementQuantity [
	quantity := self quantity + 1
]

{ #category : #'initialize-release' }
ROBShoppingCartItem >> initialize [
	super initialize.
	quantity := 1
]

{ #category : #accessing }
ROBShoppingCartItem >> price [
	^(self product price * self quantity) round: 2
]

{ #category : #accessing }
ROBShoppingCartItem >> product [
	^ product
]

{ #category : #accessing }
ROBShoppingCartItem >> product: anObject [
	product := anObject
]

{ #category : #accessing }
ROBShoppingCartItem >> quantity [
	^ quantity
]
