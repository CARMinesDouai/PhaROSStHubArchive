Class {
	#name : #ROBStairs,
	#superclass : #ROBLabElement,
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBStairs class >> centralStairs [

	^ ROBStairs new
				icon: nil;
				image: nil;
				location: ROBUniquePose point28
]

{ #category : #'as yet unclassified' }
ROBStairs class >> stairBackDoor [
	^ (ROBStairs new
						icon: nil;
						image: nil;
						location: ROBUniquePose point22)
]

{ #category : #'as yet unclassified' }
ROBStairs class >> stairKitchenSide [
	^ (ROBStairs new
						icon: nil;
						image: nil;
						location: ROBUniquePose point38)
]

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
