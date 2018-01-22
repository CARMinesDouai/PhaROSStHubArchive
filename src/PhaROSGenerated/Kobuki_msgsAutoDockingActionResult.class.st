Class {
	#name : #'Kobuki_msgsAutoDockingActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Kobuki_msgsAutoDockingResult new. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
