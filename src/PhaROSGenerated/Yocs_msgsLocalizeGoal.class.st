Class {
	#name : #'Yocs_msgsLocalizeGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> spin_and_localize [
	^20

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeGoal class >> stand_and_localize [
	^10

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
