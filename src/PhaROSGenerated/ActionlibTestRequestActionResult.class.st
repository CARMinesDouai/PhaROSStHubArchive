Class {
	#name : #ActionlibTestRequestActionResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: ActionlibTestRequestResult new. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
