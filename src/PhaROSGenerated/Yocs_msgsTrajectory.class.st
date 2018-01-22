Class {
	#name : #'Yocs_msgsTrajectory',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self name: ''. 
	 self waypoints: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> waypoints [
	^ self getAt: #waypoints. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> waypoints: aValue [
	^ self at: #waypoints put: aValue. 

]
