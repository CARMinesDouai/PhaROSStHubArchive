Class {
	#name : #'Std_msgsInt16MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt16MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt16MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt16MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsInt16MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt16MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
