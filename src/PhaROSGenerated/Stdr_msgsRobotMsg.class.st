Class {
	#name : #'Stdr_msgsRobotMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> co2Sensors [
	^ self getAt: #co2Sensors. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> co2Sensors: aValue [
	^ self at: #co2Sensors put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> footprint [
	^ self getAt: #footprint. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> footprint: aValue [
	^ self at: #footprint put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> initialPose [
	^ self getAt: #initialPose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> initialPose: aValue [
	^ self at: #initialPose put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> initialize [
	super initialize.
	 self initialPose: Geometry_msgsPose2D new. 
	 self footprint: Stdr_msgsFootprintMsg new. 
	 self laserSensors: OrderedCollection new . 
	 self sonarSensors: OrderedCollection new . 
	 self rfidSensors: OrderedCollection new . 
	 self co2Sensors: OrderedCollection new . 
	 self soundSensors: OrderedCollection new . 
	 self thermalSensors: OrderedCollection new . 
	 self kinematicModel: Stdr_msgsKinematicMsg new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> kinematicModel [
	^ self getAt: #kinematicModel. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> kinematicModel: aValue [
	^ self at: #kinematicModel put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> laserSensors [
	^ self getAt: #laserSensors. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> laserSensors: aValue [
	^ self at: #laserSensors put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> rfidSensors [
	^ self getAt: #rfidSensors. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> rfidSensors: aValue [
	^ self at: #rfidSensors put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> sonarSensors [
	^ self getAt: #sonarSensors. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> sonarSensors: aValue [
	^ self at: #sonarSensors put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> soundSensors [
	^ self getAt: #soundSensors. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> soundSensors: aValue [
	^ self at: #soundSensors put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> thermalSensors [
	^ self getAt: #thermalSensors. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotMsg >> thermalSensors: aValue [
	^ self at: #thermalSensors put: aValue. 

]
