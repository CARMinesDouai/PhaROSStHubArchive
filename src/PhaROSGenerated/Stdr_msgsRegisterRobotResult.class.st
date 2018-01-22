Class {
	#name : #'Stdr_msgsRegisterRobotResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult >> initialize [
	super initialize.
	 self description: Stdr_msgsRobotMsg new. 

]
