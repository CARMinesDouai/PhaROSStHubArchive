Class {
	#name : #'Rocon_std_msgsKeyValue',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue class >> rosMd5Sum [ 
^'cf57fdc6617a881a88c16e768132149c'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue class >> rosTypeDefinition [ 
^' string key
 string value
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue class >> rosTypeName [ 
^'rocon_std_msgs/KeyValue'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue >> initialize [
	super initialize.
	 self key: ''. 
	 self value: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue >> key [
	^ self getAt: #key. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue >> key: aValue [
	^ self at: #key put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsKeyValue >> value: aValue [
	^ self at: #value put: aValue. 

]
