Class {
	#name : #'Create_nodeRawTurtlebotSensorState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> charging_charging [
	^2

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> charging_charging_error [
	^5

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> charging_charging_recovery [
	^1

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> charging_not_charging [
	^0

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> charging_trickle_charging [
	^3

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> charging_waiting [
	^4

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> oi_mode_full [
	^3

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> oi_mode_off [
	^0

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> oi_mode_passive [
	^1

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> oi_mode_safe [
	^2

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_arc_left [
	^139

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_arc_right [
	^140

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_clean [
	^136

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_drive_stop [
	^141

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_force_field [
	^242

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_forward [
	^130

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_green_buoy [
	^244

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_green_buoy_and_force_field [
	^246

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_large [
	^136

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_left [
	^129

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_max [
	^133

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_medium [
	^135

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_none [
	^255

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_pause [
	^137

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_power [
	^138

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_red_buoy [
	^248

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_red_buoy_and_force_field [
	^250

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_red_buoy_and_green_buoy [
	^252

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_red_buoy_and_green_buoy_and_force_field [
	^254

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_reserved [
	^240

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_right [
	^131

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_seek_dock [
	^143

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_send_all [
	^142

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_small [
	^134

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState class >> remote_spot [
	^132

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> angle [
	^ self getAt: #angle. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> angle: aValue [
	^ self at: #angle put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> bumps_wheeldrops [
	^ self getAt: #bumps_wheeldrops. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> bumps_wheeldrops: aValue [
	^ self at: #bumps_wheeldrops put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> buttons [
	^ self getAt: #buttons. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> buttons: aValue [
	^ self at: #buttons put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> capacity [
	^ self getAt: #capacity. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> capacity: aValue [
	^ self at: #capacity put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> charge [
	^ self getAt: #charge. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> charge: aValue [
	^ self at: #charge put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> charging_sources_available [
	^ self getAt: #charging_sources_available. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> charging_sources_available: aValue [
	^ self at: #charging_sources_available put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> charging_state [
	^ self getAt: #charging_state. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> charging_state: aValue [
	^ self at: #charging_state put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_left [
	^ self getAt: #cliff_front_left. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_left: aValue [
	^ self at: #cliff_front_left put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_left_signal [
	^ self getAt: #cliff_front_left_signal. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_left_signal: aValue [
	^ self at: #cliff_front_left_signal put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_right [
	^ self getAt: #cliff_front_right. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_right: aValue [
	^ self at: #cliff_front_right put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_right_signal [
	^ self getAt: #cliff_front_right_signal. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_front_right_signal: aValue [
	^ self at: #cliff_front_right_signal put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_left [
	^ self getAt: #cliff_left. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_left: aValue [
	^ self at: #cliff_left put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_left_signal [
	^ self getAt: #cliff_left_signal. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_left_signal: aValue [
	^ self at: #cliff_left_signal put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_right [
	^ self getAt: #cliff_right. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_right: aValue [
	^ self at: #cliff_right put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_right_signal [
	^ self getAt: #cliff_right_signal. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> cliff_right_signal: aValue [
	^ self at: #cliff_right_signal put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> current [
	^ self getAt: #current. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> current: aValue [
	^ self at: #current put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> dirt_detector_left [
	^ self getAt: #dirt_detector_left. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> dirt_detector_left: aValue [
	^ self at: #dirt_detector_left put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> dirt_detector_right [
	^ self getAt: #dirt_detector_right. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> dirt_detector_right: aValue [
	^ self at: #dirt_detector_right put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> initialize [
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
	 self wall_signal: 0. 
	 self cliff_left_signal: 0. 
	 self cliff_front_left_signal: 0. 
	 self cliff_front_right_signal: 0. 
	 self cliff_right_signal: 0. 
	 self user_digital_inputs: 0. 
	 self user_analog_input: 0. 
	 self charging_sources_available: 0. 
	 self oi_mode: 0. 
	 self song_number: 0. 
	 self song_playing: false. 
	 self number_of_stream_packets: 0. 
	 self requested_velocity: 0. 
	 self requested_radius: 0. 
	 self requested_right_velocity: 0. 
	 self requested_left_velocity: 0. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> motor_overcurrents [
	^ self getAt: #motor_overcurrents. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> motor_overcurrents: aValue [
	^ self at: #motor_overcurrents put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> number_of_stream_packets [
	^ self getAt: #number_of_stream_packets. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> number_of_stream_packets: aValue [
	^ self at: #number_of_stream_packets put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> oi_mode [
	^ self getAt: #oi_mode. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> oi_mode: aValue [
	^ self at: #oi_mode put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> remote_opcode [
	^ self getAt: #remote_opcode. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> remote_opcode: aValue [
	^ self at: #remote_opcode put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_left_velocity [
	^ self getAt: #requested_left_velocity. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_left_velocity: aValue [
	^ self at: #requested_left_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_radius [
	^ self getAt: #requested_radius. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_radius: aValue [
	^ self at: #requested_radius put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_right_velocity [
	^ self getAt: #requested_right_velocity. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_right_velocity: aValue [
	^ self at: #requested_right_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_velocity [
	^ self getAt: #requested_velocity. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> requested_velocity: aValue [
	^ self at: #requested_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> song_number [
	^ self getAt: #song_number. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> song_number: aValue [
	^ self at: #song_number put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> song_playing [
	^ self getAt: #song_playing. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> song_playing: aValue [
	^ self at: #song_playing put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> temperature [
	^ self getAt: #temperature. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> temperature: aValue [
	^ self at: #temperature put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> user_analog_input [
	^ self getAt: #user_analog_input. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> user_analog_input: aValue [
	^ self at: #user_analog_input put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> user_digital_inputs [
	^ self getAt: #user_digital_inputs. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> user_digital_inputs: aValue [
	^ self at: #user_digital_inputs put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> virtual_wall [
	^ self getAt: #virtual_wall. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> virtual_wall: aValue [
	^ self at: #virtual_wall put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> voltage [
	^ self getAt: #voltage. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> voltage: aValue [
	^ self at: #voltage put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> wall [
	^ self getAt: #wall. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> wall: aValue [
	^ self at: #wall put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> wall_signal [
	^ self getAt: #wall_signal. 

]

{ #category : #'as yet unclassified' }
Create_nodeRawTurtlebotSensorState >> wall_signal: aValue [
	^ self at: #wall_signal put: aValue. 

]
