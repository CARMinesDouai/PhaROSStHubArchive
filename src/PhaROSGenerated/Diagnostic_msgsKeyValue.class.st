Class {
	#name : #'Diagnostic_msgsKeyValue',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue class >> rosMd5Sum [ 
^'cf57fdc6617a881a88c16e768132149c'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue class >> rosTypeDefinition [ 
^' string key
 string value
'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue class >> rosTypeName [ 
^'diagnostic_msgs/KeyValue'
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue class >> typeCreationOrder [ 
^105
]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> initialize [
	super initialize.
	 self key: ''. 
	 self value: ''. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> key [
	^ self getAt: #key. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> key: aValue [
	^ self at: #key put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> value: aValue [
	^ self at: #value put: aValue. 

]
