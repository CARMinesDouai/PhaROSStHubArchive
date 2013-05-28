Extension { #name : #PhaROSHandleController }

{ #category : #'*stargazer-ros' }
PhaROSHandleController >> enableStargazer [
	self use: SGROSBroadcaster new.
]
