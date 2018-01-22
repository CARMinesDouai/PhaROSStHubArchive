Class {
	#name : #'Visualization_msgsMenuEntry',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry class >> feedback [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry class >> rosTypeDefinition [ 
^' int8 FEEDBACK=0
 int8 ROSRUN=1
 int8 ROSLAUNCH=2
 int32 id
 int32 parent_id
 string title
 string command
 int8 command_type
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry class >> rosTypeName [ 
^'visualization_msgs/MenuEntry'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry class >> roslaunch [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry class >> rosrun [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> command [
	^ self getAt: #command. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> command: aValue [
	^ self at: #command put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> command_type [
	^ self getAt: #command_type. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> command_type: aValue [
	^ self at: #command_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> initialize [
	super initialize.
	 self id: 0. 
	 self parent_id: 0. 
	 self title: ''. 
	 self command: ''. 
	 self command_type: 0. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> parent_id [
	^ self getAt: #parent_id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> parent_id: aValue [
	^ self at: #parent_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> title [
	^ self getAt: #title. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMenuEntry >> title: aValue [
	^ self at: #title put: aValue. 

]
