Class {
	#name : #'Create_nodeBatteryState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
