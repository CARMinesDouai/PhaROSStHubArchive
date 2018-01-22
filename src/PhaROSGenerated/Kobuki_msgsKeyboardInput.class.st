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
