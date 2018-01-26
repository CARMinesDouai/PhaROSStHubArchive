Class {
	#name : #'Rocon_std_msgsRemapping',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping class >> rosMd5Sum [ 
^'26f16c667d483280bc5d040bf2c0cd8d'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping class >> rosTypeDefinition [ 
^' string remap_from
 string remap_to
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping class >> rosTypeName [ 
^'rocon_std_msgs/Remapping'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping class >> typeCreationOrder [ 
^224
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping >> initialize [
	super initialize.
	 self remap_from: ''. 
	 self remap_to: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping >> remap_from [
	^ self getAt: #remap_from. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping >> remap_from: aValue [
	^ self at: #remap_from put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping >> remap_to [
	^ self getAt: #remap_to. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsRemapping >> remap_to: aValue [
	^ self at: #remap_to put: aValue. 

]
