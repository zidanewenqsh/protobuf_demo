# 项目名称：protobuf_demo
# 目录结构
├── build # CMake 构建目录
├── build2 # Makefile 构建目录
├── CMakeLists.txt
├── compile_commands.json
├── include # 包含由 protoc 生成的 .h 文件
├── include2 # 包含由 Makefile 生成的 .h 文件
├── LICENSE
├── Makefile
├── protos # 存放 .proto 文件
├── README.md
└── src # 源代码文件

# 构建和运行

本项目支持两种构建方式：使用 CMake 和使用 Makefile。

## 使用 CMake

在项目根目录下创建一个构建目录并进入该目录：

```bash
mkdir build
cd build
cmake ..
make
./person
./addressbook
./contact
./item
./phonebook

```
## 使用 Makefile
在根目录下使用 Makefile 构建项目：

```bash
make -f Makefile
./build2/person
./build2/addressbook
./build2/contact
./build2/item
./build2/phonebook
```

# 案例说明
## 案例 1: person.cpp
演示了如何定义和使用基本的 Protocol Buffers 消息。

## 案例 2: addressbook.cpp
展示了如何使用嵌套消息。

## 案例 3: contact.cpp
演示了如何使用重复字段列表。

## 案例 4: item.cpp
展示了如何使用枚举和默认值。

## 案例 5: phonebook.cpp
演示了如何使用 oneof 来表示可选字段

# GitHub 信息
克隆仓库:
```bash
git clone https://github.com/zidanewenqsh/protobuf_demo.git
```
# 许可证
此项目根据 LICENSE 许可证授权

# VSCode 配置说明
在Debug的时候，建议选择Makefile的方式进行构建，目前如果用CMake的方式，会重复构建。
发现是在用CMake的方式构建的时候使用add_custom_command来代替execute_process可以解决。
execute_process 是在配置时一次性执行，主要用于辅助 CMake 配置逻辑；而 add_custom_command 则是在构建时根据需要执行，主要用于扩展构建过程并生成其他构建目标所依赖的文件。
- add_custom_command代码
```
add_custom_command(
    OUTPUT "${PROTO_OUTPUT_DIR}/${EXECUTABLE_NAME}.pb.cc"
            "${PROTO_OUTPUT_DIR}/${EXECUTABLE_NAME}.pb.h"
    COMMAND protoc 
            -I "${CMAKE_SOURCE_DIR}/${PROTOS_DIR}" 
            --cpp_out=${PROTO_OUTPUT_DIR} 
            ${PROTO_FILE}
    DEPENDS ${PROTO_FILE}             # 添加对.proto文件的依赖
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Generating C++ files from ${PROTO_FILE}"
)
```
- execute_process代码
```
# 手动调用protoc命令并指定输出目录
execute_process(COMMAND protoc 
                -I "${CMAKE_SOURCE_DIR}/${PROTOS_DIR}" 
                --cpp_out=${PROTO_OUTPUT_DIR} 
                ${PROTO_FILE})
```

另外还有protobuf_generate_cpp也可用来构建protobuf文件。格式如下:
- protobuf_generate_cpp代码
'''
protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${PROTO_FILES})
'''