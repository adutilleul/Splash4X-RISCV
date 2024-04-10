#ifndef _HOOKS_H_
#define _HOOKS_H_

#include <stdio.h>
#include <pthread.h>

#define FENCE_TYPE_FULL_EXTRA 0
#define FENCE_TYPE_FULL 1
#define FENCE_TYPE_LL 2
#define FENCE_TYPE_SS 3

__attribute__((noinline))  void RMS_Initial_Acq_Inner(void* lock);
__attribute__((noinline))  void RMS_Final_Acq_Inner();
__attribute__((noinline))  void RMS_Initial_Release_Inner(void* lock);
__attribute__((noinline))  void RMS_Final_Release_Inner();

__attribute__((noinline))  void RMS_Initial_Barrier_Inner(void* cond, void* count, void* lock);
__attribute__((noinline))  void RMS_Final_Barrier_Inner();

__attribute__((noinline))  void RMS_Initial_CondSignal_Inner(void* cond);
__attribute__((noinline))  void RMS_Final_CondSignal_Inner();
__attribute__((noinline))  void RMS_Initial_CondBroadcast_Inner(void* cond);
__attribute__((noinline))  void RMS_Final_CondBroadcast_Inner();
__attribute__((noinline))  void RMS_Initial_CondWait_Inner(void* cond, void* lock);
__attribute__((noinline))  void RMS_Final_CondWait_Inner();

__attribute__((noinline))  void RMS_Initial_Atomic_Acq_Inner(void *addr, int size);
__attribute__((noinline))  void RMS_Final_Atomic_Acq_Inner();
__attribute__((noinline))  void RMS_Initial_Atomic_Release_Inner(void *addr, int size);
__attribute__((noinline))  void RMS_Final_Atomic_Release_Inner();
__attribute__((noinline))  void RMS_Initial_Atomic_AcqRel_Inner(void *addr, int size);
__attribute__((noinline))  void RMS_Final_Atomic_AcqRel_Inner();

__attribute__((noinline))  void RMS_Fence_Inner(int type);

// function to get pthread id
static inline pthread_t get_pthread_id()
{
   return pthread_self();
}

#ifdef __riscv

static inline __attribute__((always_inline)) void Start_ROI()
{
   __asm__ volatile("srai zero, zero, 0");
}

static inline __attribute__((always_inline)) void End_ROI()
{
   __asm__ volatile("srai zero, zero, 1");
}

static inline __attribute__((always_inline)) void PThread_Begin_Zone()
{
   __asm__ volatile("srai zero, zero, 30");
}

static inline __attribute__((always_inline)) void PThread_End_Zone()
{
   __asm__ volatile("srai zero, zero, 31");
}

#else

static inline __attribute__((always_inline)) void Start_ROI()
{
}

static inline __attribute__((always_inline)) void End_ROI()
{
}

static inline __attribute__((always_inline)) void PThread_Begin_Zone()
{
}

static inline __attribute__((always_inline)) void PThread_End_Zone()
{
}

#endif

static inline __attribute__((always_inline)) void RMS_Initial_Acq(void *lock)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_Acq : %p on thread %lu\n", lock, get_pthread_id());
   #endif
   RMS_Initial_Acq_Inner(lock);
}

static inline __attribute__((always_inline)) void RMS_Final_Acq()
{
   RMS_Final_Acq_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Initial_Release(void *lock)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_Release : %p on thread %lu\n", lock, get_pthread_id());
   #endif
   RMS_Initial_Release_Inner(lock);
}

static inline __attribute__((always_inline)) void RMS_Final_Release()
{
   RMS_Final_Release_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Initial_Barrier(void *cond, void *count, void *lock)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_Barrier : %p %p %p on thread %lu\n", cond, count, lock, get_pthread_id());
   #endif
   RMS_Initial_Barrier_Inner(cond, count, lock);
}

static inline __attribute__((always_inline)) void RMS_Final_Barrier()
{
   RMS_Final_Barrier_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Initial_CondSignal(void *cond)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_CondSignal : %p on thread %lu\n", cond, get_pthread_id());
   #endif
   RMS_Initial_CondSignal_Inner(cond);
}

static inline __attribute__((always_inline)) void RMS_Final_CondSignal()
{
   RMS_Final_CondSignal_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Initial_CondBroadcast(void *cond)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_CondBroadcast : %p on thread %lu\n", cond, get_pthread_id());
   #endif
   RMS_Initial_CondBroadcast_Inner(cond);
}

static inline __attribute__((always_inline)) void RMS_Final_CondBroadcast()
{
   RMS_Final_CondBroadcast_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Initial_CondWait(void *cond, void *lock)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_CondWait : %p %p on thread %lu\n", cond, lock, get_pthread_id());
   #endif
   RMS_Initial_CondWait_Inner(cond, lock);
}

static inline __attribute__((always_inline)) void RMS_Final_CondWait()
{
   RMS_Final_CondWait_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Initial_Atomic_Acq(void *addr, int size)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_Atomic_Acq : %p %d on thread %lu\n", addr, size, get_pthread_id());
   #endif
   RMS_Initial_Atomic_Acq_Inner(addr, size);
}

static inline __attribute__((always_inline)) void RMS_Final_Atomic_Acq()
{
   RMS_Final_Atomic_Acq_Inner();
   PThread_End_Zone();
}
static inline __attribute__((always_inline)) void RMS_Initial_Atomic_Release(void *addr, int size)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_Atomic_Release : %p %d on thread %lu\n", addr, size, get_pthread_id());
   #endif
   RMS_Initial_Atomic_Release_Inner(addr, size);
}

static inline __attribute__((always_inline)) void RMS_Final_Atomic_Release()
{
   RMS_Final_Atomic_Release_Inner();
   PThread_End_Zone();
}
static inline __attribute__((always_inline)) void RMS_Initial_Atomic_AcqRel(void *addr, int size)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Initial_Atomic_AcqRel : %p %d on thread %lu\n", addr, size, get_pthread_id());
   #endif
   RMS_Initial_Atomic_AcqRel_Inner(addr, size);
}

static inline __attribute__((always_inline)) void RMS_Final_Atomic_AcqRel()
{
   RMS_Final_Atomic_AcqRel_Inner();
   PThread_End_Zone();
}

static inline __attribute__((always_inline)) void RMS_Fence(int type)
{
   PThread_Begin_Zone();
   #ifdef DEBUG_PRINT_TRACE
   printf("RMS_Fence : %d on thread %lu\n", type, get_pthread_id());
   #endif
   RMS_Fence_Inner(type);
   PThread_End_Zone();
}

#endif
