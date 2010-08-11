"
I'm a place where you can store objetcs, when you store an object you get an unique key for this instance, sucesives call to the pool answer the same unique key.

Aditionaly you can get the object with the key.

The references to the object are weaks, so the object retain the key while exists.
"
Class {
	#name : #RSTWeakKeyManager,
	#superclass : #RSTKeyManager,
	#category : #'rST-Core'
}

{ #category : #private }
RSTWeakKeyManager >> depurate [
	"PRIVATE: This method is called from a critical section, be carefull to call 
	it without synchonization"
	"keys make a Set, so I can remove without problem"
	dictionary keys
		do: [:key | (dictionary at: key) isNil
				ifTrue: [dictionary removeKey: key]].

]

{ #category : #initialization }
RSTWeakKeyManager >> initializeDictionary [
	"hook method"
	dictionary := WeakValueDictionary new
]
