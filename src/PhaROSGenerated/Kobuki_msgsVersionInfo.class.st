Class {
	#name : #'Kobuki_msgsVersionInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo class >> gyroscope_3d_data [
	^0000000000000002

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo class >> smooth_move_start [
	^0000000000000001

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> features [
	^ self getAt: #features. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> features: aValue [
	^ self at: #features put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> firmware [
	^ self getAt: #firmware. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> firmware: aValue [
	^ self at: #firmware put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> hardware [
	^ self getAt: #hardware. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> hardware: aValue [
	^ self at: #hardware put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> initialize [
	super initialize.
	 self hardware: ''. 
	 self firmware: ''. 
	 self software: ''. 
	 self udid: OrderedCollection new . 
	 self features: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> software [
	^ self getAt: #software. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> software: aValue [
	^ self at: #software put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> udid [
	^ self getAt: #udid. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsVersionInfo >> udid: aValue [
	^ self at: #udid put: aValue. 

]
