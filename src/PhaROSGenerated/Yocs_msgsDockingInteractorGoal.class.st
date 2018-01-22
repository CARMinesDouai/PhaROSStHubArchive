Class {
	#name : #'Yocs_msgsDockingInteractorGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> call_autodock [
	^50

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> goto_dock_front [
	^40

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> register_dock_in_global_frame [
	^20

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> return_to_dock [
	^30

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> rosTypeDefinition [ 
^' int8 WAKE_UP=10
 int8 REGISTER_DOCK_IN_GLOBAL_FRAME=20
 int8 RETURN_TO_DOCK=30
 int8 GOTO_DOCK_FRONT=40
 int8 CALL_AUTODOCK=50
 int8 command
 float32 distance
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> rosTypeName [ 
^'yocs_msgs/DockingInteractorGoal'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal class >> wake_up [
	^10

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal >> command [
	^ self getAt: #command. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal >> command: aValue [
	^ self at: #command put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorGoal >> initialize [
	super initialize.
	 self command: 0. 
	 self distance: 0.0. 

]
