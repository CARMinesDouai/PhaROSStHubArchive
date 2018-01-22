Class {
	#name : #'Kobuki_msgsControllerInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo class >> default [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo class >> user_configured [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> d_gain [
	^ self getAt: #d_gain. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> d_gain: aValue [
	^ self at: #d_gain put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> i_gain [
	^ self getAt: #i_gain. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> i_gain: aValue [
	^ self at: #i_gain put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> initialize [
	super initialize.
	 self type: 0. 
	 self p_gain: 0.0. 
	 self i_gain: 0.0. 
	 self d_gain: 0.0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> p_gain [
	^ self getAt: #p_gain. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> p_gain: aValue [
	^ self at: #p_gain put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsControllerInfo >> type: aValue [
	^ self at: #type put: aValue. 

]
