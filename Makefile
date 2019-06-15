CXX = g++
CXXFLAGS = -fPIC -g -std=c++17 -Wall -Wextra
LDFLAGS = -lpthread
SRC = $(PWD)/src
BUILD = $(PWD)/build
OUT = $(PWD)/bin
MKDIR = mkdir -p
NAME = out

.PHONY: clean run all output

output: $(BUILD)/main.o | $(OUT)
	$(CXX) $(CXXFLAGS) $(BUILD)/*.so $(BUILD)/*.o -o $(OUT)/$(NAME) $(LDFLAGS)

$(BUILD)/main.o: $(BUILD)/class.so | $(BUILD)
	$(CXX) -c $(CXXFLAGS) $(SRC)/main.cpp -o $(BUILD)/main.o $(LDFLAGS)

$(BUILD)/class.so: | $(BUILD)
	$(CXX) -c $(CXXFLAGS) $(SRC)/class.cpp -o $(BUILD)/class.so -shared

$(OUT) $(BUILD):
	$(MKDIR) $@

run: output
	$(OUT)/$(NAME)

clean:
	rm -rf $(BUILD) $(OUT)
