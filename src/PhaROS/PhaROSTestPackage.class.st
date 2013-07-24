Class {
	#name : #PhaROSTestPackage,
	#superclass : #PhaROSPackage,
	#category : #'PhaROS-PackageManager'
}

{ #category : #'as yet unclassified' }
PhaROSTestPackage >> author [
	^ Author fullName
]

{ #category : #accessing }
PhaROSTestPackage >> description [
	^' test package'
]

{ #category : #'as yet unclassified' }
PhaROSTestPackage >> location [
	^ '/home/santiago/workspace/catkin'
]

{ #category : #'as yet unclassified' }
PhaROSTestPackage >> name [
	^ 'pharo_test_package'
]

{ #category : #'as yet unclassified' }
PhaROSTestPackage >> version [
	^ '0.1.0'
]
