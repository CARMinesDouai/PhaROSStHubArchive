Class {
	#name : #PRDNode,
	#superclass : #Object,
	#instVars : [
		'pingable',
		'rosName',
		'services'
	],
	#category : #'PhaROSDashBoard-model'
}

{ #category : #'as yet unclassified' }
PRDNode >> initialize [

	rosName:= ''.
	pingable := false.
	services := Set new.
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

{ #category : #accessing }
PRDNode >> services [

	^ services
]
