"
This is an abstract class / interface for collections that allow fast 'nearest neighbor' queries. This class only supports a subset of the normal collection interface to make it easier and quicker to write an implementation.


Public API and Key Messages

- add: <point-like object>
	similar to normal collections, but the object is expected to be derived from the Point class
	
- addAll: <collection of point-like objects>
	same as for normal collections. the provided collection only needs to support #do
	
- do: <block>
	similar to normal collections. each element is passed only once, but there are no rules about the order they  are passed.
	
- findNearest: <point-like object>
	returns the object in the collection with the shortest distance to the provided object
	


"
Class {
	#name : #VMNNCollection,
	#superclass : #Object,
	#category : #'VectorMaps-SLAM - Data Structures'
}

{ #category : #adding }
VMNNCollection >> add: pointLikeObject [
	^ self subclassResponsibility 
]

{ #category : #adding }
VMNNCollection >> addAll: collection [
	^ self subclassResponsibility 
]

{ #category : #enumerating }
VMNNCollection >> do: aBlock [
	^ self subclassResponsibility 
]

{ #category : #'find nearest neighbor' }
VMNNCollection >> findNearest: pointLikeObject [
	^self subclassResponsibility.
]

{ #category : #accessing }
VMNNCollection >> root [
	"returns the root of the tree search structure. required for data structures that can create new root nodes when elements are added"
	^self subclassResponsibility.
]
