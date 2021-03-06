"
TConcurrencyTest provides methods to ease testing concurrent code with the following pattern.
 
-A semaphore is shared between the process for testcase and the concurrent process under test.

-the concurrent process under test is supposed signal the semaphore upon some condition.

-testcase waits for signals or timeouts to decide whether the test failed or not

"
Trait {
	#name : #TConcurrencyTest,
	#category : #Concurrency
}

{ #category : #testing }
TConcurrencyTest >> assertSemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self deny: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
TConcurrencyTest >> assertSemaphore: semaphore signaledWithinSeconds: seconds [
	self deny: (semaphore waitTimeoutSeconds: seconds)
]

{ #category : #testing }
TConcurrencyTest >> denySemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self assert: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
TConcurrencyTest >> denySemaphore: semaphore signaledWithinSeconds: seconds [
	self assert: (semaphore waitTimeoutSeconds: seconds)
]
