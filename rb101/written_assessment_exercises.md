## Local Variable Scope

### Example 1

```ruby
a = “Hello”
b = a
a = “Goodbye”
puts a
puts b
```
On line 1, the local variable `a` is initialized and assigned to the String object `'Hello'`. On line 2, the local variable `b` is initialized and assigned to the String object that the local variable `a` references. Both `a` and `b` now reference the same String object `'Hello'`. On line 3, we reassign the local variable `a` to now reference the String object `'Goodbye'`.

Lines 4 and 5 output the following:
```
Goodbye
Hello
```
and the return value is `nil`.

### Example 2

```ruby
a = 4

loop do
  a = 5
  b = 3
  break
end

puts a
puts b
```
On line 1, the local variable `a` is initialized and assigned to the Integer object `4`. The `loop` method is invoked on line 3 and the following `do...end` block is passed into the method as an argument. On line 4, the local variable `a` is reassigned to the Integer object `5`. This reassignment is possible because the local variable `a` is accesible inside of the `do...end` block as it was initialized outside of the block. On line 5, the local variable `b` is initialized and assigned to the Integer object `3`. On line 6, the `break` keyword is used to break out of the `loop` method.

Lines 8 and 9 output the following:
```
5
3
```
and the return value is `nil`.

### Example 3

```ruby
a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a
puts b
```
On line 1, the local variable `a` is initialized and assigned to the Integer object `4`. On line 2, the local variable `b` is initialized and assigned to the Integer object `2`.

On line 4, the `loop` method is invoked and the following `do...end` block is passed into the method as an argument. On line 5, the variable `c` is initialized and assigned to the Integer object `3`. This variable is local to the inner scope of the `do...end` block. On line 5, the local variable `a` is reassigned to the Integer object `3` that local variable `c` is referencing. This reassignment is possible because the local variable `a` is accesible inside of the `do...end` block as it was initialized outside of the block. On line 6, the `break` keyword is used to break out of the `loop` method.

Lines 8 and 9 output the following:
```
3
2
```
and the return value is `nil`.

### Example 4

```ruby
def example(str)
  i = 3
  loop do
    puts str
    i -= 1
    break if i == 0
  end
end

example('hello')
```

On lines 1-8 we define the method `example` with one parameter. On line 10 we invoke the `example` method passing in the String object `'hello'` as an argument. On line 2, the local variable `i` is initialized to the Integer object `3`. The `i` local variable is local to the inner scope of the method definition. The `loop` method invocation on line 3 along with the `do...end` block passed into the method as an argument defines a block. Within the block, the `puts` method is invoked with the local variable `str` referencing the String object `hello` passed into it as an argument. On line 5, the local variable `i` is reassigned to the return value of calling the `Integer#-` method on `i` and passing in the Integer object `1` as an argument. This is Ruby's syntactical sugar for decrementing the value of the `i` local variable by 1. On line 6, the `break` keyword is used to exit the block if the statement 'local variable `i` is equal to the Integer object `0`' evaluates to true.

The output of this code would be:
```
hello
hello
hello
```
and the return value is `nil`.

### Example 5

```ruby
def greetings(str)
  puts str
  puts "Goodbye"
end

word = "Hello"

greetings(word)
```

On lines 1-4 we define the method `greetings` with one parameter. On line 6, the local variable `word` is initialized to the String object `"Hello"`. On line 8, the `greetings` method is invoked, passing the local variable `word` into the method as an argument. On line 2, the `puts` method is invoked, passing in the local variable `str` as an argument. This local variable references the same String object that the `word` variable references. This code demonstrates Ruby's local variable scoping rules, specifically the fact that variables initialized outside the scope of a method definition can be accessed inside the method definition if they are passed into the method at invocation as an argument.

The output of this could would be:
```
Hello
Goodbye
```
and the return value is `nil`.

### Example 6

```ruby
arr = [1, 2, 3, 4]
counter = 0
sum = 0

loop do
  sum += arr[counter]
  counter += 1
  break if counter == arr.size
end 

puts "Your total is #{sum}"
```

