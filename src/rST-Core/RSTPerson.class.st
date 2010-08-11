Class {
	#name : #RSTPerson,
	#superclass : #RSTModel,
	#instVars : [
		'name',
		'eMail'
	],
	#category : #'rST-Samples'
}

{ #category : #'instance creation' }
RSTPerson class >> name: nameString eMail: eMailString [ 
	^ self new initializeName: nameString eMail: eMailString 
]

{ #category : #accessing }
RSTPerson >> eMail [
	^eMail
]

{ #category : #accessing }
RSTPerson >> eMail: aString [ 
	
			eMail := aString.
			self changed: #eMail
]

{ #category : #initialization }
RSTPerson >> initializeName: nameString eMail: eMailString [
	name := nameString.
	eMail := eMailString
]

{ #category : #accessing }
RSTPerson >> name [
	^ name
]

{ #category : #accessing }
RSTPerson >> name: aString [ 
	
			name := aString.
			self changed: #name
]

{ #category : #printing }
RSTPerson >> printOn: aStream [ 
	super printOn: aStream.
	aStream nextPutAll: ' name:';
		 nextPutAll: name asString;
		 nextPutAll: ' eMail:';
		 nextPutAll: eMail asString
]
