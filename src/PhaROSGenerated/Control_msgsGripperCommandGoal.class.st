Class {
	#name : #'Control_msgsGripperCommandGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandGoal >> command [
	^ self getAt: #command. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandGoal >> command: aValue [
	^ self at: #command put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandGoal >> initialize [
	super initialize.
	 self command: Control_msgsGripperCommand new. 

]
