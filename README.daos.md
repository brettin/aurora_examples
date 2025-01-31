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


