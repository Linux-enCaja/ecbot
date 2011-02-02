include ../make.include

OBJS = tracking.o  pngtest.o 

all: pngtest

pngtest: $(OBJS) 
	${CXX} $(CXXFLAGS) $(INC) -o $@ $^ ${LIBS}


#pngtest: pngtest.cc tracking.c
#	$(CXX) $(CXXFLAGS) $(INC) pngtest.cc tracking.c -o pngtest $(LIBS) 

clean	:    
	rm -f *.o


.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) -c $<

%.pp : %.c FORCE
	$(PREPROCESS.c) $< > $@
