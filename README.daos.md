```
brettin@x4219c0s5b0n0:~/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/uno_posix> 
```

```
for n in $(seq 1 4) ; do 
  COUNT=$((10**$n)) ;
  CMD="time dd if=/dev/zero of=./filename.$COUNT bs=1M count=$COUNT" ;
  echo $CMD ;
  $CMD ;
done
```

```
time dd if=/dev/zero of=./filename.10 bs=1M count=10
time dd if=/dev/zero of=./filename.100 bs=1M count=100
time dd if=/dev/zero of=./filename.1000 bs=1M count=1000
time dd if=/dev/zero of=./filename.10000 bs=1M count=10000
```

### Running on a dfuse mounted daos type posix container
```
0.00user 0.02system 0:00.41elapsed 5%CPU (0avgtext+0avgdata 3320maxresident)k
0.00user 0.09system 0:00.48elapsed 19%CPU (0avgtext+0avgdata 3400maxresident)k
0.00user 0.78system 0:01.24elapsed 63%CPU (0avgtext+0avgdata 3464maxresident)k
0.02user 4.64system 2:07.48elapsed 3%CPU (0avgtext+0avgdata 3268maxresident)k

0.00user 0.02system 0:00.39elapsed 5%CPU (0avgtext+0avgdata 3148maxresident)k
0.00user 0.09system 0:00.47elapsed 18%CPU (0avgtext+0avgdata 3148maxresident)k
0.00user 0.76system 0:01.22elapsed 62%CPU (0avgtext+0avgdata 3404maxresident)k
0.02user 4.81system 2:05.56elapsed 3%CPU (0avgtext+0avgdata 3208maxresident)k

0.00user 0.02system 0:00.41elapsed 5%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 0.09system 0:00.47elapsed 19%CPU (0avgtext+0avgdata 3336maxresident)k
0.00user 0.76system 0:01.20elapsed 63%CPU (0avgtext+0avgdata 3316maxresident)k
0.02user 4.91system 2:03.47elapsed 3%CPU (0avgtext+0avgdata 3256maxresident)k
```

### Running the command on the lustre filesystem
```
0.00user 0.01system 0:00.33elapsed 6%CPU (0avgtext+0avgdata 3400maxresident)k
0.00user 0.08system 0:00.40elapsed 22%CPU (0avgtext+0avgdata 3268maxresident)k
0.00user 0.87system 0:01.19elapsed 73%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 8.49system 0:08.81elapsed 96%CPU (0avgtext+0avgdata 3332maxresident)k

0.00user 0.02system 0:00.32elapsed 6%CPU (0avgtext+0avgdata 3404maxresident)k
0.00user 0.09system 0:00.39elapsed 24%CPU (0avgtext+0avgdata 3272maxresident)k
0.00user 0.81system 0:01.12elapsed 72%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 8.28system 0:08.60elapsed 96%CPU (0avgtext+0avgdata 3208maxresident)k

0.00user 0.02system 0:00.30elapsed 6%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 0.09system 0:00.38elapsed 24%CPU (0avgtext+0avgdata 3464maxresident)k
0.00user 0.83system 0:01.13elapsed 73%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 7.86system 0:08.16elapsed 96%CPU (0avgtext+0avgdata 3336maxresident)k
```

### Running the command on /dev/shm
```
0.00user 0.01system 0:00.26elapsed 6%CPU (0avgtext+0avgdata 3400maxresident)k
0.00user 0.05system 0:00.33elapsed 16%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 0.42system 0:00.69elapsed 60%CPU (0avgtext+0avgdata 3208maxresident)k
0.00user 4.10system 0:04.34elapsed 94%CPU (0avgtext+0avgdata 3464maxresident)k

0.00user 0.01system 0:00.30elapsed 6%CPU (0avgtext+0avgdata 3340maxresident)k
0.00user 0.05system 0:00.31elapsed 17%CPU (0avgtext+0avgdata 3156maxresident)k
0.00user 0.41system 0:00.70elapsed 59%CPU (0avgtext+0avgdata 3460maxresident)k
0.00user 4.01system 0:04.29elapsed 93%CPU (0avgtext+0avgdata 3404maxresident)k

0.00user 0.01system 0:00.25elapsed 7%CPU (0avgtext+0avgdata 3400maxresident)k
0.00user 0.05system 0:00.41elapsed 13%CPU (0avgtext+0avgdata 3148maxresident)k
0.00user 0.42system 0:00.68elapsed 61%CPU (0avgtext+0avgdata 3404maxresident)k
0.00user 4.09system 0:04.36elapsed 93%CPU (0avgtext+0avgdata 3336maxresident)k
```

![image](https://github.com/brettin/aurora_examples/assets/991769/93959f7d-81ce-4f33-ba3c-7d25f7bbe27f)


