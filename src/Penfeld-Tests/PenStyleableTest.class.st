"
A PenStyleableTest is a test class for testing the behavior of TPssStyleable apply for PenDisplayComponent
"
Class {
	#name : #PenStyleableTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Elements support'
}

{ #category : #parsing }
PenStyleableTest >> parse: aString [
	^ PssSimpleParser parse: aString
]

{ #category : #stylesheet }
PenStyleableTest >> stylesheet1 [
	^ self parse: '
* { color: #000000; }
button { color: #111111; }
#myButton { color: #222222; }
.class1 { color: #333333; }
.class2 { color: #343434; }
button:active { color: #444444; }
tr:nth-child(2) { color: #555555; }
tr:nth-child(odd) { color: #515151; }
	
	'
]

{ #category : #tests }
PenStyleableTest >> testStyleable [
	| stylesheet button rules |
	stylesheet := self stylesheet1.
	
	button := PenButton new.
	rules := stylesheet matchingRulesFor: button.
	self assert: rules size equals: 2.
	self assert: rules first selector name equals: #*.
	self assert: rules second selector name equals: #button.
]

{ #category : #tests }
PenStyleableTest >> testStyleable2 [
	| stylesheet button rules |
	stylesheet := self stylesheet1.
	
	button := PenButton new.
	button key: #myButton.
	
	rules := stylesheet matchingRulesFor: button.
	self assert: rules size equals: 3.
	self assert: rules first selector name equals: #*.
	self assert: rules second selector name equals: #button.
	self assert: rules third selector id equals: #myButton.
]

{ #category : #tests }
PenStyleableTest >> testStyleable3 [
	| stylesheet button rules |
	stylesheet := self stylesheet1.
	
	button := PenButton new.
	button addStyleClass: #class1.
	button addStyleClass: #class2.
	
	rules := stylesheet matchingRulesFor: button.
	self assert: rules size equals: 4.
	self assert: ((rules at: 3) selector styleClasses includes: #class1).
	self assert: ((rules at: 4) selector styleClasses includes: #class2).
]

{ #category : #tests }
PenStyleableTest >> testStyleable4 [
	| stylesheet button rules |
	stylesheet := self stylesheet1.
	
	button := PenButton new.
	button activatePseudoClass: #active.
	
	rules := stylesheet matchingRulesFor: button.
	self assert: rules size equals: 3.
	self assert: (rules third selector pseudoClasses includesKey: #active).
]
