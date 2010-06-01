Class {
	#name : #OCNNetCatBasedServer,
	#superclass : #Object,
	#instVars : [
		'process',
		'port'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'instance creation' }
OCNNetCatBasedServer class >> port: anInteger [
	^self new
		port: anInteger;
		yourself
]

{ #category : #testing }
OCNNetCatBasedServer >> isRunning [
	^self process notNil
]

{ #category : #accessing }
OCNNetCatBasedServer >> port [
	^ port
]

{ #category : #accessing }
OCNNetCatBasedServer >> port: anObject [
	port := anObject
]

{ #category : #accessing }
OCNNetCatBasedServer >> process [
	^ process
]

{ #category : #accessing }
OCNNetCatBasedServer >> process: anObject [
	process := anObject
]

{ #category : #accessing }
OCNNetCatBasedServer >> processPid [
	^self process pid 
]

{ #category : #'process lifecycle' }
OCNNetCatBasedServer >> start [
	self process: (OSProcess command: 'nc -4 -l localhost ', self port printString)
	
" nc : netcat
	nc [options] [hostname] [port[s]]
    
The nc (or netcat) utility is used for just about anything under the sun involving TCP or UDP.  It can open TCP connections, send UDP packets, listen on arbitrary TCP and UDP ports, do port scanning, and deal with both IPv4 and IPv6.  Unlike telnet(1), nc scripts nicely, and separates error messages onto standard error instead of sending them to standard output, as telnet(1) does with some.

  -4     Forces nc to use IPv4 addresses only.
  -l     Used to specify that nc should listen for an incoming connection rather than initiate a connection to a remote host.  It is an error to use this option in conjunction with the -p, -s, or -z options.  Additionally, any timeouts specified with the -w option are ignored.
   -k    Forces nc to stay listening for another connection after its current connection is completed.  It is an error to use this option without the -l option.

"
]

{ #category : #'process lifecycle' }
OCNNetCatBasedServer >> stop [
	"kill -3 == sends the QUIT signal to the process (equivalent to Ctl-C)"
	self isRunning ifTrue: [
		OSProcess waitForCommand: 'kill -3 ', self processPid printString].
	self process: nil
]
