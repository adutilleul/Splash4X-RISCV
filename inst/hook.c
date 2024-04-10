#include "hook.h"

#ifdef __riscv

__attribute__((noinline)) void RMS_Initial_Acq_Inner(void *lock) { __asm__ volatile("srai zero, zero, 5"); }
__attribute__((noinline)) void RMS_Final_Acq_Inner() { __asm__ volatile("srai zero, zero, 6"); }
__attribute__((noinline)) void RMS_Initial_Release_Inner(void *lock) { __asm__ volatile("srai zero, zero, 7"); }
__attribute__((noinline)) void RMS_Final_Release_Inner() { __asm__ volatile("srai zero, zero, 8"); }

__attribute__((noinline)) void RMS_Initial_Barrier_Inner(void *cond, void *count, void *lock) { __asm__ volatile("srai zero, zero, 9"); }
__attribute__((noinline)) void RMS_Final_Barrier_Inner() { __asm__ volatile("srai zero, zero, 10"); }

__attribute__((noinline)) void RMS_Initial_CondSignal_Inner(void *cond) { __asm__ volatile("srai zero, zero, 11"); }
__attribute__((noinline)) void RMS_Final_CondSignal_Inner() { __asm__ volatile("srai zero, zero, 12"); }
__attribute__((noinline)) void RMS_Initial_CondBroadcast_Inner(void *cond) { __asm__ volatile("srai zero, zero, 13"); }
__attribute__((noinline)) void RMS_Final_CondBroadcast_Inner() { __asm__ volatile("srai zero, zero, 14"); }
__attribute__((noinline)) void RMS_Initial_CondWait_Inner(void *cond, void *lock) { __asm__ volatile("srai zero, zero, 15"); }
__attribute__((noinline)) void RMS_Final_CondWait_Inner() { __asm__ volatile("srai zero, zero, 16"); }

__attribute__((noinline)) void RMS_Initial_Atomic_Acq_Inner(void *addr, int size) { __asm__ volatile("srai zero, zero, 17"); }
__attribute__((noinline)) void RMS_Final_Atomic_Acq_Inner() { __asm__ volatile("srai zero, zero, 18"); }
__attribute__((noinline)) void RMS_Initial_Atomic_Release_Inner(void *addr, int size) { __asm__ volatile("srai zero, zero, 19"); }
__attribute__((noinline)) void RMS_Final_Atomic_Release_Inner() { __asm__ volatile("srai zero, zero, 20"); }
__attribute__((noinline)) void RMS_Initial_Atomic_AcqRel_Inner(void *addr, int size) { __asm__ volatile("srai zero, zero, 21"); }
__attribute__((noinline)) void RMS_Final_Atomic_AcqRel_Inner() { __asm__ volatile("srai zero, zero, 22"); }

__attribute__((noinline)) void RMS_Fence_Inner(int type) { __asm__ volatile("srai zero, zero, 23"); };

#else

__attribute__((noinline)) void RMS_Initial_Acq_Inner(void *lock) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_Acq_Inner() { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Initial_Release_Inner(void *lock) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_Release_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_Barrier_Inner(void *cond, void *count, void *lock) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_Barrier_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_CondSignal_Inner(void *cond) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_CondSignal_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_CondBroadcast_Inner(void *cond) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_CondBroadcast_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_CondWait_Inner(void *cond, void *lock) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_CondWait_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_Atomic_Acq_Inner(void *addr, int size) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_Atomic_Acq_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_Atomic_Release_Inner(void *addr, int size) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_Atomic_Release_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Initial_Atomic_AcqRel_Inner(void *addr, int size) { __asm__ volatile("nop"); }
__attribute__((noinline)) void RMS_Final_Atomic_AcqRel_Inner() { __asm__ volatile("nop"); }

__attribute__((noinline)) void RMS_Fence_Inner(int type) { __asm__ volatile("nop"); };

#endif