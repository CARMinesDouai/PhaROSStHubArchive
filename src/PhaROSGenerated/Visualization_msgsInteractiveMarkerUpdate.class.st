Class {
	#name : #'Visualization_msgsInteractiveMarkerUpdate',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate class >> keep_alive [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate class >> update [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> erases [
	^ self getAt: #erases. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> erases: aValue [
	^ self at: #erases put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> initialize [
	super initialize.
	 self server_id: ''. 
	 self seq_num: 0. 
	 self type: 0. 
	 self markers: OrderedCollection new . 
	 self poses: OrderedCollection new . 
	 self erases: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> markers [
	^ self getAt: #markers. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> markers: aValue [
	^ self at: #markers put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> poses [
	^ self getAt: #poses. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> poses: aValue [
	^ self at: #poses put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> seq_num [
	^ self getAt: #seq_num. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> seq_num: aValue [
	^ self at: #seq_num put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> server_id [
	^ self getAt: #server_id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> server_id: aValue [
	^ self at: #server_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerUpdate >> type: aValue [
	^ self at: #type put: aValue. 

]
