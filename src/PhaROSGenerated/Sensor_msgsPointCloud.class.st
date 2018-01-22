Class {
	#name : #'Sensor_msgsPointCloud',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> channels [
	^ self getAt: #channels. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> channels: aValue [
	^ self at: #channels put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self points: OrderedCollection new . 
	 self channels: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud >> points: aValue [
	^ self at: #points put: aValue. 

]
