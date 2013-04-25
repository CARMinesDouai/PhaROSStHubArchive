Class {
	#name : #PureROSOdometryDelegate,
	#superclass : #Object,
	#category : #'PureROS-HandleApproach'
}

{ #category : #'as yet unclassified' }
PureROSOdometryDelegate >> sendThrough: aNodeHandle [
	
]

{ #category : #'as yet unclassified' }
PureROSOdometryDelegate >> setupInterestThrough: aNodeHandle and: aRobot [
	
	aRobot localizationService onNotificationDo: [ : notification | self broadcast: notification with: aNodeHandle ].
	[aRobot localizationService enableNotificationsEvery: 0.] on: PNGMessageError do: [ ].

	aNodeHandle interestedIn: '/initialpose' typedAs: 'geometry_msgs/PoseWithCovarianceStamped' onReceive: [ :msg | self initialPose: msg ].
	aNodeHandle interestedIn: '/tfaas/map/base_link' typedAs: 'geometry_msgs/PoseStamped'  onReceive: [ :msg | self mapBaseLinkDistance: msg ].
	aNodeHandle interestedIn: '/tfaas/map/base_footprint' typedAs: 'geometry_msgs/PoseStamped' onReceive: [ :msg | self mapBaseFootprintDistance: msg ].
	



]
