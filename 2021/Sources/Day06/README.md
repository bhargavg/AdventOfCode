#  Day06

**Thought process:**

1. Tried to comeup with a mathematical formula to figure out how many fishes can be spawned from a single one.
2. Couldn't figure out, thought about brute-force, ie., simulating the whole spawning process by advancing a day at a time. This won't be optimal as the outputs could be huge.
3. Brute force method can be optimized though; instead of going through each day, we can skip days if we know that they are non-spawning. This could be done through a `Min Heap`. The root will be the one about to spawn.
    1. Advance by root value, ie., subtract the root value from all nodes
    2. Remove root
    3. Add a `6` (this fish's timer resets)
    4. Add a `8` (new fish's timer)
4. Heap solution above isn't optimal either, as we have to walk through every item (to reduce it's value) when every a fish spawns. **Key point: Given a start value, we can figure out how many times a fish spawns.** Using this idea:

    1. Loop through each fish's counter
    2. Figure out then days in which this fish will spawn
    3. Add those many (8 + offset) values to the original count's array. This offset is required because we do the calculations from 0th day and not from the day this fish is spawned
    4. Do this till the entire array is exhausted
    5. The final array will contain fish counts on last day
5. Above solution works for smaller inputs, but for larger one (puzzle's input), we will endup needing an array of more than 20GB. We infact don't need to save this array at all. Because we know how many fishes a single fish can spawn, we do a dfs to count all grandchildren from the given fish. Adding a `memo` into the mix, we could run pretty quickly even on large inputs.

