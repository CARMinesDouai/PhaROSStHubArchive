"
A PRSimpleAPIResource is a testResource that takes care of the required collection of nodes for the SimpleAPI tests. We assume roscore is already running.

"
Class {
	#name : #PRSimpleAPIResource,
	#superclass : #TestResource,
	#category : #'PhaROSTestROS-SimpleAPI'
}

{ #category : #utilities }
PRSimpleAPIResource >> build: aNumber associationsFrom: aTokenList [
	| coll |
	(aTokenList size < (aNumber * 2)) ifTrue: [self error: 'Token list to small'].
	
	coll := OrderedCollection new: aNumber.
	1 to: aNumber * 2 by: 2 do: [ :idx |
		coll add: (( aTokenList at: idx) -> ( aTokenList at: idx + 1))].
	^coll
]

{ #category : #running }
PRSimpleAPIResource >> setUp [
	OSProcess command:'rosrun turtlesim turtlesim_node __name:=turtle1'.
	2 seconds wait.
	"OSProcess command: 'rostopic echo /turtle1/cmd_vel __name:=turtle_echo'.
	OSProcess command:'rosrun turtlesim turtle_teleop_key __name:=turtle_teleop'.
	1 seconds wait."
	
]

{ #category : #running }
PRSimpleAPIResource >> tearDown [

	OSProcess command:' rosnode kill -a'. 
]

{ #category : #utilities }
PRSimpleAPIResource >> tokenizeString: aString [
	^aString findTokens: { Character cr. Character lf.  Character tab. Character space}
]
