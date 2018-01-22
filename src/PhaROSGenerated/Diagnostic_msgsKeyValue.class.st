Class {
	#name : #'Diagnostic_msgsKeyValue',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> initialize [
	super initialize.
	 self key: ''. 
	 self value: ''. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> key [
	^ self getAt: #key. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> key: aValue [
	^ self at: #key put: aValue. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Diagnostic_msgsKeyValue >> value: aValue [
	^ self at: #value put: aValue. 

]
