Class {
	#name : #ChaBufferedMultiPortPullPushTest,
	#superclass : #ChaMultiPortComponentTest,
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #testing }
ChaBufferedMultiPortPullPushTest >> componentClass [
	^ChaBufferedMultiPortPullPush 
]

{ #category : #testing }
ChaBufferedMultiPortPullPushTest >> testDataBuffering [
	| writtenData |
	writtenData := 1 to: 3. 
	writtenData do: [ : setterArg | 
		portSetters do: [ : setter |component perform: setter with: setterArg].
	].
	portSetters do: [ : setter |
		self assert: (component dataOnPort: setter) equals: nil
	].
	writtenData  do: [ : expectedData |  
		portSetters size timesRepeat: [component pullPush].
		portSetters do: [ : setter  | self assert: (component dataOnPort: setter) equals: expectedData ]
	]
]
