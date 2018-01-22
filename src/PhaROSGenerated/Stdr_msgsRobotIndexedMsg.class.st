Class {
	#name : #'Stdr_msgsRobotIndexedMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> initialize [
	super initialize.
	 self name: ''. 
	 self robot: Stdr_msgsRobotMsg new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> robot [
	^ self getAt: #robot. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> robot: aValue [
	^ self at: #robot put: aValue. 

]
