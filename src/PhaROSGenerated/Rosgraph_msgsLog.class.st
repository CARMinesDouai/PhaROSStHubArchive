Class {
	#name : #'Rosgraph_msgsLog',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> debug [
	^1

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> error [
	^8

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> fatal [
	^16

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> info [
	^2

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> rosMd5Sum [ 
^'acffd30cd6b6de30f120938c17c593fb'
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> rosTypeDefinition [ 
^' int8 DEBUG=1
 int8 INFO=2
 int8 WARN=4
 int8 ERROR=8
 int8 FATAL=16
 std_msgs/Header header
 int8 level
 string name
 string msg
 string file
 string function
 int32 line
 string[] topics
'
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> rosTypeName [ 
^'rosgraph_msgs/Log'
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog class >> warn [
	^4

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> file [
	^ self getAt: #file. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> file: aValue [
	^ self at: #file put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> function [
	^ self getAt: #function. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> function: aValue [
	^ self at: #function put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self level: 0. 
	 self name: ''. 
	 self msg: ''. 
	 self file: ''. 
	 self function: ''. 
	 self line: 0. 
	 self topics: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> level [
	^ self getAt: #level. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> level: aValue [
	^ self at: #level put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> line [
	^ self getAt: #line. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> line: aValue [
	^ self at: #line put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> msg [
	^ self getAt: #msg. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> msg: aValue [
	^ self at: #msg put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> topics [
	^ self getAt: #topics. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsLog >> topics: aValue [
	^ self at: #topics put: aValue. 

]
