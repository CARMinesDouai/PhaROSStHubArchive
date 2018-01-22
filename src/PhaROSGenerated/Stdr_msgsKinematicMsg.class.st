Class {
	#name : #'Stdr_msgsKinematicMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg class >> rosTypeDefinition [ 
^' string type
 float32 a_ux_ux
 float32 a_ux_uy
 float32 a_ux_w
 float32 a_uy_ux
 float32 a_uy_uy
 float32 a_uy_w
 float32 a_w_ux
 float32 a_w_uy
 float32 a_w_w
 float32 a_g_ux
 float32 a_g_uy
 float32 a_g_w
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg class >> rosTypeName [ 
^'stdr_msgs/KinematicMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_g_ux [
	^ self getAt: #a_g_ux. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_g_ux: aValue [
	^ self at: #a_g_ux put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_g_uy [
	^ self getAt: #a_g_uy. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_g_uy: aValue [
	^ self at: #a_g_uy put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_g_w [
	^ self getAt: #a_g_w. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_g_w: aValue [
	^ self at: #a_g_w put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_ux_ux [
	^ self getAt: #a_ux_ux. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_ux_ux: aValue [
	^ self at: #a_ux_ux put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_ux_uy [
	^ self getAt: #a_ux_uy. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_ux_uy: aValue [
	^ self at: #a_ux_uy put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_ux_w [
	^ self getAt: #a_ux_w. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_ux_w: aValue [
	^ self at: #a_ux_w put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_uy_ux [
	^ self getAt: #a_uy_ux. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_uy_ux: aValue [
	^ self at: #a_uy_ux put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_uy_uy [
	^ self getAt: #a_uy_uy. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_uy_uy: aValue [
	^ self at: #a_uy_uy put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_uy_w [
	^ self getAt: #a_uy_w. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_uy_w: aValue [
	^ self at: #a_uy_w put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_w_ux [
	^ self getAt: #a_w_ux. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_w_ux: aValue [
	^ self at: #a_w_ux put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_w_uy [
	^ self getAt: #a_w_uy. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_w_uy: aValue [
	^ self at: #a_w_uy put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_w_w [
	^ self getAt: #a_w_w. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> a_w_w: aValue [
	^ self at: #a_w_w put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> initialize [
	super initialize.
	 self type: ''. 
	 self a_ux_ux: 0.0. 
	 self a_ux_uy: 0.0. 
	 self a_ux_w: 0.0. 
	 self a_uy_ux: 0.0. 
	 self a_uy_uy: 0.0. 
	 self a_uy_w: 0.0. 
	 self a_w_ux: 0.0. 
	 self a_w_uy: 0.0. 
	 self a_w_w: 0.0. 
	 self a_g_ux: 0.0. 
	 self a_g_uy: 0.0. 
	 self a_g_w: 0.0. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsKinematicMsg >> type: aValue [
	^ self at: #type put: aValue. 

]
