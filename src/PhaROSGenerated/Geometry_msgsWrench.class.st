Class {
	#name : #'Geometry_msgsWrench',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> force [
	^ self getAt: #force. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> force: aValue [
	^ self at: #force put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> initialize [
	super initialize.
	 self force: Geometry_msgsVector3 new. 
	 self torque: Geometry_msgsVector3 new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> torque [
	^ self getAt: #torque. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrench >> torque: aValue [
	^ self at: #torque put: aValue. 

]
