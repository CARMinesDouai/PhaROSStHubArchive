Class {
	#name : #PhaROSROSType,
	#superclass : #Object,
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'as yet unclassified' }
PhaROSROSType class >> definedBy: aROSTypeId named: aName [ 
	 ^ PhaROSFieldDefinition named: aName type: (PhaROSTypeBrowser instance type: aROSTypeId ).
]

{ #category : #'as yet unclassified' }
PhaROSROSType class >> initialize [ 	
	Smalltalk at:#ROSType put: self.
]

{ #category : #'as yet unclassified' }
PhaROSROSType class >> message [
	^ PhaROSMessageTypeBuilder.
]

{ #category : #'as yet unclassified' }
PhaROSROSType class >> service [
	^ PhaROSServiceTypeBuilder 
]
