Extension { #name : #String }

{ #category : #'*rST' }
String >> asLocalObject [
	"Noury Bouraqadi 10/3/2006 23:51"
	"convert to an apropiate local object, could be a proxy or the real object"

	^ self asRemoteObjectID asLocalObject
]

{ #category : #'*rST' }
String >> asRemoteObjectID [
	"creates a remote object id from this string"
	^ RSTRemoteObjectID fromString: self
]

{ #category : #'*rST' }
String >> remoteType [
	"answer the prefered way to go to other squeak (#reference or #copy)"
	"
	if the string is used in a mutable way, you must change to #reference
	"
	^ #copy
]
