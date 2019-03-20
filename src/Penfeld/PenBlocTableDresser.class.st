Class {
	#name : #PenBlocTableDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'dataSource',
		'pushedItem'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocTableDresser >> backgroundColor: aValue [
	self model interactor background: aValue
]

{ #category : #styling }
PenBlocTableDresser >> border: aValue [
	| borderBuilder |	
	borderBuilder := BlBorderBuilder new.	
		
	aValue do: 
	[ :property | 
		property isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property isSymbol
			ifTrue: [ 
				(borderBuilder respondsTo: property) 
				ifTrue: [ borderBuilder perform: property ] 
			]
			ifFalse: [ 
				(property isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	self model interactor border: borderBuilder build.
]

{ #category : #dressing }
PenBlocTableDresser >> doBeforeApplyStyle [
	| listElements |
	listElements := self model items collect: [ :item | 
		item interactor ].
	listElements addFirst: self model header interactor.
	dataSource elements: listElements.
	self model interactor dataSource: dataSource.
	dataSource notifyChanged
]

{ #category : #dressing }
PenBlocTableDresser >> initInteractor [
	dataSource := PenInfiniteDataSource new.
	
	self model interactor: PenInfiniteListElement new.
	self model interactor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self model allowToSelect ifFalse: [ ^ self ].

	pushedItem := false.
	self model items do: [ :item |
		item interactor when: BlMouseDownEvent do: [ :e | self whenMouseDownEventOn: item ].
		item interactor when: BlMouseUpEvent do: [ :e | self whenMouseUpEventOn: item ].
		item interactor when: BlMouseLeaveEvent do: [ :e | self whenMouseLeaveEventOn: item ].].
]

{ #category : #events }
PenBlocTableDresser >> whenMouseDownEventOn: anItem [ 
	anItem refreshStyle.
	pushedItem := anItem.
]

{ #category : #events }
PenBlocTableDresser >> whenMouseLeaveEventOn: anItem [
	pushedItem = anItem ifFalse: [ ^ self ].
	anItem refreshStyle.
	pushedItem := nil.
]

{ #category : #events }
PenBlocTableDresser >> whenMouseUpEventOn: anItem [
	(pushedItem notNil and: [anItem = pushedItem]) ifTrue: [
		pushedItem refreshStyle.
		pushedItem := nil].
]