Class {
	#name : #PhaROSTypeBrowserTests,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'PhaROS-Util-Test'
}

{ #category : #tests }
PhaROSTypeBrowserTests >> setUp [
	super setUp.
	browser := PhaROSTypeBrowser instance.
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testBool [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Bool'. 
		self assert: definition typeName = 'std_msgs/Bool'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testByte [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Byte'. 
		self assert: definition typeName = 'std_msgs/Byte'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testByteMultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/ByteMultiArray'. 
		self assert: definition typeName = 'std_msgs/ByteMultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testChar [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Char'. 
		self assert: definition typeName = 'std_msgs/Char'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testColorRGBA [
	 | definition | 
		definition :=  browser definition: 'std_msgs/ColorRGBA'. 
		self assert: definition typeName = 'std_msgs/ColorRGBA'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testDuration [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Duration'. 
		self assert: definition typeName = 'std_msgs/Duration'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testEmpty [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Empty'. 
		self assert: definition typeName = 'std_msgs/Empty'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testFloat32 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Float32'. 
		self assert: definition typeName = 'std_msgs/Float32'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testFloat32MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Float32MultiArray'. 
		self assert: definition typeName = 'std_msgs/Float32MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testFloat64 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Float64'. 
		self assert: definition typeName = 'std_msgs/Float64'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testFloat64MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Float64MultiArray'. 
		self assert: definition typeName = 'std_msgs/Float64MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testHeader [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Header'. 
		self assert: definition typeName = 'std_msgs/Header'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt16 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int16'. 
		self assert: definition typeName = 'std_msgs/Int16'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt16MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int16MultiArray'. 
		self assert: definition typeName = 'std_msgs/Int16MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt32 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int32'. 
		self assert: definition typeName = 'std_msgs/Int32'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt32MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int32MultiArray'. 
		self assert: definition typeName = 'std_msgs/Int32MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt64 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int64'. 
		self assert: definition typeName = 'std_msgs/Int64'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt64MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int64MultiArray'. 
		self assert: definition typeName = 'std_msgs/Int64MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt8 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int8'. 
		self assert: definition typeName = 'std_msgs/Int8'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testInt8MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Int8MultiArray'. 
		self assert: definition typeName = 'std_msgs/Int8MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testMultiArrayDimension [
	 | definition | 
		definition :=  browser definition: 'std_msgs/MultiArrayDimension'. 
		self assert: definition typeName = 'std_msgs/MultiArrayDimension'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testMultiArrayLayout [
	 | definition | 
		definition :=  browser definition: 'std_msgs/MultiArrayLayout'. 
		self assert: definition typeName = 'std_msgs/MultiArrayLayout'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testString [
	 | definition | 
		definition :=  browser definition: 'std_msgs/String'. 
		self assert: definition typeName = 'std_msgs/String'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testTime [
	 | definition | 
		definition :=  browser definition: 'std_msgs/Time'. 
		self assert: definition typeName = 'std_msgs/Time'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt16 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt16'. 
		self assert: definition typeName = 'std_msgs/UInt16'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt16MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt16MultiArray'. 
		self assert: definition typeName = 'std_msgs/UInt16MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt32 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt32'. 
		self assert: definition typeName = 'std_msgs/UInt32'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt32MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt32MultiArray'. 
		self assert: definition typeName = 'std_msgs/UInt32MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt64 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt64'. 
		self assert: definition typeName = 'std_msgs/UInt64'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt64MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt64MultiArray'. 
		self assert: definition typeName = 'std_msgs/UInt64MultiArray'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt8 [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt8'. 
		self assert: definition typeName = 'std_msgs/UInt8'.
		
]

{ #category : #tests }
PhaROSTypeBrowserTests >> testUInt8MultiArray [
	 | definition | 
		definition :=  browser definition: 'std_msgs/UInt8MultiArray'. 
		self assert: definition typeName = 'std_msgs/UInt8MultiArray'.
		
]
