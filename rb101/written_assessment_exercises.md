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
On line 1, the local variable `a` is initialized and assigned to the Integer object `4`. The `loop` method is invoked on line 3 and the following `do...end` block is passed into the method as an argument. On line 4, the local variable `a` is reassigned to the Integer object `5`. This reassignment is possible because the local variable `a` is accesible inside of the `do...end` block as it was defined outside of the block. On line 5, the local variable `b` is initialized and assigned to the Integer object `3`. On line 6, the `break` keyword is used to break out of the `loop` method.

Lines 8 and 9 output the following:
```
5
3
```
and the return value is `nil`.