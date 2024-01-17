# 定义编译器和标志
CXX = g++
CXXFLAGS = -std=c++14 -Wall -Wextra -g
PROTOC = protoc

# 定义目录
SRC_DIR = src
INCLUDE_DIR = include2
PROTOS_DIR = protos
BUILD_DIR = build2

# 找到所有的.proto文件和.cpp文件
PROTO_FILES = $(wildcard $(PROTOS_DIR)/*.proto)
CPP_FILES = $(wildcard $(SRC_DIR)/*.cpp)

# 生成的.pb.cc和.pb.h文件
PROTO_GEN = $(PROTO_FILES:$(PROTOS_DIR)/%.proto=$(INCLUDE_DIR)/%.pb.cc)
PROTO_HEADERS = $(PROTO_FILES:$(PROTOS_DIR)/%.proto=$(INCLUDE_DIR)/%.pb.h)
# 对象文件
PROTO_OBJ = $(PROTO_GEN:$(INCLUDE_DIR)/%.pb.cc=$(BUILD_DIR)/%.pb.o)
CPP_OBJ = $(CPP_FILES:$(INCLUDE_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# 目标可执行文件
EXECUTABLES = $(CPP_FILES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%)

$(info PROTO_FILES = $(PROTO_FILES))
$(info PROTO_GEN = $(PROTO_GEN))
$(info PROTO_HEADERS = $(PROTO_HEADERS))
$(info PROTO_OBJ = $(PROTO_OBJ))
$(info CPP_OBJ = $(CPP_OBJ))
$(info EXECUTABLES = $(EXECUTABLES))


# 默认目标
all: $(BUILD_DIR)/person $(BUILD_DIR)/addressbook $(BUILD_DIR)/contact $(BUILD_DIR)/item $(BUILD_DIR)/phonebook
# person
# 构建可执行文件
$(BUILD_DIR)/person: $(BUILD_DIR)/person.o $(BUILD_DIR)/person.pb.o
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ -lprotobuf

# 编译 .cpp 文件到 .o 文件
$(BUILD_DIR)/person.o: $(SRC_DIR)/person.cpp $(INCLUDE_DIR)/person.pb.h
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# 从 .proto 生成 .pb.cc 和 .pb.h
$(INCLUDE_DIR)/person.pb.cc $(INCLUDE_DIR)/person.pb.h: $(PROTOS_DIR)/person.proto
	$(PROTOC) --cpp_out=$(INCLUDE_DIR) -I$(PROTOS_DIR) $<

# 编译 .pb.cc 文件到 .pb.o 文件
$(BUILD_DIR)/person.pb.o: $(INCLUDE_DIR)/person.pb.cc
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# addressbook
# 构建可执行文件
$(BUILD_DIR)/addressbook: $(BUILD_DIR)/addressbook.o $(BUILD_DIR)/addressbook.pb.o
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ -lprotobuf

# 编译 .cpp 文件到 .o 文件
$(BUILD_DIR)/addressbook.o: $(SRC_DIR)/addressbook.cpp $(INCLUDE_DIR)/addressbook.pb.h
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# 从 .proto 生成 .pb.cc 和 .pb.h
$(INCLUDE_DIR)/addressbook.pb.cc $(INCLUDE_DIR)/addressbook.pb.h: $(PROTOS_DIR)/addressbook.proto
	$(PROTOC) --cpp_out=$(INCLUDE_DIR) -I$(PROTOS_DIR) $<

# 编译 .pb.cc 文件到 .pb.o 文件
$(BUILD_DIR)/addressbook.pb.o: $(INCLUDE_DIR)/addressbook.pb.cc
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# contact
# 构建可执行文件
$(BUILD_DIR)/contact: $(BUILD_DIR)/contact.o $(BUILD_DIR)/contact.pb.o
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ -lprotobuf

# 编译 .cpp 文件到 .o 文件
$(BUILD_DIR)/contact.o: $(SRC_DIR)/contact.cpp $(INCLUDE_DIR)/contact.pb.h
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# 从 .proto 生成 .pb.cc 和 .pb.h
$(INCLUDE_DIR)/contact.pb.cc $(INCLUDE_DIR)/contact.pb.h: $(PROTOS_DIR)/contact.proto
	$(PROTOC) --cpp_out=$(INCLUDE_DIR) -I$(PROTOS_DIR) $<

# 编译 .pb.cc 文件到 .pb.o 文件
$(BUILD_DIR)/contact.pb.o: $(INCLUDE_DIR)/contact.pb.cc
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# item
# 构建可执行文件
$(BUILD_DIR)/item: $(BUILD_DIR)/item.o $(BUILD_DIR)/item.pb.o
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ -lprotobuf

# 编译 .cpp 文件到 .o 文件
$(BUILD_DIR)/item.o: $(SRC_DIR)/item.cpp $(INCLUDE_DIR)/item.pb.h
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# 从 .proto 生成 .pb.cc 和 .pb.h
$(INCLUDE_DIR)/item.pb.cc $(INCLUDE_DIR)/item.pb.h: $(PROTOS_DIR)/item.proto
	$(PROTOC) --cpp_out=$(INCLUDE_DIR) -I$(PROTOS_DIR) $<

# 编译 .pb.cc 文件到 .pb.o 文件
$(BUILD_DIR)/item.pb.o: $(INCLUDE_DIR)/item.pb.cc
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# phonebook
# 构建可执行文件
$(BUILD_DIR)/phonebook: $(BUILD_DIR)/phonebook.o $(BUILD_DIR)/phonebook.pb.o
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ -lprotobuf

# 编译 .cpp 文件到 .o 文件
$(BUILD_DIR)/phonebook.o: $(SRC_DIR)/phonebook.cpp $(INCLUDE_DIR)/phonebook.pb.h
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# 从 .proto 生成 .pb.cc 和 .pb.h
$(INCLUDE_DIR)/phonebook.pb.cc $(INCLUDE_DIR)/phonebook.pb.h: $(PROTOS_DIR)/phonebook.proto
	$(PROTOC) --cpp_out=$(INCLUDE_DIR) -I$(PROTOS_DIR) $<

# 编译 .pb.cc 文件到 .pb.o 文件
$(BUILD_DIR)/phonebook.pb.o: $(INCLUDE_DIR)/phonebook.pb.cc
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@
# 清理目标
clean:
	rm -rf $(BUILD_DIR)/*
	rm -rf $(PROTO_GEN)
	rm -rf $(PROTO_HEADERS)

.PHONY: all clean
