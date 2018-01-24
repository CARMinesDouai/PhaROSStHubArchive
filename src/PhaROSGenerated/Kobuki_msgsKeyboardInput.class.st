Class {
	#name : #'Kobuki_msgsKeyboardInput',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_disable [
	^100

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_down [
	^66

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_enable [
	^101

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_left [
	^68

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_right [
	^67

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_space [
	^32

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> keycode_up [
	^65

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> rosMd5Sum [ 
^'9288b95cb32b48719d84d696be253401'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> rosTypeDefinition [ 
^' int8 KeyCode_Right=67
 int8 KeyCode_Left=68
 int8 KeyCode_Up=65
 int8 KeyCode_Down=66
 int8 KeyCode_Space=32
 int8 KeyCode_Enable=101
 int8 KeyCode_Disable=100
 int8 pressedKey
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput class >> rosTypeName [ 
^'kobuki_msgs/KeyboardInput'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput >> initialize [
	super initialize.
	 self pressedKey: 0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput >> pressedKey [
	^ self getAt: #pressedKey. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsKeyboardInput >> pressedKey: aValue [
	^ self at: #pressedKey put: aValue. 

]
