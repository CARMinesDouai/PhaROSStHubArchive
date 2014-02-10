"
ROSType message named: #blaa package: #ble defined: { 
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
		ROSType definedBy: 'std_msgs/Header' named: #header.
	}.
	
ROSType definedBy: 'std_msgs/Header' named: #header.
	
	ROSType service named: #bla package: #lala request:{
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
	} response: { 
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
	}.
	
"
Class {
	#name : #PhaROSROSType,
	#superclass : #Object,
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'as yet unclassified' }
PhaROSROSType class >> definedBy: aROSTypeId named: aName [ 
	 ^ PhaROSFieldDefinition named: aName type: (PhaROSTypeBrowser instance type: aROSTypeId ).
]

{ #category : #'as yet unclassified' }
PhaROSROSType class >> initialize [ 	
	Smalltalk at:#ROSType put: self.
]

{ #category : #'as yet unclassified' }
PhaROSROSType class >> message [
	^ PhaROSMessageTypeBuilder.
]

{ #category : #'as yet unclassified' }
PhaROSROSType class >> service [
	^ PhaROSServiceTypeBuilder 
]
