DIRS := cache-scratch cache-thrash larson linux-scalability phong threadtest

all:
	for dir in $(DIRS); do \
	  (cd $$dir; ${MAKE}); \
	done
	time ./run-tests.sh

clean:
	for dir in $(DIRS); do \
	  (cd $$dir; ${MAKE} clean); \
	done

