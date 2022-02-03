Write a simple linked list implementation. The linked list is a fundamental data structure in computer science, often used in the implementation of other data structures.

The simplest kind of linked list is a singly linked list. Each element in the list contains data and a "next" field pointing to the next element in the list of elements. This variant of linked lists is often used to represent sequences or push-down stacks (also called a LIFO stack; Last In, First Out).

Let's create a singly linked list whose elements may contain a range of data such as the numbers 1-10. Provide functions to reverse the linked list and convert a linked list to and from an array.

# Understand the Problem

Create a linked list data structured. Linked lists contain two instance variables, one for the data in the element, and one for the next element in the list.

Explicit functionality requirements:
- a method to reverse the linked list
- a method to convert the linked list to an array

Implicit functionality requirements:
- a method to determine if an element is the last element in the list
- a method to return the next element in the list
- a method to return the list size
- a method to determine if the list is empty
- a method to add an element to the list
- a method to see what the next element of a list is
- a method to return the first element in the list
- a method to remove the last element from the list

# Examples

element1 - @data = 1, @next = element2; element2 - @data = 2, @next = element3; element3 - @data = 3, @next = nil

# Data Structures

a class representing the list
a class representing the elements

# Algorithm

class Element

attr_accessor methods
- datum
- next

constructor
- Two parameter, the data being stored inside the element, and an optional parameter for the previous element
- Initializes the @next instance variable to store the next object in the sequence
- If an object is passed in as an argument for the previous element, assign the @next instance variable in the previous element to this object

class LinkedList

constructor
- Initializes an array to hold the elements of the list