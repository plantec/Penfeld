Class {
	#name : #PenContainer,
	#superclass : #PenDisplayComponent,
	#instVars : [
		'elements',
		'layout'
	],
	#category : #'Penfeld-Core'
}

{ #category : #accessing }
PenContainer >> addAllElements: aCollection [
	aCollection do: [ :e | self addElement: e ].
]

{ #category : #accessing }
PenContainer >> addElement: anElement [
	self elements add: anElement
]

{ #category : #building }
PenContainer >> build [
	self elements do: [ :each | each build ].
	super build.
]

{ #category : #accessing }
PenContainer >> elements [
	^ elements
]

{ #category : #accessing }
PenContainer >> elements: anObject [
	elements := anObject
]

{ #category : #initialization }
PenContainer >> initialize [
	super initialize.
	elements := OrderedCollection new.
]

{ #category : #testing }
PenContainer >> isContainer [
	^ true
]

{ #category : #accessing }
PenContainer >> layout [
	^ layout
]

{ #category : #accessing }
PenContainer >> layout: anObject [
	layout := anObject
]

{ #category : #accessing }
PenContainer >> removeElement: anElement [
	self elements remove: anElement ifAbsent: [ ^ self]
]

{ #category : #accessing }
PenContainer >> styleName [
	^ #container
]