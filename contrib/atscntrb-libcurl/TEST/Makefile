#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc

######

all::
regress::
cleanall::

######

INCLUDE=./../..

######

all:: test00
test00: test00.dats ; \
$(PATSCC) -I$(INCLUDE) -o $@  $< testlib.dats -lcurl
#
regress:: test00 ; ./$<
#
cleanall:: ; $(RMF) test00

######
#
all:: test01
test01: test01.dats ; \
$(PATSCC) -g -DATS_MEMALLOC_LIBC -I$(INCLUDE) -o $@  $< testlib.dats -lcurl
#
regress:: test01 ; ./$<
#
cleanall:: ; $(RMF) test01
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
