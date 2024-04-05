TARGET = RADIOSITY

OBJS = display.o elemman.o modelman.o patchman.o rad_main.o rad_tools.o room_model.o smallobj.o taskman.o visible.o ../../inst/hook.c
HHS = model.h.in parallel.h.in patch.h.in radiosity.h.in task.h.in structs.h.in
HS = model.h parallel.h patch.h radiosity.h task.h structs.h

include ../../Makefile.RISCV.config


CFLAGS := $(CFLAGS) -I./glibdumb -I./glibps

#CCOPTS = -I -float -I/usr/include $(CFLAGS)
#LDFLAGS = -lm -lpthread
#CFLAGS = $(CINCLUDE) -O4 -march=i686 -mcpu=i686 -malign-double -funroll-loops -finline-functions -fomit-frame-pointer -D_REENTRANT
#CINCLUDE = -I$(GLIBDIR) -I./glibps

LOADLIBES = glibdumb/glib.a glibps/glibps.a

$(TARGET): $(OBJS) $(LOADLIBES)
	$(CC) $(OBJS) $(CFLAGS) $(LOADLIBES) -o $(TARGET) $(LDFLAGS)

radiosity.h: patch.h model.h parallel.h task.h ../../inst/hook.c
rad_main.c: rad_main.c.in $(HS) ../../inst/hook.c
patchman.c: patchman.c.in $(HS) ../../inst/hook.c
elemman.c: elemman.c.in $(HS) ../../inst/hook.c
taskman.c: taskman.c.in $(HS) ../../inst/hook.c
modelman.c: modelman.c.in $(HS) ../../inst/hook.c
smallobj.c: smallobj.c.in $(HS) ../../inst/hook.c
display.c: display.c.in $(HS) ../../inst/hook.c
visible.c: visible.c.in $(HS) ../../inst/hook.c
rad_tools.c: rad_tools.c.in $(HS) ../../inst/hook.c
room_model.c: room_model.c.in $(HS) ../../inst/hook.c

glibdumb/glib.a:
	$(MAKE) -C glibdumb

glibps/glibps.a:
	$(MAKE) -C glibps