On line 1, the local variable `arr` is initialized to an Array object `[1, 2, 3, 4]`. On lines 2 & 3, the local variables `counter` and `sum` are both initialized to the Integer object 0.

On lines 5-9, the `loop` method invocation, along with the `do...end` structure passed into the `loop` method as an argument, defines a block. Within this block, on line 6 the `sum` local variable is reassigned to the return value of calling the `Integer#+` method on the `sum` local variable passing in the element in the Array that the local variable `arr` is referencing at the index with the value that the local variable `counter` is referencing. On line 7, the `counter` local variable is reassigned to the return value of calling the `Integer#+` method on the `counter` variable and passing in the Integer `1` as an argument. This is Ruby's syntactical sugar for incrementing the value of the `counter` variable by 1. On line 8, the `break` keyword is used to exit the block early if the statement "local variable `counter` is equal to the size of the Array that local variable `arr` is referencing" evaluates to `true`.

This code demonstrates Ruby's local variable scoping rules with regards to method invocation blocks, specifically the fact that variables initialized outside the scope of a method invocation block can be accessed inside the inner scope of the block.

### Example 7

```ruby
a = 'Bob'

5.times do |x|
  a = 'Bill'
end

p a
```
This code demonstrates Ruby's local variable scoping rules with respect to method invocation blocks, specifially that variables intialized in an outer scope are accesible to the inner scope of method invocation blocks.

On line 1, the local variable `a` is initialized to the String object `'Bob'`. On line 3, the `times` method is invoked on the Integer object `5`. This method invocation along with the `do...end` structure passed into the method invocation as an argument signifies a block. This block defines a new scope for local variables known as an inner scope. Within this inner scope, the local variable `a` is reassigned to the String object `'Bill'` on line 4. This is possible because local variable initialized in an outer scope are accessible to the inner scope of method invocation blocks.

Line 7 would output the value of the local variable `a`, which has been reassigned to the String object `'Bill'`. The return value would also be the String object `'Bill'` as the `p` method returns the value of calling the `Object#inspect` method on the Object passed into the method as an argument.

### Example 8

```ruby
animal = "dog"

loop do |_|
  animal = "cat"
  var = "ball"
  break
end

puts animal
puts var
```

This code demonstrates Ruby's local variable scoping rules with respect to method invocation blocks, specifically that variables initialized in an outer scope are accesible to the inner scope of the method invocation block, but that variables initialized in the inner scope of the block are not accesible outside the scope of said block.

On line 1, the local variable `animal` is initialzied to the String object `"dog"`. On line 3, the `loop` method is invoked and the `do...end` structure following the method invocation is passed into the method as an argument. This method invocation followed by the `do...end` block signifies a block and creates a new scope for local variables.

On line 4, the local variable `animal` is reassigned to the String object `"cat"`. This is possible because local variables initialized outside the inner scope of a method invocation block are accesible inside the inner scope of the block. On line 5, a new local variable `var` is initialized to the String object `"ball"`. This variable is local only to the inner scope of the block.

Line 9 would output the value of the `animal` local variable which has been reassigned to the String object `"cat"`. Line 10 would raise a NameError, `undefined local variable or method 'var'` as the `var` local variable is not accesible outside the inner scope of the `loop` method invocation block.

## Variable Shadowing

### Example 1

```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```

This code demonstrates Ruby's concept of variable shadowing with respect to method invocation blocks. Specifically that block parameters with the same name as local variables initialized outside the scope of the block can block access to those local variables inside the inner scope of a method invocation block.

On line 1, the local variable `a` is initialized to the Integer object `4`. On line 2, the local variable `b` is initialized to the Integer object `2`.

On line 4, the `times` method is called on the Integer object `2`, and the `do...end` structure with one parameter is passed to the `times` method as an argument. This method invocation along with the `do...end` block signifies a block and a new inner scope for local variables.

On line 5, a new local variable `a` is initialized to the Integer object `5`. The block parameter `a` blocks access to the outer scope local variable `a` and prevents that variable from being reassigned. This can be alleviated by renaming the block parameter `a` to any other name.

This code would output the following:
```
5
5
4
2
```
and the return value would be `nil`.

### Example 2

