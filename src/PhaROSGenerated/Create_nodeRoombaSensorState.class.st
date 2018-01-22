Class {
	#name : #'Create_nodeRoombaSensorState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState class >> charging_charging [
	^2

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState class >> charging_charging_error [
	^5

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState class >> charging_charging_recovery [
	^1

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState class >> charging_not_charging [
	^0

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState class >> charging_trickle_charging [
	^3

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState class >> charging_waiting [
	^4

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> angle [
	^ self getAt: #angle. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> angle: aValue [
	^ self at: #angle put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> bumps_wheeldrops [
	^ self getAt: #bumps_wheeldrops. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> bumps_wheeldrops: aValue [
	^ self at: #bumps_wheeldrops put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> buttons [
	^ self getAt: #buttons. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> buttons: aValue [
	^ self at: #buttons put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> capacity [
	^ self getAt: #capacity. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> capacity: aValue [
	^ self at: #capacity put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> charge [
	^ self getAt: #charge. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> charge: aValue [
	^ self at: #charge put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> charging_state [
	^ self getAt: #charging_state. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> charging_state: aValue [
	^ self at: #charging_state put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_front_left [
	^ self getAt: #cliff_front_left. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_front_left: aValue [
	^ self at: #cliff_front_left put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_front_right [
	^ self getAt: #cliff_front_right. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_front_right: aValue [
	^ self at: #cliff_front_right put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_left [
	^ self getAt: #cliff_left. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_left: aValue [
	^ self at: #cliff_left put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_right [
	^ self getAt: #cliff_right. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> cliff_right: aValue [
	^ self at: #cliff_right put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> current [
	^ self getAt: #current. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> current: aValue [
	^ self at: #current put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> dirt_detector_left [
	^ self getAt: #dirt_detector_left. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> dirt_detector_left: aValue [
	^ self at: #dirt_detector_left put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> dirt_detector_right [
	^ self getAt: #dirt_detector_right. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> dirt_detector_right: aValue [
	^ self at: #dirt_detector_right put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self bumps_wheeldrops: 0. 
	 self wall: false. 
	 self cliff_left: false. 
	 self cliff_front_left: false. 
	 self cliff_front_right: false. 
	 self cliff_right: false. 
	 self virtual_wall: false. 
	 self motor_overcurrents: 0. 
	 self dirt_detector_left: 0. 
	 self dirt_detector_right: 0. 
	 self remote_opcode: 0. 
	 self buttons: 0. 
	 self distance: 0. 
	 self angle: 0. 
	 self charging_state: 0. 
	 self voltage: 0. 
	 self current: 0. 
	 self temperature: 0. 
	 self charge: 0. 
	 self capacity: 0. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> motor_overcurrents [
	^ self getAt: #motor_overcurrents. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> motor_overcurrents: aValue [
	^ self at: #motor_overcurrents put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> remote_opcode [
	^ self getAt: #remote_opcode. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> remote_opcode: aValue [
	^ self at: #remote_opcode put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> temperature [
	^ self getAt: #temperature. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> temperature: aValue [
	^ self at: #temperature put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> virtual_wall [
	^ self getAt: #virtual_wall. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> virtual_wall: aValue [
	^ self at: #virtual_wall put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> voltage [
	^ self getAt: #voltage. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> voltage: aValue [
	^ self at: #voltage put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> wall [
	^ self getAt: #wall. 

]

{ #category : #'as yet unclassified' }
Create_nodeRoombaSensorState >> wall: aValue [
	^ self at: #wall put: aValue. 

]
