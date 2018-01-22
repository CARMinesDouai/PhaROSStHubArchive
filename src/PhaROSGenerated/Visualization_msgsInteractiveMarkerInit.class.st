Class {
	#name : #'Visualization_msgsInteractiveMarkerInit',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> initialize [
	super initialize.
	 self server_id: ''. 
	 self seq_num: 0. 
	 self markers: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> markers [
	^ self getAt: #markers. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> markers: aValue [
	^ self at: #markers put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> seq_num [
	^ self getAt: #seq_num. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> seq_num: aValue [
	^ self at: #seq_num put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> server_id [
	^ self getAt: #server_id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerInit >> server_id: aValue [
	^ self at: #server_id put: aValue. 

]
