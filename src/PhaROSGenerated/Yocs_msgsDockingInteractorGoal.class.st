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
