Class {
	#name : #'Pcl_msgsPointIndices',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> indices [
	^ self getAt: #indices. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> indices: aValue [
	^ self at: #indices put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self indices: OrderedCollection new . 

]
