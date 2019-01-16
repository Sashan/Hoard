include ../Makefile.inc

all: larson

TARGET = larson

larson: larson.cpp
	$(CXX) $(CXXFLAGS) larson.cpp -o larson -lpthread

clean:
	rm -f $(TARGET)
