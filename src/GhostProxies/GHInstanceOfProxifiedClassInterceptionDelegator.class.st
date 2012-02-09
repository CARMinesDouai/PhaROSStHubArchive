Class {
	#name : #GHInstanceOfProxifiedClassInterceptionDelegator,
	#superclass : #Object,
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHInstanceOfProxifiedClassInterceptionDelegator >> cannotInterpret: aMessage [ 
	| interception context  counter proxy |
	
	"In this case, 'self' is the instance whose class was proxified. Therefore, we cannot send ANY message to 'self' because we will cause an infinitive loop '"
	GHGhostLogger logger log:   'cannotInterpret:  ', aMessage selector.
	GHGhostLogger logger log:   'Stack:  '.
	GHGhostLogger logger log:   '----------------'.
		
	context := thisContext sender.
	counter := 0.
	[context isNil not and: [counter < 50]] whileTrue:  [
		GHGhostLogger logger log:  context  method ghostPrintString.
		context := context sender.
		counter := counter + 1.
		].

	
	"We first have to find the proxy, that is, we need to search in the hierarchy the first class (or proxy) whose methodDict is nil. Usually here I should be able todo 'aMessage lookupClass mareaFindClassWithNilMethodDictInHierarchy', but in this particular case, that would lead into a system crash when swapping out classes. As an example, I have have the class XXX and its subclass YYY. We swapped XXX and now YYY has received a message. The VM see that XXX has its methodDict in nil and sends #cannotInterpret:.  If here we do 'aMessage lookupClass mareaFindClassWithNilMethodDictInHierarchy' to YYY, it will loop, because it will find again that it superclass (XXX) has the methodDict in nil. So we CANNOT send any message here because it will be trap again. We need to avoid the method lookup. For that purpose, we directly evaluate the compiled method #mareaFindClassWithNilMethodDictInHierarchy in each class of the hierarchy until we find the proxy. It is not risky to use this compiledMethod because the instance variables 'methodDict' and 'superclass' won't change they place, hence the bytecode will always be correct for classes. 
	This problem is exactly the same we have in #updateMissingSharedProxiesFrom: materializedInstances filling: dict."
	proxy := CompiledMethod receiver: aMessage lookupClass withArgs: #() executeMethod: (Behavior >> #ghostFindClassWithNilMethodDictInHierarchy).
	^ proxy handleInterceptionToInstance: aMessage andReceiver: self
	

]
