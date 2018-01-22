Class {
	#name : #'Std_msgsByteMultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
