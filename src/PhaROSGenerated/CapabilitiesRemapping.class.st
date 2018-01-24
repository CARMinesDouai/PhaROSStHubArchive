Class {
	#name : #CapabilitiesRemapping,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
CapabilitiesRemapping class >> rosMd5Sum [ 
^'cf57fdc6617a881a88c16e768132149c'
]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping class >> rosTypeDefinition [ 
^' string key
 string value
'
]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping class >> rosTypeName [ 
^'capabilities/Remapping'
]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping >> initialize [
	super initialize.
	 self key: ''. 
	 self value: ''. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping >> key [
	^ self getAt: #key. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping >> key: aValue [
	^ self at: #key put: aValue. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
CapabilitiesRemapping >> value: aValue [
	^ self at: #value put: aValue. 

]
