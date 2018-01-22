Class {
	#name : #'Controller_manager_msgsHardwareInterfaceResources',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Controller_manager_msgsHardwareInterfaceResources >> hardware_interface [
	^ self getAt: #hardware_interface. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsHardwareInterfaceResources >> hardware_interface: aValue [
	^ self at: #hardware_interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsHardwareInterfaceResources >> initialize [
	super initialize.
	 self hardware_interface: ''. 
	 self resources: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsHardwareInterfaceResources >> resources [
	^ self getAt: #resources. 

]

{ #category : #'as yet unclassified' }
Controller_manager_msgsHardwareInterfaceResources >> resources: aValue [
	^ self at: #resources put: aValue. 

]
