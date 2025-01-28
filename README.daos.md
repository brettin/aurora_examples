### Setting up a Daos Container

```
module use /soft/modulefiles
module load daos/base

daos pool query candle_aesp_CNDA
env|grep DRPC
ps -ef|grep daos|grep -v grep

daos cont list candle_aesp_CNDA
# daos cont create --type PYTHON candle_aesp_CNDA uno
# daos cont create --type POSIX candle_aesp_CNDA uno_posix
```

### Mounting the container on the filesystem
```
mkdir -p $HOME/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/uno_posix
dfuse --pool=candle_aesp_CNDA --cont=uno_posix -m $HOME/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/uno_posix
```


### Running tests writing to the mounted daos container, the underlying filesystem, and /dev/shm
```
# Run the text below in each of these locations
cd ~/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/uno_posix
cd ~/CSC249ADOA01_CNDA/brettin/
cd /dev/shm
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

### Running on Aurora Prod Jan 28, 2025

#### Running on a dfuse mounted daos type posix container

```
0.00user 0.00system 0:00.01elapsed 58%CPU (0avgtext+0avgdata 3348maxresident)k
0.00user 0.05system 0:00.06elapsed 93%CPU (0avgtext+0avgdata 3364maxresident)k
0.00user 0.52system 0:00.52elapsed 99%CPU (0avgtext+0avgdata 3236maxresident)k
0.01user 5.25system 0:05.27elapsed 99%CPU (0avgtext+0avgdata 3364maxresident)k
```

#---

time dd if=/dev/zero of=./filename.10 bs=1M count=10

10485760 bytes (10 MB, 10 MiB) copied, 0.00732875 s, 1.4 GB/s
0.00user 0.00system 0:00.01elapsed 58%CPU (0avgtext+0avgdata 3348maxresident)k

0inputs+20480outputs (0major+591minor)pagefaults 0swaps

---

time dd if=/dev/zero of=./filename.100 bs=1M count=100

104857600 bytes (105 MB, 100 MiB) copied, 0.0585312 s, 1.8 GB/s
0.00user 0.05system 0:00.06elapsed 93%CPU (0avgtext+0avgdata 3364maxresident)k

0inputs+204800outputs (0major+592minor)pagefaults 0swaps

---

time dd if=/dev/zero of=./filename.1000 bs=1M count=1000

1048576000 bytes (1.0 GB, 1000 MiB) copied, 0.524146 s, 2.0 GB/s
0.00user 0.52system 0:00.52elapsed 99%CPU (0avgtext+0avgdata 3236maxresident)k
0inputs+2048000outputs (0major+592minor)pagefaults 0swaps

---

time dd if=/dev/zero of=./filename.10000 bs=1M count=10000
10485760000 bytes (10 GB, 9.8 GiB) copied, 5.26629 s, 2.0 GB/s

0.01user 5.25system 0:05.27elapsed 99%CPU (0avgtext+0avgdata 3364maxresident)k

0inputs+20480000outputs (0major+592minor)pagefaults 0swaps


