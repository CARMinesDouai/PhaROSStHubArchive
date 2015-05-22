Class {
	#name : #ImusensorsPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'socket',
		'rawDataPublisher',
		'dataString',
		'gyroVector',
		'accelerometerVector',
		'magnetometerVector',
		'magnetometerDataPublisher'
	],
	#category : #ImusensorsPackage
}

{ #category : #extracting }
ImusensorsPackage >> dataVectorAt: sensorId [
	sensorId = 3 ifTrue: [  ^accelerometerVector ].
	sensorId = 4 ifTrue: [ ^gyroVector ].
	^magnetometerVector 
	
	
"Sensor id:
3 - Accelerometer (m/s^2)
4 - Gyroscope (rad/s)
5 - Magnetometer (micro-Tesla uT)"
]

{ #category : #extracting }
ImusensorsPackage >> extractImuData [
	| substrings numbers vector |
	substrings := dataString substrings: ','.
	numbers := substrings collect: [ : each | each trim asNumber asFloat ].
	(2 to: numbers size by: 4) do: [ : deviceIdIndex|
		vector := self dataVectorAt: (numbers at: deviceIdIndex).
		vector x: (numbers at: deviceIdIndex + 1).
		vector y: (numbers at: deviceIdIndex + 2).
		vector z: (numbers at: deviceIdIndex + 3).
	].
	
"The app sends the measurements from the phone inertial sensors via UDP as CSV (Comma-Separated Values).

The following sensors are supported:
- Accelerometer
- Gyroscope
- Magnetometer

If your phone has not all these sensors, only the available sensor data is transmitted.

Example UDP packet:
890.71558, 3, 0.076, 9.809, 0.565, 4, -0.559, 0.032, -0.134, 5, -21.660,-36.960,-28.140

Timestamp [sec], sensorid, x, y, z, sensorid, x, y, z, sensorid, x, y, z

Sensor id:
3 - Accelerometer (m/s^2)
4 - Gyroscope (rad/s)
5 - Magnetometer (micro-Tesla uT)"
]

{ #category : #'initialize-release' }
ImusensorsPackage >> initialize [
	super initialize.
	socket := Socket newUDP.
	socket setPort: 5555.
	dataString := String new: 1000.
	rawDataPublisher := self controller node 
			topicPublisher: '/imu/data_raw' 
			typedAs: 'sensor_msgs/Imu'.
	magnetometerDataPublisher := self controller node 
			topicPublisher: 'imu/mag' 
			typedAs: 'geometry_msgs/Vector3Stamped'.
	accelerometerVector := Vector3DWithConvariance new.
	gyroVector := Vector3DWithConvariance new.
	magnetometerVector := PhaROS3DVector new.

]

{ #category : #communicating }
ImusensorsPackage >> publishImuData [
	self publishRawData.
	self publishMagnetometerData

]

{ #category : #communicating }
ImusensorsPackage >> publishMagnetometerData [
	magnetometerDataPublisher send: [ : magData |
		magData 
			x: magnetometerVector x;
			y: magnetometerVector y;
			z: magnetometerVector z ]
]

{ #category : #communicating }
ImusensorsPackage >> publishRawData [
	rawDataPublisher send:[ : imuData | 
								imuData orientation 
									x: 1;
									y: 0;
									z: 0;
									w: 1.
								imuData orientation_covariance: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0).
								imuData angular_velocity
									x: gyroVector x;
									y: gyroVector y;
									z: gyroVector z.
								imuData angular_velocity_covariance: gyroVector covarianceFloatArray.
								imuData linear_acceleration
									x: accelerometerVector x;
									y: accelerometerVector y;
									z: accelerometerVector z.
								imuData linear_acceleration_covariance: accelerometerVector covarianceFloatArray.
									].

"geometry_msgs/Quaternion orientation
  float64 x
  float64 y
  float64 z
  float64 w
float64[9] orientation_covariance
geometry_msgs/Vector3 angular_velocity
  float64 x
  float64 y
  float64 z
float64[9] angular_velocity_covariance
geometry_msgs/Vector3 linear_acceleration
  float64 x
  float64 y
  float64 z
float64[9] linear_acceleration_covariance
"

]

{ #category : #communicating }
ImusensorsPackage >> receiveSensorData [
	socket waitForData.
	socket receiveUDPDataInto: dataString
]

{ #category : #'initialize-release' }
ImusensorsPackage >> releaseResources [
	socket closeAndDestroy 
]

{ #category : #scripts }
ImusensorsPackage >> scriptBroadcastImuSensorValues [
	[ 
		[
			self receiveSensorData.
			self extractImuData.
			self publishImuData 
		] repeat		
	]ensure: [ 
		self releaseResources ]

]
