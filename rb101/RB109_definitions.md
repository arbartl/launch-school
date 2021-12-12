- local variable scope, especially how local variables interact with method invocations with blocks and method definitions
- mutating vs non-mutating methods, pass-by-reference vs pass-by-value
- working with collections (Array, Hash, String), and popular collection methods (each, map, select, etc). Review the two lessons on these topics thoroughly.
- variables as pointers
- puts vs return
- false vs nil and the idea of "truthiness"
- method definition and method invocation
- implicit return value of method invocations and blocks
- how the Array#sort method works


# Examples

## Variable Scope & Assignment

### Variable Assignment

`a = 5`

Local variable `a` is initialized to the Integer object `5`

### Variable Reassignment

```ruby
a = 'string'
b = a
a = 5
```

On line 1, a local variable `a` is initialized to the String object with a value of 'string'.

On line 2, a local variable `b` is initialized to the String object that local variable `a` is referencing. Both local variables `a` and `b` now reference the same object.

On line 3, local variable `a` is reassigned to the Integer object `5`.

Local variable `b` references the String object with a value of 'string' and local variable `a` references the Integer object `5`.

### Local Scope with Blocks

```ruby
a = 1

loop do
  a = 2
  b = 3
  break
end

puts a
puts b
```

On line 1, a local variable `a` is initialized and assigned to the Integer object `1`.

On line 3, we invoke the `loop` method, passing in the `do...end` block on lines 3-7.

On line 4, we reassign the local variable `a` to the Integer object `2`. This can be done as the block can access variables initialized outside of its inner scope.

On line 5, a local variable `b` is initialized and assigned to the Integer object `3`.

On line 6, we break out of the loop using the keyword `break`.

On lines 8 and 9 we invoke the `puts` method, passing in the local variables `a` and `b` as arguments.

This code block would output `2` and raise a NameError, `undefined local variable or method b`. The local variable `b` was initialized in the inner scope of the `do...end` block, and the `puts` method cannot access variables local to the inner scrope of the `do...end` block.

### Local Scope with Method Definitions

```ruby
a = 1

def my_method
  a = 5
  puts a
end

puts a
```

On line 1, a local variable `a` is initialized and assigned to the Integer object `1`.

On line 3 - 6, we define the method `my_method` with no parameters.

On line 4, a new variable `a`, local to the method, is initialized and assigned to the Integer object `5`.

On line 5, the `puts` method is invoked with the local variable `a` passed in as an argument.

On line 8, the `puts` method is invoked with the local variable `a` passed in as an argument.

This code block would output `1` and return `nil`. The `my_method` method does not have access to variables in the outer scope that are not passed into the method as arguments. Since this method has no parameters through which to pass arguments, it cannot access the variable local to the outer scope, and initializes a new variable `a` in its inner scope. This does not affect the local variable `a` initialized on line 1.

## Mutating vs Non-Mutating Methods / Pass-By-Reference vs Pass-By-Value

### Mutating Methods

Mutating Methods are said to "mutate their caller" and make permanent modifications to the value or state of the Object that they are called on. Many mutating methods are appended with the `!` character, but this is not always the case. The important distinction is in the return value of the method. If the method returns the object on which it was called, with any modifications intact, it is said to be a mutating method.

#### Indexed Assignment

```ruby
str[1] = 'a'
arr[2] = 5
hash[:name] = "Name"
```
At first, the above code appears to be Assigning or Reassigning, which is non-mutating. In reality, this is a method call `#[]=` which mutates the Object on which it is called by reassigning the element to the Object passed in as an argument. The calling object will be mutated in place and be considered the same object.

### Non-Mutating Methods

Non-mutating methods return a **NEW** instance of the object they are called on. This new instance can be assigned to a variable, but the original object on which the method was called remains unchanged.

#### Re-Assignment

Re-assignment "operators" such as `+=` and `-=` are considered non-mutating methods. In reality, `i += 5` is ruby's syntactical sugar for `i = i + 5`. `i` is re-assigned to the return value of calling the `Integer#+` method on `i` and passing in `5` as an argument. The return value is re-assigned to `i` causing `i` to reference a new object.

### Concatentation

An important thing to remember is regarding concatentation. As mentioned above, `+=` *performs* concatenation, but is a non-mutating method and returns a **new** Object. However, the methods `<<` and `#concat` are **mutating** methods and make changes directly to the Object on which they are callled.

```ruby
str = 'abc'
str.object_id #200

str += 'd' #'abcd'
str.object_id #220

str << 'e' #'abcde'
str.object_id #220

str.concat('f') #'abcdef'
str.object_id #220
```

## Method Definition and Invocation

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

On line 1 we are initializing the local variable `i` and assigning it to the Integer object `0`. On line 2, we are reassigning the local variable `i` to the return value of value of a method invocation of `Integer#+` on the local variable `i` with the Integer object `5` passed to it as an argument.

## Common Collection Methods

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
We are invoking the `Array#select` method on the Array object `[1, 2, 3, 4]` and passing the `{...}` block into the method with one parameter. The `select` method iterates through the Array object, passes each element of the Array to the block as an argument, and runs the block. If the block **evaluates** to `true`, the `select` method moves that element to a new array. After completing the iteration, the `select` method returns the new array with the elements that caused the block to evaluate to `true`. The `puts` method always returns `nil` which evaluates to `false`, so the output of this method would be:
```
1
2
3
4
```
and the return value would be `[]`.

#### `Array#reject` Method

The `Array#reject` methods performs similarly to the `#select` method, but returns an array of elements for which the block evaluates to `false`. In the above case, the output would be `[1, 2, 3, 4]` as each element evalues to `false` when the puts method is called passing it in as an argument.

### `Enumerable#reduce` / `Enumberable#inject` Method

```ruby
[1, 2, 3, 4].reduce { |memo, el| memo + el }
```
We are invoking the `Enumerable#reduce` method on the Array object `[1, 2, 3, 4]` and passing the `{...}` block into the method with two parameters. The `reduce` method iterates through the Array object, and passes each element of the Array to the block as the `el` argument. The return value of the block is assigned to `memo` after each iteration. After all iterations, the `reduce` method returns the value of `memo`. There would be no output of this method, and the return value would be: `10`.


## `puts` vs `p`

`puts` and `p` both output the argument passed into the method to the standard output. The difference between these two is that `p` appends the `Object#inspect` method to the Object passed in as an argument before outputting the return of this method to the standard output.

There is also an **important** difference in the return value of the two methods. `puts` always returns `nil`, whereas `p` returns the Object that was passed into it as an argument. This is important for methods that rely on the return value of a block, such as `Array#select`, as well as implicit returns of methods or blocks.