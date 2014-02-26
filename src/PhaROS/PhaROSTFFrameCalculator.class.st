Class {
	#name : #PhaROSTFFrameCalculator,
	#superclass : #Object,
	#instVars : [
		'sourceToTopQuaternion',
		'sourceToTopVector',
		'targetToTopQuaternion',
		'targetToTopVector',
		'resultVector',
		'resultQuaternion'
	],
	#category : #'PhaROS-Nodelets-TF'
}

{ #category : #'as yet unclassified' }
PhaROSTFFrameCalculator >> accumulateToSource: aFrame [
    sourceToTopVector := (aFrame pose orientation rotatePosition: sourceToTopVector) + aFrame pose position.
    sourceToTopQuaternion := aFrame pose orientation * sourceToTopQuaternion.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrameCalculator >> accumulateToTarget: aFrame [
    targetToTopVector := (aFrame pose orientation rotatePosition: targetToTopVector) + aFrame pose position.
    targetToTopQuaternion := aFrame pose orientation * targetToTopQuaternion.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrameCalculator >> fullPath [
    | quat vec |
    quat := targetToTopQuaternion inverse.
    vec := quat rotatePosition: ( targetToTopVector * -1).

    resultVector := (quat rotatePosition: sourceToTopVector) + vec.
    resultQuaternion := quat * sourceToTopQuaternion.

    ^ PhaROSPose position: resultVector orientation: resultQuaternion.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrameCalculator >> initialize [ 
	sourceToTopQuaternion := PhaROSQuaternion zero.
	sourceToTopVector := PhaROSPosition zero.

	targetToTopQuaternion := PhaROSQuaternion zero.
	targetToTopVector := PhaROSPosition zero.

	resultQuaternion := PhaROSQuaternion zero.
	resultVector := PhaROSPosition zero.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrameCalculator >> sourceParentOfTarget [
	resultQuaternion := targetToTopQuaternion inverse.
    	resultVector := resultQuaternion rotatePosition: ( targetToTopVector * -1).
    ^ PhaROSPose position: resultVector orientation: resultQuaternion.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrameCalculator >> targetParentOfSource [
    resultQuaternion := sourceToTopQuaternion.
    resultVector := sourceToTopVector.
    ^ PhaROSPose position: resultVector orientation: resultQuaternion.
]
