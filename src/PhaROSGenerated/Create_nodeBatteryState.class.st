Class {
	#name : #'Create_nodeBatteryState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Create_nodeBatteryState class >> rosMd5Sum [ 
^'481447a4e24f212e7b403e4f04aa2ac9'
]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState class >> rosTypeDefinition [ 
^' std_msgs/Header header
 int8 temperature
 uint16 charge
 uint16 capacity
'
]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState class >> rosTypeName [ 
^'create_node/BatteryState'
]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> capacity [
	^ self getAt: #capacity. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> capacity: aValue [
	^ self at: #capacity put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> charge [
	^ self getAt: #charge. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> charge: aValue [
	^ self at: #charge put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self temperature: 0. 
	 self charge: 0. 
	 self capacity: 0. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> temperature [
	^ self getAt: #temperature. 

]

{ #category : #'as yet unclassified' }
Create_nodeBatteryState >> temperature: aValue [
	^ self at: #temperature put: aValue. 

]
