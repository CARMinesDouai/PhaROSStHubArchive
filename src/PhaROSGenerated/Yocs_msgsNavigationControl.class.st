Class {
	#name : #'Yocs_msgsNavigationControl',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl class >> pause [
	^2

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl class >> rosTypeDefinition [ 
^' int8 STOP=0
 int8 START=1
 int8 PAUSE=2
 int8 control
 string goal_name
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl class >> rosTypeName [ 
^'yocs_msgs/NavigationControl'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl class >> start [
	^1

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl class >> stop [
	^0

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl >> control [
	^ self getAt: #control. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl >> control: aValue [
	^ self at: #control put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl >> goal_name [
	^ self getAt: #goal_name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl >> goal_name: aValue [
	^ self at: #goal_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigationControl >> initialize [
	super initialize.
	 self control: 0. 
	 self goal_name: ''. 

]
