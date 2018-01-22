Class {
	#name : #'Rocon_std_msgsConnectionCacheSpin',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin class >> rosTypeDefinition [ 
^' float32 spin_freq
 float32 spin_timer
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin class >> rosTypeName [ 
^'rocon_std_msgs/ConnectionCacheSpin'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin >> initialize [
	super initialize.
	 self spin_freq: 0.0. 
	 self spin_timer: 0.0. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin >> spin_freq [
	^ self getAt: #spin_freq. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin >> spin_freq: aValue [
	^ self at: #spin_freq put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin >> spin_timer [
	^ self getAt: #spin_timer. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionCacheSpin >> spin_timer: aValue [
	^ self at: #spin_timer put: aValue. 

]
