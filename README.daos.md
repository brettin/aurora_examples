## Details behind shell scripts in daos/mount_local.sh series of scripts.

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
