Extension { #name : #Object }

{ #category : #'*rST' }
Object >> environment [
	^ self class environment
]

{ #category : #'*rST' }
Object >> isKindOfClassNamed: aClassName [
	| aClass |
	aClass := self environment at: aClassName ifAbsent: [^false].
	^ self isKindOf: aClass
]

{ #category : #'*rST' }
Object >> isReachable [
	^ true
]

{ #category : #'*rST' }
Object >> remoteType [
	"answer the prefered way to go to other squeak (#reference or #copy)"
	
	^ #reference
]
