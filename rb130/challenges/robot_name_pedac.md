Write a program that manages robot factory settings.

When robots come off the factory floor, they have no name. The first time you boot them up, a random name is generated, such as RX837 or BC811.

Every once in a while, we need to reset a robot to its factory settings, which means that their name gets wiped. The next time you ask, it will respond with a new random name.

The names must be random; they should not follow a predictable sequence. Random names means there is a risk of collisions. Your solution should not allow the use of the same name twice when avoidable.

# Understand the Problem

Create a class that manages robot settings. When a new robot object is initialized, it will have a @name instance variable randomly generated.

The robot class should have an instance method to reset a robot to its factory settings, which means re-randomizing the name.

When a new name is generated, there should be a way to compare it to currently used names to make sure there are no duplicates.

# Examples

See test cases

Robot names should be in the format of [A-Z][A-Z][0-9][0-9][0-9]

# Data Structures

No input or output

# Algorithm

class Robot

constructor
- No parameters
- @name instance variable should be randomly assigned in the appropriate format
- Add @name to a Robot class variable of used names that can be queried with new robots to ensure no collision

instance methods
- `reset` to reset the robot's name and assign a new randomly generated name