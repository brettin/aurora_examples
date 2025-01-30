Here is the set of commands that will mount your container
on all nodes.

'''
# change this:
cd CSC249ADOA01_CNDA/brettin/aurora_examples/daos/

source env_daos.sh 
launch-dfuse.sh ${DAOS_POOL_NAME}:${DAOS_CONT_NAME}
mpiexec --no-vni -n 400 -ppn 1 ./write_to_mount.sh
clean-dfuse.sh  ${DAOS_POOL_NAME}:${DAOS_CONT_NAME}
mpiexec -n2 -ppn 1 ls -l /tmp/$DAOS_POOL/$DAOS_CONT
'''


##  VARIOUS COMMANDS

### On both login and compute hosts, and set in env_daos.sh

'''
module use /soft/modulefiles
module load daos/base
# change this
DAOS_POOL=candle_aesp_CNDA
DAOS_CONT=brettin_posix
'''


### list existing containers in DAOS_POOL
daos container list $DAOS_POOL

### create a new container
daos container create --type POSIX $DAOS_POOL $DAOS_CONT --properties rd_fac:1
daos container list $DAOS_POOL

# 2. mount on login node
mkdir -p /lus/flare/projects/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/$DAOS_CONT
start-dfuse.sh -m /lus/flare/projects/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/$DAOS_CONT --pool $DAOS_POOL --cont $DAOS_CONT

# 3. put stuff in the container
for n in $(seq 1 4) ; do
        COUNT=$((10**$n)) ;
        CMD="time dd if=/dev/zero of=./$(hostname).filename.$COUNT bs=1M count=$COUNT" ;
        echo $CMD ;
        $CMD ;
done

### On compute host
qsub -l select=2 -l walltime=30:00 -A candle_aesp_CNDA -q debug -ldaos=daos_user -l filesystems=flare:daos_user -I
# qsub -l select=2 -l walltime=01:00:00 -A Aurora_deployment -k doe -ldaos=daos_user -l filesystems=flare:daos_user -q lustre_scaling -I

module use /soft/modulefiles
module load daos/base

DAOS_POOL=candle_aesp_CNDA
DAOS_CONT=brettin_posix


# 1. mount on compute nodes
ls /tmp/${DAOS_POOL}/${DAOS_CONT}
mkdir -p /tmp/${DAOS_POOL}/${DAOS_CONT}
start-dfuse.sh -m /tmp/${DAOS_POOL}/${DAOS_CONT} --pool ${DAOS_POOL} --cont ${DAOS_CONT}

# launched using pdsh on all compute nodes mounted at: /tmp/<pool>/<container>
launch-dfuse.sh ${DAOS_POOL_NAME}:${DAOS_CONT_NAME} 

# To confirm if its mounted
mount | grep dfuse

ls /tmp/${DAOS_POOL}/${DAOS_CONT}/

clean-dfuse.sh  ${DAOS_POOL_NAME}:${DAOS_CONT_NAME} # To unmount on all nodes




# 2. put stuff in the container
cd /tmp/${DAOS_POOL}/${DAOS_CONT}
for n in $(seq 1 4) ; do
	COUNT=$((10**$n)) ;
	CMD="time dd if=/dev/zero of=./$(hostname).filename.$COUNT bs=1M count=$COUNT" ;
	echo $CMD ;
	$CMD ;
done

# to unmount on compute nodes
cd
fusermount3 -u /tmp/candle_aesp_CNDA/brettin_posix/

# to unmount on login host
cd
fusermount3 -u /lus/flare/projects/CSC249ADOA01_CNDA/brettin/CSC249ADOA01_CNDA/$DAOS_CONT

# destroy (after unmounting)
daos container destroy --force $DAOS_POOL $DAOS_CONT

