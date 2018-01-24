Class {
	#name : #'Yocs_msgsARPair',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsARPair class >> rosMd5Sum [ 
^'9a0e51fbcb2eab37a945707af8ee9a6b'
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair class >> rosTypeDefinition [ 
^' int16 left_id
 int16 right_id
 float32 baseline
 float32 target_offset
 string target_frame
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair class >> rosTypeName [ 
^'yocs_msgs/ARPair'
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> baseline [
	^ self getAt: #baseline. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> baseline: aValue [
	^ self at: #baseline put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> initialize [
	super initialize.
	 self left_id: 0. 
	 self right_id: 0. 
	 self baseline: 0.0. 
	 self target_offset: 0.0. 
	 self target_frame: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> left_id [
	^ self getAt: #left_id. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> left_id: aValue [
	^ self at: #left_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> right_id [
	^ self getAt: #right_id. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> right_id: aValue [
	^ self at: #right_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> target_frame [
	^ self getAt: #target_frame. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> target_frame: aValue [
	^ self at: #target_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> target_offset [
	^ self getAt: #target_offset. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPair >> target_offset: aValue [
	^ self at: #target_offset put: aValue. 

]
