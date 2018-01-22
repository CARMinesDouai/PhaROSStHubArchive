Class {
	#name : #'Kobuki_msgsSensorState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> adapter_charged [
	^18

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> adapter_charging [
	^22

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> bumper_centre [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> bumper_left [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> bumper_right [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> button0 [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> button1 [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> button2 [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> cliff_centre [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> cliff_left [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> cliff_right [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> db25_test_board_connected [
	^64

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> digital_input0 [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> digital_input1 [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> digital_input2 [
	^4

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> digital_input3 [
	^8

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> discharging [
	^0

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> docking_charged [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> docking_charging [
	^6

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> over_current_both_wheels [
	^3

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> over_current_left_wheel [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> over_current_right_wheel [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> wheel_drop_left [
	^2

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState class >> wheel_drop_right [
	^1

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> analog_input [
	^ self getAt: #analog_input. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> analog_input: aValue [
	^ self at: #analog_input put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> battery [
	^ self getAt: #battery. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> battery: aValue [
	^ self at: #battery put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> bottom [
	^ self getAt: #bottom. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> bottom: aValue [
	^ self at: #bottom put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> bumper [
	^ self getAt: #bumper. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> bumper: aValue [
	^ self at: #bumper put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> buttons [
	^ self getAt: #buttons. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> buttons: aValue [
	^ self at: #buttons put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> charger [
	^ self getAt: #charger. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> charger: aValue [
	^ self at: #charger put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> cliff [
	^ self getAt: #cliff. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> cliff: aValue [
	^ self at: #cliff put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> current [
	^ self getAt: #current. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> current: aValue [
	^ self at: #current put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> digital_input [
	^ self getAt: #digital_input. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> digital_input: aValue [
	^ self at: #digital_input put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self time_stamp: 0. 
	 self bumper: 0. 
	 self wheel_drop: 0. 
	 self cliff: 0. 
	 self left_encoder: 0. 
	 self right_encoder: 0. 
	 self left_pwm: 0. 
	 self right_pwm: 0. 
	 self buttons: 0. 
	 self charger: 0. 
	 self battery: 0. 
	 self bottom: OrderedCollection new . 
	 self current: OrderedCollection new . 
	 self over_current: 0. 
	 self digital_input: 0. 
	 self analog_input: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> left_encoder [
	^ self getAt: #left_encoder. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> left_encoder: aValue [
	^ self at: #left_encoder put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> left_pwm [
	^ self getAt: #left_pwm. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> left_pwm: aValue [
	^ self at: #left_pwm put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> over_current [
	^ self getAt: #over_current. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> over_current: aValue [
	^ self at: #over_current put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> right_encoder [
	^ self getAt: #right_encoder. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> right_encoder: aValue [
	^ self at: #right_encoder put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> right_pwm [
	^ self getAt: #right_pwm. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> right_pwm: aValue [
	^ self at: #right_pwm put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> time_stamp [
	^ self getAt: #time_stamp. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> time_stamp: aValue [
	^ self at: #time_stamp put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> wheel_drop [
	^ self getAt: #wheel_drop. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsSensorState >> wheel_drop: aValue [
	^ self at: #wheel_drop put: aValue. 

]
