- local variable scope, especially how local variables interact with method invocations with blocks and method definitions
- mutating vs non-mutating methods, pass-by-reference vs pass-by-value
- working with collections (Array, Hash, String), and popular collection methods (each, map, select, etc). Review the two lessons on these topics thoroughly.
- variables as pointers
- puts vs return
- false vs nil and the idea of "truthiness"
- method definition and method invocation
- implicit return value of method invocations and blocks
- how the Array#sort method works


## Examples

### Variable Assignment

`a = 5`

Local variable `a` is initialized and assigned to the Integer object `5`

### Variable Reassignment

```ruby
a = 'string'
b = a
a = 5
```

On line 1, a local variable `a` is initialized and assigned to the String object with a value of 'string'.

On line 2, a local variable `b` is initialized and assigned to the String object that local variable `a` is referencing. Both local variables `a` and `b` now reference the same object.

On line 3, local variable `a` is reassigned to the Integer object `5`.

Local variable `b` references the String object with a value of 'string' and local variable `a` references the Integer object `5`.

### Method Definition

```ruby
def my_method(int)
  puts int
end
```

We are defining the method `my_method` which takes 1 non-optional parameter.

### Method Invocation

`my_method(5)`

We are invoking the `my_method` method and passing in the Integer object `5` as an argument to it.

### Loop Method and Passing Block as Argument

```ruby
loop do
  puts 'Hello'
  break
end
```

On line 1 we are invoking the `loop` method and passing in the `do...end` block as an argument.

On line 2 we are invoking the `puts` method and passing in the String object 'Hello' as an argument.

On line 3 we use the keyword `break` to break out of the `loop` method.

### Reassignment with Method Call

```ruby
i = 0
i += 5
```

On line 1 we are initializing the local variable `i` and assigning it to the Integer object `0`. On line 2, we are reassigning tje local variable `i` to the return value of value of a method invocation of `Integer#+` on the local variable `i` with the Integer object `5` passed to it as an argument.

### `Array#each` Method

```ruby
[1, 2, 3, 4].each { |num| puts num }
```
We are invoking the `Array#each` method on the Array object `[1, 2, 3, 4]` and passing the `{...}` block into the method with one parameter. The `each` method iterates through the Array object, passes each element of the Array to the block as an argument, and runs the block. After completing the iteration, the `each` method returns the original Array object, and doesn't care about the return value of the block itself. The output of this method would be:
```
1
2
3
4
```
and the return value would be `[1, 2, 3, 4]`.

### `Array#map` Method

```ruby
[1, 2, 3, 4].map { |num| puts num }
```
We are invoking the `Array#map` method on the Array object `[1, 2, 3, 4]` and passing the `{...}` block into the method with one parameter. The `map` method iterates through the Array object, passes each element of the Array to the block as an argument, and runs the block. The `map` method collects the return value of the block on each iteration and stores it inside of a new array. After completing the iteration, the `map` method returns the new array. The `puts` method always returns `nil`, so the output of this method would be:
```
1
2
3
4
```
and the return value would be `[nil, nil, nil, nil]`.

### `Array#select` Method

```ruby
[1, 2, 3, 4].select { |num| puts num }
```
We are invoking the `Array#select` method on the Array object `[1, 2, 3, 4]` and passing the `{...}` block into the method with one parameter. The `select` method iterates through the Array object, passes each element of the Array to the block as an argument, and runs the block. If the block **evaluates** to `true`, the `select` method moves that element to a new array. After completing the iteration, the `select` method returns the new array with the elements that caused the block to evaluate to `true`. The `puts` method always returns `nil` which evalues to `false`, so the output of this method would be:
```
1
2
3
4
```
and the return value would be `[]`.