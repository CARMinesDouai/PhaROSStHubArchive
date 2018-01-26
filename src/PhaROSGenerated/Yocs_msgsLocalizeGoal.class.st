Class {
	#name : #'Yocs_msgsLocalizeGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> rosMd5Sum [ 
^'6383995712d8736902464bbea6b0fb6d'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> rosTypeDefinition [ 
^' int8 STAND_AND_LOCALIZE=10
 int8 SPIN_AND_LOCALIZE=20
 int8 command
 float32 distortion
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> rosTypeName [ 
^'yocs_msgs/LocalizeGoal'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> spin_and_localize [
	^20

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> stand_and_localize [
	^10

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> typeCreationOrder [ 
^435
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal >> command [
	^ self getAt: #command. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal >> command: aValue [
	^ self at: #command put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal >> distortion [
	^ self getAt: #distortion. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal >> distortion: aValue [
	^ self at: #distortion put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal >> initialize [
	super initialize.
	 self command: 0. 
	 self distortion: 0.0. 

]
