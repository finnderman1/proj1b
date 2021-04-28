#include<stdio.h>
#include <iostream> //


#include "rwlock.h"

//Implement all methods of RWLock defined in rwlock.h
//Your solution for  Task 3 
//TODO

RWLock::RWLock(){ 
    char s= 's';
    lock = Lock(&(s));
    readGo = Condition(&(s));
    writeGo = Condition(&(s));

    activeReaders = 0;
	activeWriters = 0;
	waitingReaders = 0;
	waitingWriters = 0;
}

RWLock::~RWLock(){ }

void RWLock::startRead(){ 
    lock.Acquire();
    waitingReaders++;
    while (activeWriters > 0 || waitingWriters > 0) {
        readGo.Wait(&lock);
    }
    waitingReaders--;
    activeReaders++;
    lock.Release();
}
void RWLock::doneRead(){ 
    lock.Acquire();
    activeReaders--;
    if (activeReaders == 0 
         && waitingWriters > 0) {
        writeGo.Signal();
    }
    lock.Release();
}
void RWLock::startWrite(){ 
    lock.Acquire();
    waitingWriters++;
    while (activeWriters > 0 || activeReaders > 0) {
        writeGo.Wait(&lock);
    }
    waitingWriters--;
    activeWriters++;
    lock.Release();
}
void RWLock::doneWrite(){ 
    lock.Acquire();
    activeWriters--;
    assert(activeWriters == 0);
    if (waitingWriters > 0) {
        writeGo.Signal();
    } 
    else {
        readGo.Broadcast();
    }
    lock.Release();
}
