#!/bin/sh

#
# Parameters for cache-scratch and cash-thrash tests.
#
CPUS=4		# nthreads
ITERATIONS=1000	# iterations for each thread
OBJSIZE=512	# malloc size
REPS=1000000	# repetitions write attempts, according to source code
		# the argument looks odd, main thread does REPS/CPUS

#echo "cache-scratch is a benchmark that exercises a heap's cache locality."
#echo "An allocator that allows multiple threads to re-use the same small"
#echo "object (possibly all in one cache-line) will scale poorly, while"
#echo "an allocator like Hoard will exhibit near-linear scaling."
echo "\nRunning: cache-scratch/cache-scratch $CPUS $ITERATIONS $OBJSIZE $REPS"
cache-scratch/cache-scratch $CPUS $ITERATIONS $OBJSIZE $REPS

echo "==============================================================="

#echo "cache-thrash is a benchmark that exercises a heap's cache-locality."
echo "\nRunning: cache-thrash/cache-thrash $CPUS $ITERATIONS $OBJSIZE $REPS"
cache-thrash/cache-thrash $CPUS $ITERATIONS $OBJSIZE $REPS


echo "==============================================================="

#
# Larson test parameters
#
#echo "The intent of the Larson benchmark, due to Larson and Krishnan [mLK98],"
#echo "is to simulate a workload for a server. A number of threads are"
#echo "repeatedly spawned to allocate and free blocks in a random order."
#echo "Further, a number of blocks are left to be freed by a subsequent thread."
#echo "Larson and Krishnan observe this behavior (which they call bleeding)"
#echo "in actual server applications, and their benchmark simulates this"
#echo "effect."
#echo "The Larson benchmark measures the throughput of the allocator. "
#echo "As the number of threads increases, we'd like a linear increase"
#echo "in the throughput."
#echo "description comes from:"
#echo "http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.81.5049&rep=rep1&type=pdf"

#
# parameters below above come from here:
# https://github.com/emeryberger/Hoard/blob/master/src/test.sh
#
RUNTIME=10		# let test run for 60secs
MINCHUNK=7		# minimal chunk of memory
MAXCHUNK=8		# maximal chunk of memory
CHPERTHREAD=10000	# number of chunks per thread
ROUNDS=1000		# ??
SEED=1			# ??
THREADS=$CPUS		# number of threads/CPUs
echo "larson/larson $RUNTIME $MINCHUNK $MAXCHUNK $CHPERTHREAD $ROUNDS $SEED $CPUS"
larson/larson $RUNTIME $MINCHUNK $MAXCHUNK $CHPERTHREAD $ROUNDS $SEED $CPUS 

echo "==============================================================="

#
# linux scalability test
#
#echo "linux-scalability"
#echo "Benchmark libc's malloc, and check how well it"
#echo "can handle malloc requests from multiple threads."
#echo ""
#echo "Syntax:"
#echo "\tmalloc-test [ size [ iterations [ thread count ]]]"
#
# values come from linux-scalability defaults
#
SIZE=512
ITERS=1000000
echo "linux-scalability/linux-scalability $SIZE $ITERS $CPUS"
linux-scalability/linux-scalability $SIZE $ITERS $CPUS

echo "==============================================================="

echo "phong test"
#
# arguments below come from built-in defaults
#
NALLOC=a1000000
THREADS=t$CPUS
MINSIZE=z64
MAXSIZE=Z1024
echo "phong/phong $NALLOC $THREADS $MINSIZE $MAXSIZE"
ptime phong/phong $NALLOC $THREADS $MINSIZE $MAXSIZE

echo "==============================================================="

#echo "This program does nothing but generate a number of threads"
#echo "that allocate and free memory, with a variable"
#echo "amount of "work" (i.e. cycle wasting) in between."

#
# arguments come from built-in defaults
#
NITERATIONS=50
NOBJECTS=30000
NTHREADS=$CPUS
WORK=30
OBJSIZE=1
echo "threadtest/threadtest $NTHREADS $NITERATIONS $NOBJECTS $WORK $OBJSIZE"
threadtest/threadtest $NTHREADS $NITERATIONS $NOBJECTS $WORK $OBJSIZE
