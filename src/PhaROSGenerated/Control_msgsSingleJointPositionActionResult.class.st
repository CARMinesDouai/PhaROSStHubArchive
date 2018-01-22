Class {
	#name : #'Control_msgsSingleJointPositionActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Control_msgsSingleJointPositionResult new. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
