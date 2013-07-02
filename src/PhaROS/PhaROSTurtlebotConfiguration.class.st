Class {
	#name : #PhaROSTurtlebotConfiguration,
	#superclass : #Object,
	#category : #'PhaROS-Packages-Turtlebot'
}

{ #category : #pose }
PhaROSTurtlebotConfiguration class >> poseTopic [
	^ '/odom_combined'
]

{ #category : #pose }
PhaROSTurtlebotConfiguration class >> poseTopicType [
	^ 'geometry_msgs/PoseWithCovarianceStamped'
]
