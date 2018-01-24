Class {
	#name : #'Std_msgsTime',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsTime class >> rosMd5Sum [ 
^'cd7166c74c552c311fbcc2fe5a7bc289'
]

{ #category : #'as yet unclassified' }
Std_msgsTime class >> rosTypeDefinition [ 
^' time data
'
]

{ #category : #'as yet unclassified' }
Std_msgsTime class >> rosTypeName [ 
^'std_msgs/Time'
]

{ #category : #'as yet unclassified' }
Std_msgsTime >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsTime >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsTime >> initialize [
	super initialize.
	 self data:  PhaROSTimestamp now. 

]
