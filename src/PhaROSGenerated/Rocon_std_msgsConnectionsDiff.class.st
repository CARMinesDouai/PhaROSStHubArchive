Class {
	#name : #'Rocon_std_msgsConnectionsDiff',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff class >> rosMd5Sum [ 
^'19f9e3bef1153b4bc619ec3d21b94718'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff class >> rosTypeDefinition [ 
^' rocon_std_msgs/Connection[] added
 rocon_std_msgs/Connection[] lost
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff class >> rosTypeName [ 
^'rocon_std_msgs/ConnectionsDiff'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff class >> typeCreationOrder [ 
^241
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> added [
	^ self getAt: #added. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> added: aValue [
	^ self at: #added put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> initialize [
	super initialize.
	 self added: OrderedCollection new . 
	 self lost: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> lost [
	^ self getAt: #lost. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsDiff >> lost: aValue [
	^ self at: #lost put: aValue. 

]