```ruby
n = 10

1.times do |n|
  n = 11
end

puts n
```

This code demonstrates Ruby's concept of variable shadowing with respect to method invocation blocks. Specifically that block parameters with the same name as local variables initialized outside the scope of the method invocation block can block access to the outer scope variables inside the inner scope of the method invocation block.

On line 1, the local variable `n` is initialzied to the Integer object `10`. On line 3 the `times` method is called on the Integer object `1` and the following `do...end` structure with one parameter is passed to the `times` meethod as an argument. Inside the `do...end` block on line 4, a new variable `n` local to the inner scope of the method invocation is initialized to the Integer object `11`.

On line 7, the `puts` method is called with the local variable `n` passed in as an argument. This outputs `10` as the block parameter `n` blocked access to the variable in the outer scope and the `n` outer scope variable was not reassigned inside the method invocation block.

### Example 3

```ruby
animal = "dog"

loop do |animal|
  animal = "cat"
  break
end

puts animal
```
This code demonstrates Ruby's concept of variable shadowing with respect to method invocation blocks. Specifically that block parameters with the same name as local variables initialzed outside the scope of a method invocation block can block access to those variables inside the inner scope of the method invocation block.

On line 1, the local variable `animal` is initialized to the String object `"dog"`. On line 3, the `loop` method is invoke and the following `do...end` structure with one parameter is passed into the `loop` method as an argument. This method invocation followed by the `do...end` block signifies a block.

Inside the `do...end` block, a new local variable `animal` is initialized to the String object `"cat"`. The block parameter `animal` blocks access to the local variable `animal` in the outer scope and prevents the inner scope from reassigning its value.

On line 8, the `puts` method is invoked passing in the local variable `animal` as an argument. This outputs `"dog"` and returns nil.

## Variables as Pointers / Object Passing

### Example 1

```ruby
a = "hi there"
b = a
a = "not here"
```

This code demonstrates Ruby's concept of variables as pointers, specifically that variables "reference" or "point to" an Object in memory.

On line 1, the local variable `a` is initialized to the String object `"hi there"`. On line 2, local variable `b` is initialized to the same String object that local variable `a` is referencing. Both variables currently reference the same Object in memory. On line 3, the local variable `a` is reassigned to the String object `"not here"`. Local variable `a` now references `"not here"` and local variable `b` still references `"hi there"`.

### Example 2

```ruby
a = "hi there"
b = a
a << ", Bob"
```
This code demonstrates Ruby's concepts of variables as pointers, and mutating vs. non-mutating methods. Specifically that variables "reference" an Object in memory, and that methods can either mutate their caller in place, or can return a reference to a new object.

On line 1, the local variable `a` is initialized to the String object `"hi there"`. One line 2, local variable `b` is initialized to the same String object that local variable `a` is referencing. Both variables currently reference the same object in memory. On line 3, the `String#<<` method is invoked on the String that local variable `a` is referencing. The `String#<<` method is a method that mutates its caller, that is local variable `a`. The result is that the String object `", Bob"` is concatenated to the String object that `a` and `b` both reference, and both local variables now reference the String object `"hi there, Bob"`.

### Example 3

```ruby
a = [1, 2, 3, 3]
b = a
c = a.uniq
```
This code demonstrates Ruby's concepts of variables as pointers, and mutating vs. non-mutating methods. Specifically that variables "reference" an Object in memory, and that methods can either mutate their caller in place, or can return a reference to a new object.

On line 1, local variable `a` is initialized to the Array object `[1, 2, 3, 3]`. On line 2, local variable `b` is initialized to the same Array object that local variable `a` references. On line 3, local variable `c` is initialized to the return value of calling the `Array#uniq` method on the Array that local variable `a` references. This is a non-mutating method that does not mutate the Array itself, but returns a new Array with the mutation to the calling Object. Local variables `a` and `b` now reference the Array object `[1, 2, 3, 3]` and local variable `c` references the Array object `[1, 2, 3]`.

### Example 4

```ruby
def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a)
```

This code demonstrates Ruby's concept of mutating vs. non-mutating methods.

