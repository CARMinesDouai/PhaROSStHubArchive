Class {
	#name : #'Move_base_msgsMoveBaseFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseFeedback class >> rosMd5Sum [ 
^'3fb824c456a757373a226f6d08071bf0'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseFeedback class >> rosTypeDefinition [ 
^' geometry_msgs/PoseStamped base_position
'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseFeedback class >> rosTypeName [ 
^'move_base_msgs/MoveBaseFeedback'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseFeedback >> base_position [
	^ self getAt: #base_position. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseFeedback >> base_position: aValue [
	^ self at: #base_position put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseFeedback >> initialize [
	super initialize.
	 self base_position: Geometry_msgsPoseStamped new. 

]
