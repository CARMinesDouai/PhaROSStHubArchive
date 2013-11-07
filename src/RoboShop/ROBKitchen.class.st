Class {
	#name : #ROBKitchen,
	#superclass : #ROBLabElement,
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBKitchen >> image [
	^ ROBFileLibrary / #KitchenPng
]

{ #category : #'as yet unclassified' }
ROBKitchen >> isFacility [ 
	^true 
]

{ #category : #'as yet unclassified' }
ROBKitchen >> name [
	^ 'Kitchen'
]

{ #category : #'as yet unclassified' }
ROBKitchen >> renderWith: aRenderer [
	aRenderer renderKitchen: self.
]
