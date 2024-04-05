m4_divert(-1)
m4_define(NEWPROC,) dnl

m4_dnl Empty ROI markers
m4_define(SPLASH4_ROI_BEGIN, `Start_ROI()')
m4_define(SPLASH4_ROI_END, `End_ROI()')

m4_dnl Region markers
m4_define(_NOTE_START_ATOMIC, `')
m4_define(_NOTE_END_ATOMIC, `')
m4_define(_NOTE_START_CMPXCHG, `')
m4_define(_NOTE_END_CMPXCHG, `')

m4_define(FETCH_ADD, `({_NOTE_START_ATOMIC(); uint64_t ___x = __atomic_fetch_add((uint64_t*)&($1), $2, __ATOMIC_SEQ_CST); _NOTE_END_ATOMIC(); ___x;});')
m4_define(FETCH_SUB, `({_NOTE_START_ATOMIC(); uint64_t ___x = __atomic_fetch_sub((uint64_t*)&($1), $2, __ATOMIC_SEQ_CST); _NOTE_END_ATOMIC(); ___x;});')
m4_define(STORE,`__atomic_store_n((uint64_t*)&($1), $2, __ATOMIC_SEQ_CST)')
m4_define(LOAD,`__atomic_load_n((uint64_t*)&($1),__ATOMIC_SEQ_CST)')
m4_define(LOAD_RAW,`__atomic_load_n($1,__ATOMIC_SEQ_CST)')
m4_define(CAS, `({_NOTE_START_CMPXCHG(); _Bool ___b = __atomic_compare_exchange_n((uint64_t*)&($1), (uint64_t*)&($2), *((uint64_t*)&$3), 1, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST); _NOTE_END_CMPXCHG(); ___b;})')

m4_define(_CAS, `({_Bool ___b = __atomic_compare_exchange_n((uint64_t*)($1), (uint64_t*)&($2), *((uint64_t*)&$3), 1, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST); ___b;})') m4_dnl Only intended for internal use

m4_define(FETCH_ADD_DOUBLE, `({
  _NOTE_START_CMPXCHG(); 
  double ___oldValue = LOAD(*($1));
  double ___newValue;
  do {
    ___newValue = ___oldValue + $2;
  } while (!_CAS($1, ___oldValue, ___newValue));
  _NOTE_END_CMPXCHG(); 
  ___oldValue;});')

m4_define(ABARDEF, `
	unsigned $1_count; 
	volatile int $1_sense;
')

m4_define(ABAREXTERN,`
	extern unsigned __count__;
	extern volatile int __sense__;
')

m4_define(BARRIER, `{
	RMS_Initial_Barrier(&(($1).cv), &(($1).counter), &(($1).mutex));
	unsigned long	Error, Cycle;
	int		Cancel, Temp;

	Error = pthread_mutex_lock(&($1).mutex);
	if (Error != 0) {
		printf("Error while trying to get lock in barrier.\n");
		exit(-1);
	}

	Cycle = ($1).cycle;
	if (++($1).counter != ($2)) {
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
		while (Cycle == ($1).cycle) {
			Error = pthread_cond_wait(&($1).cv, &($1).mutex);
			if (Error != 0) {
				break;
			}
		}
		pthread_setcancelstate(Cancel, &Temp);
	} else {
		($1).cycle = !($1).cycle;
		($1).counter = 0;
		Error = pthread_cond_broadcast(&($1).cv);
	}
	pthread_mutex_unlock(&($1).mutex);
	RMS_Final_Barrier();
}')

m4_define(BARDEC, `
struct {
	pthread_mutex_t	mutex;
	pthread_cond_t	cv;
	unsigned long	counter;
	unsigned long	cycle;
} ($1);
')

m4_define(BARDECGLOBAL, `')


m4_define(BARINIT, `{
	unsigned long	Error;

	Error = pthread_mutex_init(&($1).mutex, NULL);
	if (Error != 0) {
		printf("Error while initializing barrier.\n");
		exit(-1);
	}

	Error = pthread_cond_init(&($1).cv, NULL);
	if (Error != 0) {
		printf("Error while initializing barrier.\n");
		pthread_mutex_destroy(&($1).mutex);
		exit(-1);
	}

	($1).counter = 0;
	($1).cycle = 0;
}')

m4_define(BAREXCLUDE, `{;}')

m4_define(BARINCLUDE, `{;}')

m4_define(GSDEC, `long ($1);')
m4_define(GSINIT, `{ ($1) = 0; }')
m4_define(GETSUB, `{
  if (($1)<=($3))
    ($2) = ($1)++;
  else {
    ($2) = -1;
    ($1) = 0;
  }
}')

m4_define(NU_GSDEC, `long ($1);')
m4_define(NU_GSINIT, `{ ($1) = 0; }')
m4_define(NU_GETSUB, `GETSUB($1,$2,$3,$4)')

m4_define(ADEC, `long ($1);')
m4_define(AINIT, `{;}')
m4_define(PROBEND, `{;}')

m4_define(LOCKDEC, `pthread_mutex_t ($1);')
m4_define(LOCKINIT, `{pthread_mutex_init(&($1), NULL);}')
m4_define(LOCK, `{RMS_Initial_Acq(&($1));pthread_mutex_lock(&($1));RMS_Final_Acq();}')
m4_define(UNLOCK, `{RMS_Initial_Release(&($1));pthread_mutex_unlock(&($1));RMS_Final_Release();}')

m4_define(NLOCKDEC, `long ($1);')
m4_define(NLOCKINIT, `{;}')
m4_define(NLOCK, `{;}')
m4_define(NUNLOCK, `{;}')

m4_define(ALOCKDEC, `pthread_mutex_t $1[$2];')
m4_define(ALOCKINIT, `{
	unsigned long	i, Error;

	for (i = 0; i < $2; i++) {
		Error = pthread_mutex_init(&$1[i], NULL);
		if (Error != 0) {
			printf("Error while initializing array of locks.\n");
			exit(-1);
		}
	}
}')
m4_define(ALOCK, `{RMS_Initial_Acq(&(($1)[($2)]));pthread_mutex_lock(&$1[$2]);RMS_Final_Acq();}')
m4_define(AULOCK, `{RMS_Initial_Release(&(($1)[($2)]));pthread_mutex_unlock(&$1[$2]);RMS_Final_Release();}')
m4_define(AGETL, `(($1)[$2])')

m4_define(PAUSEDEC, `
struct {
	pthread_mutex_t	Mutex;
	pthread_cond_t	CondVar;
	unsigned long	Flag;
} $1;
')
m4_define(PAUSEINIT, `{
	pthread_mutex_init(&$1.Mutex, NULL);
	pthread_cond_init(&$1.CondVar, NULL);
	$1.Flag = 0;
}
')
m4_define(CLEARPAUSE, `{
	$1.Flag = 0;
	RMS_Initial_Release(&(($1).Mutex));
	pthread_mutex_unlock(&$1.Mutex);
	RMS_Final_Release();}
')
m4_define(SETPAUSE, `{
	RMS_Initial_Acq(&(($1).Mutex));
	pthread_mutex_lock(&$1.Mutex);
	RMS_Final_Acq();
	$1.Flag = 1;
	RMS_Initial_CondBroadcast(&(($1).CondVar));
	pthread_cond_broadcast(&$1.CondVar);
	RMS_Final_CondBroadcast();
	RMS_Initial_Release(&(($1).Mutex));
	pthread_mutex_unlock(&$1.Mutex);
	RMS_Final_Release();}
')
m4_define(EVENT, `{;}')
m4_define(WAITPAUSE, `{
	RMS_Initial_Acq(&(($1).Mutex));
	pthread_mutex_lock(&$1.Mutex);
	RMS_Final_Acq();
	if ($1.Flag == 0) {
		RMS_Initial_CondWait(&(($1).CondVar), &(($1).Mutex));
		pthread_cond_wait(&$1.CondVar, &$1.Mutex);
		RMS_Final_CondWait();
	}
}')
m4_define(PAUSE, `{;}')

m4_define(CONDVARDEC, `pthread_cond_t $1;')
m4_define(CONDVARINIT, `pthread_cond_init(&($1), NULL);')
m4_define(CONDVARWAIT,`{RMS_Initial_CondWait(&($1), &($2)); pthread_cond_wait(&($1), &($2)); RMS_Final_CondWait();}')
m4_define(CONDVARWAIT_FW,`{if ($1) {do {RMS_Initial_CondWait(&($2), &($3)); pthread_cond_wait(&($2), &($3)); RMS_Final_CondWait();} while ($1); } else { ACQUIRE_FENCE(); }}')
m4_define(CONDVARWAIT_FO,`{if ($1) {RMS_Initial_CondWait(&($2), &($3)); pthread_cond_wait(&($2), &($3)); RMS_Final_CondWait();} else { ACQUIRE_FENCE(); }}')
m4_define(CONDVARSIGNAL,`{RMS_Initial_CondSignal(&($1)); pthread_cond_signal(&($1)); RMS_Final_CondSignal();}')
m4_define(CONDVARBCAST,`{RMS_Initial_CondBroadcast(&($1)); pthread_cond_broadcast(&($1)); RMS_Final_CondBroadcast();}')

m4_define(RELEASE_FENCE, `{RMS_Fence(FENCE_TYPE_SS); __atomic_thread_fence(__ATOMIC_RELEASE);}')
m4_define(ACQUIRE_FENCE, `{RMS_Fence(FENCE_TYPE_LL); __atomic_thread_fence(__ATOMIC_ACQUIRE);}')
m4_define(FULL_FENCE, `{RMS_Fence(FENCE_TYPE_FULL); __atomic_thread_fence(__ATOMIC_SEQ_CST);}')

m4_define(AUG_ON, ` ')
m4_define(AUG_OFF, ` ')
m4_define(TRACE_ON, ` ')
m4_define(TRACE_OFF, ` ')
m4_define(REF_TRACE_ON, ` ')
m4_define(REF_TRACE_OFF, ` ')
m4_define(DYN_TRACE_ON, `;')
m4_define(DYN_TRACE_OFF, `;')
m4_define(DYN_REF_TRACE_ON, `;')
m4_define(DYN_REF_TRACE_OFF, `;')
m4_define(DYN_SIM_ON, `;')
m4_define(DYN_SIM_OFF, `;')
m4_define(DYN_SCHED_ON, `;')
m4_define(DYN_SCHED_OFF, `;')
m4_define(AUG_SET_LOLIMIT, `;')
m4_define(AUG_SET_HILIMIT, `;')

m4_define(MENTER, `{;}')
m4_define(DELAY, `{;}')
m4_define(CONTINUE, `{;}')
m4_define(MEXIT, `{;}')
m4_define(MONINIT, `{;}')

m4_define(WAIT_FOR_END, `{
	RMS_Initial_Barrier(0, 0, 0);
	unsigned long	i, Error;
	for (i = 0; i < ($1); i++) {
		Error = pthread_join(PThreadTable[i], NULL);
		if (Error != 0) {
			printf("Error in pthread_join().\n");
			exit(-1);
		}
	}
	RMS_Final_Barrier();
}')

m4_define(CREATE, `{
	long	i, Error;

	for (i = 0; i < ($2); i++) {
		pthread_attr_t attr;
		pthread_attr_init(&attr);
		
		cpu_set_t cpuset;
		CPU_ZERO(&cpuset);
		CPU_SET(i+1, &cpuset);

		pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
		struct sched_param params;
		params.sched_priority = sched_get_priority_max(SCHED_FIFO);
		pthread_attr_setschedparam(&attr, &params);
		pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);

		Error = pthread_create(&PThreadTable[i], &attr, (void * (*)(void *))($1), NULL);
		if (Error != 0) {
			printf("Error in pthread_create().\n");
			exit(-1);
		}
	}
}')

m4_define(MAIN_INITENV, `{;}')
m4_define(MAIN_END, `{exit(0);}')

m4_define(MAIN_ENV,`
#include <pthread.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdint.h>
#include "../../inst/hook.h"
#include <sched.h>
#include <stdio.h> 

#define PAGE_SIZE 4096
#define MAX_THREADS 1024

pthread_t PThreadTable[MAX_THREADS];

#ifndef _rms_barrier_def_
#define _rms_barrier_def_
struct _rms_barrier_ {
	pthread_mutex_t	mutex;
	pthread_cond_t	cv;
	unsigned long	counter;
	unsigned long	cycle;
};
#endif /* _rms_barrier_def_ */

')

m4_define(ENV, ` ')
m4_define(EXTERN_ENV, `
#include <pthread.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdint.h>
#include "../../inst/hook.h"

#define PAGE_SIZE 4096

extern pthread_t PThreadTable[];

#ifndef _rms_barrier_def_
#define _rms_barrier_def_
struct _rms_barrier_ {
	pthread_mutex_t	mutex;
	pthread_cond_t	cv;
	unsigned long	counter;
	unsigned long	cycle;
};
#endif /* _rms_barrier_def_ */
')


m4_define(THREAD_INIT, `{;}')
m4_define(THREAD_INIT_FREE, `{;}')


m4_define(G_MALLOC, `malloc($1);')
m4_define(G_FREE, `;')
m4_define(G_MALLOC_F, `malloc($1)')
m4_define(NU_MALLOC, `malloc($1);')
m4_define(NU_FREE, `;')
m4_define(NU_MALLOC_F, `malloc($1)')

m4_define(GET_HOME, `{($1) = 0;}')
m4_define(GET_PID, `{($1) = 0;}')
m4_define(AUG_DELAY, `{sleep ($1);}')
m4_define(ST_LOG, `{;}')
m4_define(SET_HOME, `{;}')
m4_define(CLOCK, `{
	struct timeval	FullTime;

	gettimeofday(&FullTime, NULL);
	($1) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
}')
m4_divert(0)