On lines 1-3 the method `test` is defined with one parameter. On line 5, local variable `a` is initialized to the Array object `['a', 'b', 'c']`. On line 6, the `test` method is invoked with the Array that local variable `a` references passed into the method as an argument.

On line 2, the `Array#map` method is called on the Array passed into the method as an argument. The `{...}` structure with one parameter is passed into the `map` method as an argument. The `map` method invocation along with the `{...}` defines a block. The `map` method iterates through the array it was called on, and passes each element to the block as an argument. The `map` method captures the return value of the block after each iteration and stores the value in a new array. Once the iteration is completed, the `map` method returns the new array.

The return value of this code would be `["I like the letter: a", "I like the letter: b", "I like the letter: c"]`. However, `map` is a non-mutating method and the value of local variable `a` would be unchanged and still refer to the Array object `['a', 'b', 'c']`.

### Example 5
```ruby
a = 5.2
b = 7.3
a = b
b += 1.1
```
This code demonstrates Ruby's concept of variables as pointers and mutating vs. non-mutating methods. Specifically that variables in Ruby "point to" or "reference" Objects in memory, and methods can either mutate the Object directly or return a reference to a new object.

On line 1, local variable `a` is initialized to the Float object `5.2`. On line 2, local variable `b` is initialized to the Float object `7.3`. On line 3, local variable `a` is reassigned to the Float object that local variable `b` references.

On line 4, local variable `b` is reassigned to the return value of calling the `Float#+` method on the Object that local variable references, passing in `1.1` as an argument. The `Float#+` method is a non-mutating method and returns a reference to a new object. In fact, Float objects are immutable, and any method called on them returns a reference to a new-object.

Local variable `a` now references `7.3` and local variable `b` now references `8.4`.

### Example 6
```ruby
def test(str)
  str  += '!'
  str.downcase!
end

test_str = 'Written Assessment'
test(test_str)

puts test_str
```

This code demonstrates Ruby's concept of variables as pointers and mutating vs. non-mutating methods. Specifically that variables in Ruby "point to" or "reference" Objects in memory, and methods can either mutate the Object directly or return a reference to a new Object.

On lines 1-4 the method `test` is defined with one parameter. On line 6, the local variable `test_str` is initialized to the String object `'Written Assessment'`. On line 7, the `test` method is invoked, and the local variable `test_str` is passed in as an argument to the method. Upon invocation of the `test` method, the method parameter `str` now references the same Object that `test_str` references.

On line 2, the variable `str`, local to the method definition scope is reassigned to the return value of calling the `String#+` method on the `str` variable and passing in `'!'` as an argument. The `String#+` method is non-mutating, and returns a new String object which `str` now references. The variable reassignment on line 2 has the side of effect of causing `str` to no longer reference the String object that `test_str` references. On line 3, the `String#downcase!` method is called on the `str` local variable. The return value of this method would be `'written assessment!'`. On line 9, the `puts` method is invoked, passing in the `test_str` variable as an argument. This would output the String object `'Written Assessment'` as `test_str` was not mutated after the method variable reassignment on line 2.

### Example 7

```ruby
def plus(x, y)
  x = x + y
end

a = 3
b = plus(a, 2)
puts a
```

This code demonstrates Ruby's concept of variables as pointers and mutating vs. non-mutating methods. Specifically that variables in Ruby "point to" or "reference" Objects in memory, and methods can either mutate the Object directly or return a reference to new Object.

On lines 1-3, the `plus` method is defined with two paramenters. On line 5, the local variable `a` is initialized to the Integer object `3`. On line 6, local variable `b` is initialized to the return value of invoking the `plus` method, passing in local variable `a` as the `x` argument, and the Integer object `2` as the `y` argument.

On line 2, the method local variable `x` is re-assigned to the return value of calling the `Integer#+` method on the method local variable `x` with the Integer that `y` references as an argument. The side effect of this reassignment is that `x` no longer references the same Integer object that `a` references. Thus, on line 7, the when the `puts` method is invoked and passed the local variable `a` as a reference, the output is `3`.

### Example 8
```ruby
def increment(x)
  x << 'b'
end

y = 'a'
increment(y) 

puts y
```

