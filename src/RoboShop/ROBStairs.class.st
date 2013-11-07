Class {
	#name : #ROBStairs,
	#superclass : #ROBLabElement,
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBStairs >> image [
	 ^ ROBFileLibrary / #StairsPng
]

{ #category : #'as yet unclassified' }
ROBStairs >> isFacility [ 
	^true 
]

{ #category : #'as yet unclassified' }
ROBStairs >> name [
	^ 'Stairs'
]

{ #category : #'as yet unclassified' }
ROBStairs >> renderWith: aRenderer [
	aRenderer renderStair: self.
]
