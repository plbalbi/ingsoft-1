!classDefinition: #I category: #'Cuarta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Cuarta Actividad'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'PO 3/22/2018 20:59:09'!
next
	"comment stating purpose of message"

	| |
	^II! !


!I class methodsFor: 'nil' stamp: 'PO 3/26/2018 20:56:20'!
* aPeanoNumber
	"comment stating purpose of message"

	| |
	^aPeanoNumber! !

!I class methodsFor: 'nil' stamp: 'PO 3/26/2018 20:56:27'!
+ aPeanoNumber
	"comment stating purpose of message"

	| |
	^aPeanoNumber next! !

!I class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:38:50'!
<= aPeanoNumber
	^true! !

I instVarNamed: 'next' put: II!

!classDefinition: #II category: #'Cuarta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Cuarta Actividad'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 20:44:54'!
next
	next = nil ifTrue: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
		].
	^next
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 20:44:01'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 20:46:00'!
previous: peanoNumber
	self previous = peanoNumber! !


!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:00:05'!
* aPeanoNumber

	^(previous * aPeanoNumber) + self! !

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 20:56:31'!
+ aPeanoNumber
	^self previous + aPeanoNumber next! !

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:09:28'!
- aPeanoNumber
	aPeanoNumber = I ifTrue: [^self previous] ifFalse:[^self previous - aPeanoNumber previous]
	! !

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:24:07'!
/ aPeanoNumber
	| | 
	self <= aPeanoNumber next 
		ifTrue:[self error: 'No se puede dividir'] 
		ifFalse: [
			| divisionParcial |
			divisionParcial := (self - aPeanoNumber) / aPeanoNumber.
			^divisionParcial + 1
			]! !

!II class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:18:43'!
<= aPeanoNumber
	aPeanoNumber = I ifTrue:[^self = I] ifFalse:[^self previous <= aPeanoNumber previous]! !

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #'Cuarta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuarta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Cuarta Actividad'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 21:36:47'!
next
	next = nil ifTrue: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
		].
	^next
	
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 21:36:47'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'PO 3/26/2018 21:36:47'!
previous: peanoNumber
	self previous = peanoNumber! !


!III class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:36:47'!
* aPeanoNumber

	^(previous * aPeanoNumber) + self! !

!III class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:36:47'!
+ aPeanoNumber
	^self previous + aPeanoNumber next! !

!III class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:36:47'!
- aPeanoNumber
	aPeanoNumber = I ifTrue: [^self previous] ifFalse:[^self previous - aPeanoNumber previous]
	! !

!III class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:36:47'!
/ aPeanoNumber
	| | 
	self <= aPeanoNumber next 
		ifTrue:[self error: 'No se puede dividir'] 
		ifFalse: [
			| divisionParcial |
			divisionParcial := (self - aPeanoNumber) / aPeanoNumber.
			^divisionParcial + 1
			]! !

!III class methodsFor: 'nil' stamp: 'PO 3/26/2018 21:36:47'!
<= aPeanoNumber
	aPeanoNumber = I ifTrue:[^self = I] ifFalse:[^self previous <= aPeanoNumber previous]! !

III instVarNamed: 'next' put: nil!
III instVarNamed: 'previous' put: I!