This code demonstrates Ruby's concept of variable as pointers and mutating vs. non-mutating methods. Specifically that variables in Ruby "point to" or "reference" Objects in memory, and methods can either mutate the Object they were called on directly, or return a reference to a new Object.

On lines 1-3, the method `increment` is defined with one parameter. On line 5, the local variable `y` is initialized to the String object `'a'`.

On line 6, the `increment` method is invoked with the local variable `y` passed in as an argument. Upon invocation of the `increment` method, the method local variable `x` references the String that the `y` local variable references. On line 2, the mutating method `String#<<` is called on the String that `x` references. This method mutates its caller and concatenates `'b'` to the String the variable references.

On line 8, the `puts` method is invoked with the local variable `y` passed in as an argument. Since the String that `y` references was mutated by the `String#<<` method in the `increment` method invocation, the output is `'ab'`.

### Example 9

```ruby
def change_name(name)
  name = 'bob'      # does this reassignment change the object outside the method?
end

name = 'jim'
change_name(name)
puts name 
```

This code demonstrates Ruby's concept of variables as pointers, that is that variables in Ruby "point to" or "reference" Objects in memory.

On lines 1-3, the method `change_name` is defined with one parameter. On line 5, the local variable `name` is initialized to the String object `'jim'`. On line 6, the `change_name` method is invoked, passing in the `name` local variable as an argument. Upon invocation of the method, the method parameter `name` references the same String object that the local variable `name` references.

On line 2, the method parameter variable `name` is reassigned to the String object `'bob'`. This reassignment has the side effect of causing the method parameter variable `name` to no lonnger reference the same String object that the local variable `name` references.

On line 7, the `puts` method is invoked and the local variable `name` is passed in as an argument. Due to the reassignment on line 2, the local variable `name` still references the String object `'jim'` and the `puts` method outputs `'jim'`.

### Example 10

```ruby
a = [1, 3]
b = [2]
arr = [a, b]
arr

a[1] = 5
arr
```
This code demonstrates Ruby's concept of variables as pointers, that is to say that variables in Ruby "point" to or "reference" an object in memory.

On line 1, local variable `a` is initialized to the Array object `[1, 3]`. On line 2, local variable `b` is initialized to the Array object `[2]`. On line 3, the local variable `arr` is initialized to a nested Array object containing the Array objects that local variables `a` and `b` reference.

On line 4, calling `arr` would return `[[1, 3], [2]]`.

On line 6, the `Array#[]=` indexed assignment method is called on the element of the Array referenced by local variable `a` at index 1, passing in the Integer object `5` as an argument. This is a mutating method that directly mutates the Array the method was called on. Because it is a mutating method, the `a` local variable now references an Array object `[1, 5]` and the `arr` local variable references the same object at its index 0.

On line 7, calling `arr` would return `[[1, 5], [2]]`.

### Example 11
```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

puts arr1 
puts arr2
```
This code demonstrates Ruby's concept of variables as pointers as well as mutating vs. non-mutating methods. That is to say that variables in Ruby "point to" or "reference" an object in memory, and methods can either mutate their caller in place, or return a new object.

On line 1, the local variable `arr1` is initialized to an Array object `["a", "b", "c"]`. On line 2, the local variable `arr2` is initialized to the return value of calling the `Object#dup` method on the Array object that `arr1` references. This creates a shallow copy of the Array that `arr1` references and assigns it to the `arr2` local variable.

On line 3, the `Array#map!` method is called on the `arr2` local variable, and the following `do...end` structure is passed into the method as an argument with one parameter. This method invocation followed by `do...end` defines a block. The `map!` method iterates over the Array it was called on and passes each element to the block as the `char` parameter. The `map!` method captures the return value of the block with each iteration and mutates the Array in place, mutating each element to the return value of the block after that element is passed to it. In this case, the element would be mutated to the return value of calling the `String#upcase` method on it.

Due to the `Object#dup` method call on line 2, the `puts` method invocation on line 7 with the local variable `arr1` passed to it as an argument would output:
```
a
b
c
```
while tthe `puts` method invocation on line 8 with the local variable `arr2` passed to it as an argument would output:
```
A
B
C
```