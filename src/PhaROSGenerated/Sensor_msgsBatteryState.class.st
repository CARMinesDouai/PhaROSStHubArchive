Class {
	#name : #'Sensor_msgsBatteryState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_cold [
	^6

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_dead [
	^3

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_good [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_overheat [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_overvoltage [
	^4

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_safety_timer_expire [
	^8

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_unknown [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_unspec_failure [
	^5

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_health_watchdog_timer_expire [
	^7

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_status_charging [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_status_discharging [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_status_full [
	^4

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_status_not_charging [
	^3

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_status_unknown [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_life [
	^4

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_limn [
	^6

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_lion [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_lipo [
	^3

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_nicd [
	^5

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_nimh [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> power_supply_technology_unknown [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> rosMd5Sum [ 
^'476f837fa6771f6e16e3bf4ef96f8770'
]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> rosTypeDefinition [ 
^' int8 POWER_SUPPLY_STATUS_UNKNOWN=0
 int8 POWER_SUPPLY_STATUS_CHARGING=1
 int8 POWER_SUPPLY_STATUS_DISCHARGING=2
 int8 POWER_SUPPLY_STATUS_NOT_CHARGING=3
 int8 POWER_SUPPLY_STATUS_FULL=4
 int8 POWER_SUPPLY_HEALTH_UNKNOWN=0
 int8 POWER_SUPPLY_HEALTH_GOOD=1
 int8 POWER_SUPPLY_HEALTH_OVERHEAT=2
 int8 POWER_SUPPLY_HEALTH_DEAD=3
 int8 POWER_SUPPLY_HEALTH_OVERVOLTAGE=4
 int8 POWER_SUPPLY_HEALTH_UNSPEC_FAILURE=5
 int8 POWER_SUPPLY_HEALTH_COLD=6
 int8 POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE=7
 int8 POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE=8
 int8 POWER_SUPPLY_TECHNOLOGY_UNKNOWN=0
 int8 POWER_SUPPLY_TECHNOLOGY_NIMH=1
 int8 POWER_SUPPLY_TECHNOLOGY_LION=2
 int8 POWER_SUPPLY_TECHNOLOGY_LIPO=3
 int8 POWER_SUPPLY_TECHNOLOGY_LIFE=4
 int8 POWER_SUPPLY_TECHNOLOGY_NICD=5
 int8 POWER_SUPPLY_TECHNOLOGY_LIMN=6
 std_msgs/Header header
 float32 voltage
 float32 current
 float32 charge
 float32 capacity
 float32 design_capacity
 float32 percentage
 int8 power_supply_status
 int8 power_supply_health
 int8 power_supply_technology
 bool present
 float32[] cell_voltage
 string location
 string serial_number
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> rosTypeName [ 
^'sensor_msgs/BatteryState'
]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState class >> typeCreationOrder [ 
^257
]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> capacity [
	^ self getAt: #capacity. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> capacity: aValue [
	^ self at: #capacity put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> cell_voltage [
	^ self getAt: #cell_voltage. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> cell_voltage: aValue [
	^ self at: #cell_voltage put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> charge [
	^ self getAt: #charge. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> charge: aValue [
	^ self at: #charge put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> current [
	^ self getAt: #current. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> current: aValue [
	^ self at: #current put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> design_capacity [
	^ self getAt: #design_capacity. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> design_capacity: aValue [
	^ self at: #design_capacity put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self voltage: 0.0. 
	 self current: 0.0. 
	 self charge: 0.0. 
	 self capacity: 0.0. 
	 self design_capacity: 0.0. 
	 self percentage: 0.0. 
	 self power_supply_status: 0. 
	 self power_supply_health: 0. 
	 self power_supply_technology: 0. 
	 self present: false. 
	 self cell_voltage: OrderedCollection new . 
	 self location: ''. 
	 self serial_number: ''. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> location [
	^ self getAt: #location. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> location: aValue [
	^ self at: #location put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> percentage [
	^ self getAt: #percentage. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> percentage: aValue [
	^ self at: #percentage put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> power_supply_health [
	^ self getAt: #power_supply_health. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> power_supply_health: aValue [
	^ self at: #power_supply_health put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> power_supply_status [
	^ self getAt: #power_supply_status. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> power_supply_status: aValue [
	^ self at: #power_supply_status put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> power_supply_technology [
	^ self getAt: #power_supply_technology. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> power_supply_technology: aValue [
	^ self at: #power_supply_technology put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> present [
	^ self getAt: #present. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> present: aValue [
	^ self at: #present put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> serial_number [
	^ self getAt: #serial_number. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> serial_number: aValue [
	^ self at: #serial_number put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> voltage [
	^ self getAt: #voltage. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsBatteryState >> voltage: aValue [
	^ self at: #voltage put: aValue. 

]
