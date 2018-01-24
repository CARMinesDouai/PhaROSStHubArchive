Class {
	#name : #'Control_msgsJointControllerState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState class >> rosMd5Sum [ 
^'987ad85e4756f3aef7f1e5e7fe0595d1'
]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 set_point
 float64 process_value
 float64 process_value_dot
 float64 error
 float64 time_step
 float64 command
 float64 p
 float64 i
 float64 d
 float64 i_clamp
 bool antiwindup
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState class >> rosTypeName [ 
^'control_msgs/JointControllerState'
]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> antiwindup [
	^ self getAt: #antiwindup. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> antiwindup: aValue [
	^ self at: #antiwindup put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> command [
	^ self getAt: #command. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> command: aValue [
	^ self at: #command put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> d [
	^ self getAt: #d. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> d: aValue [
	^ self at: #d put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> i [
	^ self getAt: #i. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> i: aValue [
	^ self at: #i put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> i_clamp [
	^ self getAt: #i_clamp. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> i_clamp: aValue [
	^ self at: #i_clamp put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self set_point: 0.0. 
	 self process_value: 0.0. 
	 self process_value_dot: 0.0. 
	 self error: 0.0. 
	 self time_step: 0.0. 
	 self command: 0.0. 
	 self p: 0.0. 
	 self i: 0.0. 
	 self d: 0.0. 
	 self i_clamp: 0.0. 
	 self antiwindup: false. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> p [
	^ self getAt: #p. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> p: aValue [
	^ self at: #p put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> process_value [
	^ self getAt: #process_value. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> process_value: aValue [
	^ self at: #process_value put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> process_value_dot [
	^ self getAt: #process_value_dot. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> process_value_dot: aValue [
	^ self at: #process_value_dot put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> set_point [
	^ self getAt: #set_point. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> set_point: aValue [
	^ self at: #set_point put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> time_step [
	^ self getAt: #time_step. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointControllerState >> time_step: aValue [
	^ self at: #time_step put: aValue. 

]
