# aurora_examples


# qsub -l select=2 -l walltime=30:00 -A CSC249ADOA01_CNDA -q EarlyAppAccess -I


export HTTP_PROXY=http://proxy.alcf.anl.gov:3128
export HTTPS_PROXY=http://proxy.alcf.anl.gov:3128
export http_proxy=http://proxy.alcf.anl.gov:3128
export https_proxy=http://proxy.alcf.anl.gov:3128
git config --global http.proxy http://proxy.alcf.anl.gov:3128


module use /soft/modulefiles
module load frameworks


PYTHONPATH=$PYTHONPATH:.
PYTHONPATH=$PYTHONPATH:/lus/gecko/projects/CSC249ADOA01_CNDA/brettin/Benchmarks/Pilot1/Uno
export PYTHONPATH=$PYTHONPATH

# mpiexec --ppn 12 --np 24 gpu_tile_compact.sh python ./aurora_train.py --infile ./infiles.24

