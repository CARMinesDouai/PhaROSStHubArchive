Class {
	#name : #'Std_msgsMultiArrayDimension',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> initialize [
	super initialize.
	 self label: ''. 
	 self size: 0. 
	 self stride: 0. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> label [
	^ self getAt: #label. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> label: aValue [
	^ self at: #label put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> size [
	^ self getAt: #size. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> size: aValue [
	^ self at: #size put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> stride [
	^ self getAt: #stride. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayDimension >> stride: aValue [
	^ self at: #stride put: aValue. 

]
