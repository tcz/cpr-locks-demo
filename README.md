# Simple Locks in Erlang

This repository was created to demonstrate n>2 lock acquiring in Erlang using `global:set_lock` 
which was a debated point in my CPR assignment at Oxford.

The lock mechanism is the same I used in the assignment, except it was simplified
to exclude the chatroom related code.

## How to run?

1. Open 3 terminal windows
2. Run the following commands in each of the windows respectively:
   - `bin/compile_and_run_lock_1`
   - `bin/compile_and_run_lock_2`
   - `bin/compile_and_run_lock_3`
3. When all of them are running, press ENTER in each of them (avoid waiting too much)in a
in an arbitary order.
4. IDs will not collide and will be assigned in the order in which you pressed ENTER

## Demonstration 1

In this instance I pressed ENTER in the following order: run_lock_1, run_lock_2, run_lock_3

Outputs:

### run_lock_1

```
% bin/compile_and_run_lock_1
Process 1 connected
Other nodes: []
Run the other nodes now if it's not yet running...
Press ENTER when done

Acquired lock {{test_lock_id,1},'run_lock_1@Zoltans-MacBook-Pro'}
Process 1 received ID: 1
Press ENTER to exit
```

### run_lock_2

```
% bin/compile_and_run_lock_2
Process 2 connected
Other nodes: ['run_lock_1@Zoltans-MacBook-Pro']
Run the other node now if it's not yet running...
Press ENTER when done

Failed to acquire lock {{test_lock_id,1},'run_lock_2@Zoltans-MacBook-Pro'}
Acquired lock {{test_lock_id,2},'run_lock_2@Zoltans-MacBook-Pro'}
Process 2 received ID: 2
Press ENTER to exit
```

### run_lock_3

```
% bin/compile_and_run_lock_3
Process 3 connected
Other nodes: ['run_lock_1@Zoltans-MacBook-Pro',
              'run_lock_2@Zoltans-MacBook-Pro']
Run the other nodes now if it's not yet running...
Press ENTER when done

Failed to acquire lock {{test_lock_id,1},'run_lock_3@Zoltans-MacBook-Pro'}
Failed to acquire lock {{test_lock_id,2},'run_lock_3@Zoltans-MacBook-Pro'}
Acquired lock {{test_lock_id,3},'run_lock_3@Zoltans-MacBook-Pro'}
Process 3 received ID: 3
Press ENTER to exit
```

## Demonstration 2

In this instance I pressed ENTER in the following order: run_lock_2, run_lock_3, run_lock_1

Outputs:

### run_lock_1

```
 % bin/compile_and_run_lock_1
Process 1 connected
Other nodes: []
Run the other nodes now if it's not yet running...
Press ENTER when done

Failed to acquire lock {{test_lock_id,1},'run_lock_1@Zoltans-MacBook-Pro'}
Failed to acquire lock {{test_lock_id,2},'run_lock_1@Zoltans-MacBook-Pro'}
Acquired lock {{test_lock_id,3},'run_lock_1@Zoltans-MacBook-Pro'}
Process 1 received ID: 3
Press ENTER to exit
```

### run_lock_2

```
% bin/compile_and_run_lock_2
Process 2 connected
Other nodes: ['run_lock_1@Zoltans-MacBook-Pro']
Run the other node now if it's not yet running...
Press ENTER when done

Acquired lock {{test_lock_id,1},'run_lock_2@Zoltans-MacBook-Pro'}
Process 2 received ID: 1
Press ENTER to exit
```

### run_lock_3

```
 % bin/compile_and_run_lock_3
Process 3 connected
Other nodes: ['run_lock_1@Zoltans-MacBook-Pro',
              'run_lock_2@Zoltans-MacBook-Pro']
Run the other nodes now if it's not yet running...
Press ENTER when done

Failed to acquire lock {{test_lock_id,1},'run_lock_3@Zoltans-MacBook-Pro'}
Acquired lock {{test_lock_id,2},'run_lock_3@Zoltans-MacBook-Pro'}
Process 3 received ID: 2
Press ENTER to exit
```
