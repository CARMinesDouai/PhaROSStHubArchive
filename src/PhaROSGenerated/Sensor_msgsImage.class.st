Class {
	#name : #'Sensor_msgsImage',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> encoding [
	^ self getAt: #encoding. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> encoding: aValue [
	^ self at: #encoding put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self height: 0. 
	 self width: 0. 
	 self encoding: ''. 
	 self is_bigendian: 0. 
	 self step: 0. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> is_bigendian [
	^ self getAt: #is_bigendian. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> is_bigendian: aValue [
	^ self at: #is_bigendian put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> step [
	^ self getAt: #step. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> step: aValue [
	^ self at: #step put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImage >> width: aValue [
	^ self at: #width put: aValue. 

]
