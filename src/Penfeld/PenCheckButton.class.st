Class {
	#name : #PenCheckButton,
	#superclass : #PenInteractionElement,
	#traits : 'TPenValueChangedEvent',
	#classTraits : 'TPenValueChangedEvent classTrait',
	#instVars : [
		'value',
		'text'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #api }
PenCheckButton >> check [
	self value: true
]

{ #category : #initialization }
PenCheckButton >> initialize [
	super initialize.
	value := false.
	self addAutoInstalledCallback: [ self toggle ] for: PenEventSymbol action
]

{ #category : #'api - events' }
PenCheckButton >> onCheckedDo: aBlock [
	self 
		addCallback: [ self value ifTrue: [ aBlock value ] ] 
		for: PenEventSymbol valueChanged
]

{ #category : #'api - events' }
PenCheckButton >> onUncheckedDo: aBlock [
	self 
		addCallback: [ self value ifFalse: [ aBlock value ] ] 
		for: PenEventSymbol valueChanged
]

{ #category : #'api - events' }
PenCheckButton >> onValueChangedDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol valueChanged
]

{ #category : #accessing }
PenCheckButton >> text [
	^ text
]

{ #category : #accessing }
PenCheckButton >> text: aString [
	text := aString
]

{ #category : #api }
PenCheckButton >> toggle [
	self value: self value not
]

{ #category : #api }
PenCheckButton >> uncheck [
	self value: false
]

{ #category : #accessing }
PenCheckButton >> value [
	^ value
]

{ #category : #accessing }
PenCheckButton >> value: aBoolean [
	value = aBoolean 
		ifTrue: [ ^ self ].
	value := aBoolean.
	self valueChangedEvent.
	self refresh
]