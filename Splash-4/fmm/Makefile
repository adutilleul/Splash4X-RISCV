TARGET = FMM
OBJS = box.o construct_grid.o cost_zones.o defs.o fmm.o interactions.o memory.o particle.o partition_grid.o ../../inst/hook.c

include ../../Makefile.RISCV.config


defs.c: defs.h ../../inst/hook.c
box.c: box.h ../../inst/hook.c
construct_grid.c: construct_grid.h ../../inst/hook.c
cost_zones.c: cost_zones.h ../../inst/hook.c
interactions.c: interactions.h ../../inst/hook.c
memory.c: memory.h ../../inst/hook.c
particle.c: particle.h ../../inst/hook.c
partition_grid.c: partition_grid.h ../../inst/hook.c

fmm.o: fmm.c.in defs.h memory.h particle.h box.h partition_grid.h cost_zones.h construct_grid.h interactions.h ../../inst/hook.c
interactions.o: interactions.c.in defs.h memory.h particle.h box.h partition_grid.h interactions.h ../../inst/hook.c
shell.o: shell.c.in defs.h memory.h particle.h box.h partition_grid.h interactions.h ../../inst/hook.c
construct_grid.o: construct_grid.c.in defs.h memory.h particle.h box.h partition_grid.h construct_grid.h ../../inst/hook.c
cost_zones.o: cost_zones.c.in defs.h memory.h box.h partition_grid.h cost_zones.h ../../inst/hook.c
#orb.o: orb.c.in defs.h memory.h box.h partition_grid.h orb.h
partition_grid.o: partition_grid.c.in defs.h memory.h box.h partition_grid.h ../../inst/hook.c
box.o: box.c.in defs.h memory.h particle.h box.h ../../inst/hook.c
particle.o: particle.c.in defs.h memory.h particle.h ../../inst/hook.c
memory.o: memory.c.in defs.h memory.h ../../inst/hook.c
defs.o: defs.c.in defs.h memory.h ../../inst/hook.c
memory.h: defs.h particle.h box.h ../../inst/hook.c