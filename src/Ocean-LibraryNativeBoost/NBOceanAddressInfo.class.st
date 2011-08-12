Class {
	#name : #NBOceanAddressInfo,
	#superclass : #Object,
	#instVars : [
		'family',
		'socketType',
		'protocol',
		'addrLen',
		'addr',
		'canonicalName'
	],
	#category : #'Ocean-LibraryNativeBoost'
}

{ #category : #accessing }
NBOceanAddressInfo >> addr [

	^ addr
]

{ #category : #accessing }
NBOceanAddressInfo >> addr: anObject [

	addr := anObject
]

{ #category : #accessing }
NBOceanAddressInfo >> addrLen [

	^ addrLen
]

{ #category : #accessing }
NBOceanAddressInfo >> addrLen: anObject [

	addrLen := anObject
]

{ #category : #accessing }
NBOceanAddressInfo >> canonicalName [

	^ canonicalName
]

{ #category : #accessing }
NBOceanAddressInfo >> canonicalName: anObject [

	canonicalName := anObject
]

{ #category : #accessing }
NBOceanAddressInfo >> family [

	^ family
]

{ #category : #accessing }
NBOceanAddressInfo >> family: anObject [

	family := anObject
]

{ #category : #printing }
NBOceanAddressInfo >> printOn: aStream [
	aStream nextPutAll: self class name;
		nextPutAll: ' (';
		print: addr;
		nextPutAll: ' )'
]

{ #category : #accessing }
NBOceanAddressInfo >> protocol [

	^ protocol
]

{ #category : #accessing }
NBOceanAddressInfo >> protocol: anObject [

	protocol := anObject
]

{ #category : #accessing }
NBOceanAddressInfo >> socketType [

	^ socketType
]

{ #category : #accessing }
NBOceanAddressInfo >> socketType: anObject [

	socketType := anObject
]
