Class {
	#name : #PhaROSTurtlebotConfiguration,
	#superclass : #Object,
	#category : #'PhaROS-Packages-Turtlebot'
}

{ #category : #pose }
PhaROSTurtlebotConfiguration class >> poseTopic [
	^ '/robot_pose_ekf/pose'
]

{ #category : #pose }
PhaROSTurtlebotConfiguration class >> poseTopicType [
	^ 'geometry_msgs/PoseWithCovarianceStamped'
]
