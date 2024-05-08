DIRS := $(wildcard */.)
# remove volrend from DIRS
DIRS := $(filter-out volrend/., $(DIRS))
NUM_CORES := 8
DATA_SIZE := simsmall

all: $(DIRS)
clean: $(DIRS)
semiclean: $(DIRS)
atomicBarriers: $(DIRS)
bindCores: $(DIRS)
bindThreads: $(DIRS)
atomicBarriersBindCores: $(DIRS)
atomicBarriersBindThreads: $(DIRS)
$(DIRS):
	+$(MAKE) -f Makefile.X86 -C $@ $(MAKECMDGOALS)
	$@/run.sh $(NUM_CORES) $(DATA_SIZE)
	+$(MAKE) -C $@ clean
	llvm-profdata merge $@/*.profraw -output=$@/code.profdata
	+$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: all clean semiclean atomicBarriers bindCores bindThreads atomicBarriersBindCores atomicBarriersBindThreads $(DIRS)
