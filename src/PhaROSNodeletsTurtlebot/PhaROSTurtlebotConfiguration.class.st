Class {
	#name : #PhaROSTurtlebotConfiguration,
	#superclass : #Object,
	#category : #PhaROSNodeletsTurtlebot
}

{ #category : #pose }
PhaROSTurtlebotConfiguration class >> poseTopic [
	^ '/odom_combined'
]

{ #category : #pose }
PhaROSTurtlebotConfiguration class >> poseTopicType [
	^ 'geometry_msgs/PoseWithCovarianceStamped'
]
