Class {
	#name : #'Gazebo_msgsODEJointProperties',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties class >> rosMd5Sum [ 
^'1b744c32a920af979f53afe2f9c3511f'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties class >> rosTypeDefinition [ 
^' float64[] damping
 float64[] hiStop
 float64[] loStop
 float64[] erp
 float64[] cfm
 float64[] stop_erp
 float64[] stop_cfm
 float64[] fudge_factor
 float64[] fmax
 float64[] vel
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties class >> rosTypeName [ 
^'gazebo_msgs/ODEJointProperties'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> cfm [
	^ self getAt: #cfm. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> cfm: aValue [
	^ self at: #cfm put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> damping [
	^ self getAt: #damping. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> damping: aValue [
	^ self at: #damping put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> erp [
	^ self getAt: #erp. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> erp: aValue [
	^ self at: #erp put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> fmax [
	^ self getAt: #fmax. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> fmax: aValue [
	^ self at: #fmax put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> fudge_factor [
	^ self getAt: #fudge_factor. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> fudge_factor: aValue [
	^ self at: #fudge_factor put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> hiStop [
	^ self getAt: #hiStop. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> hiStop: aValue [
	^ self at: #hiStop put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> initialize [
	super initialize.
	 self damping: OrderedCollection new . 
	 self hiStop: OrderedCollection new . 
	 self loStop: OrderedCollection new . 
	 self erp: OrderedCollection new . 
	 self cfm: OrderedCollection new . 
	 self stop_erp: OrderedCollection new . 
	 self stop_cfm: OrderedCollection new . 
	 self fudge_factor: OrderedCollection new . 
	 self fmax: OrderedCollection new . 
	 self vel: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> loStop [
	^ self getAt: #loStop. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> loStop: aValue [
	^ self at: #loStop put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> stop_cfm [
	^ self getAt: #stop_cfm. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> stop_cfm: aValue [
	^ self at: #stop_cfm put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> stop_erp [
	^ self getAt: #stop_erp. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> stop_erp: aValue [
	^ self at: #stop_erp put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> vel [
	^ self getAt: #vel. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEJointProperties >> vel: aValue [
	^ self at: #vel put: aValue. 

]
