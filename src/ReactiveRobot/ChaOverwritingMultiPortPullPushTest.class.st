Class {
	#name : #ChaOverwritingMultiPortPullPushTest,
	#superclass : #ChaMultiPortComponentTest,
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #testing }
ChaOverwritingMultiPortPullPushTest >> componentClass [
	^ChaOverwritingMultiPortPullPush 
]

{ #category : #testing }
ChaOverwritingMultiPortPullPushTest >> testDataIsOverwritten [
	| writtenData expectedData |
	writtenData := 1 to: 3. 
	writtenData do: [ : setterArg | 
		portSetters do: [ : setter |component perform: setter with: setterArg].
	].
	portSetters do: [ : setter |
		self assert: (component dataOnPort: setter) equals: nil
	].
	expectedData := writtenData last.
	portSetters size timesRepeat: [component pullPush].
	portSetters do: [ : setter  | self assert: (component dataOnPort: setter) equals: expectedData]
]
