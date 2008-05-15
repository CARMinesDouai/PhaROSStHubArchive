Extension { #name : #RSTWeakKeyManager }

{ #category : #'*rSTAdd-ons' }
RSTWeakKeyManager >> depurate [

	dictionary keys do:[:aKey | 
		(dictionary at: aKey) ifNil:[
			mutex critical: [dictionary removeKey: aKey ifAbsent:[]]]].

]

{ #category : #'*rSTAdd-ons' }
RSTWeakKeyManager >> initializeDictionary [
	"hook method"
	dictionary := WeakValueDictionary new
]
