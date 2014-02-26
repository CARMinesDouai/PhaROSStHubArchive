"
# Abstract element
	
	{ class_name } is an abstract representation of a tree member. It allows to set properties and also defines the base xml output.
	
	## { methods_title }
		{ method_documentation }
	## { subclassing_title }
		{ subclassing_documentation }
	## { bug_enh_title }
		1- It should use an XML writer instead of define an string output
		2- The output should come out with a visitor and not interating the tree.
"
Class {
	#name : #PhaROSAbstractElement,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'PhaROS-Launch'
}

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> at: aPropertyName put: aValue [ 
	"=
		 
		# {arguments_title}
			-  aPropertyName : String
			-  aValue : Object
		
		# {sinopsis_title}
			Set the given value to the property named as aPropertyName.
		
	="
	self properties at: aPropertyName put: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> at: aPropertyName put: aValue checking: aBlock [
	"=
		 
		# {arguments_title}
			-  aPropertyName : String
			-  aValue : Object
			-  aBlock : { (PropertyName, Value, Element) -> Boolean }
		# {sinopsis_title}
			Set the given value to the property named as aPropertyName if the given block results in true.
		
	="
	self assert: (aBlock cull: aValue cull: aPropertyName cull: self ).
	self at: aPropertyName put: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> at: aPropertyName put: aValue ofType: aType [
	"=
		 
		# {arguments_title}
			-  aPropertyName : String
			-  aValue : Object
			-  aType : Class
		# {sinopsis_title}
			Set the given value to the property named as aPropertyName if the value is of the given type .
		
	="

	^ self at: aPropertyName put: aValue checking: [: val | val isKindOf: aType].
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> initialize [ 
	properties := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> nodeName [
	self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> properties [ 
	^ properties
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xml [
	"=
		# { sinopsis_title }
			Returns the String-XML representation of the element. 
	="
	^ self xmlHeader,self xmlBody,  self xmlTail.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xmlBody [ 
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xmlHeader [
	^( properties keys inject:( '<{1} ' format: {self nodeName} ) into: [ :acc :prop | acc,  prop asString, '="', (properties at: prop) asString, '" ' ]), '>', String crlf.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xmlTail [
	^  ('</{1}>' format: {self nodeName}), String crlf.
]
