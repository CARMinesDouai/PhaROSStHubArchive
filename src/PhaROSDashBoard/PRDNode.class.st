Class {
	#name : #PRDNode,
	#superclass : #Object,
	#instVars : [
		'pingable',
		'rosName'
	],
	#category : #'PhaROSDashBoard-model'
}

{ #category : #'as yet unclassified' }
PRDNode >> initialize [

	rosName:= ''.
	pingable := false.
]

{ #category : #accessing }
PRDNode >> pingable [
	^ pingable
]

{ #category : #accessing }
PRDNode >> pingable: anObject [
	pingable := anObject
]

{ #category : #accessing }
PRDNode >> rosName [
	^ rosName
]

{ #category : #accessing }
PRDNode >> rosName: anObject [
	rosName := anObject
]
