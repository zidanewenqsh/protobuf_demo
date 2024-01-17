
cmake_minimum_required(VERSION 3.10)
project(YourProjectName)  # 替换为您的项目名称
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# 添加编译器警告标志
add_compile_options(-Wall -Wextra -g)

# 设置源代码和头文件目录
set(SRC_DIR src)
set(INCLUDE_DIR include)
set(PROTOS_DIR protos)

# 包含 Protocol Buffers 模块
find_package(Protobuf REQUIRED)


# 设置protobuf输出目录为与build平级的include目录
set(PROTOBUF_OUTPUT_DIR ${CMAKE_SOURCE_DIR}/include)

# 包含新的protobuf头文件目录
include_directories(${PROTOBUF_OUTPUT_DIR})



# 添加 Protocol Buffers 生成的源文件和头文件
file(GLOB PROTO_FILES "${PROTOS_DIR}/*.proto")
# protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${PROTO_FILES})

# 修改protobuf_generate_cpp函数调用，添加OUTPUT_DIRS参数
# protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${PROTO_FILES} OUTPUT_DIRS ${PROTOBUF_OUTPUT_DIR})

# 包含生成的头文件目录
# include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")

# 添加所有的源文件
file(GLOB CPP_FILES "${SRC_DIR}/*.cpp")
# 为每个可执行文件创建一个目标
# foreach(CPP_FILE ${CPP_FILES})
#     get_filename_component(EXECUTABLE_NAME ${CPP_FILE} NAME_WE)
#     add_executable(${EXECUTABLE_NAME} ${CPP_FILE} ${PROTO_SRCS} ${PROTO_HDRS})
#     target_include_directories(${EXECUTABLE_NAME} PRIVATE ${INCLUDE_DIR})
#     target_link_libraries(${EXECUTABLE_NAME} ${Protobuf_LIBRARIES})
# endforeach()
# 修改添加可执行文件的部分
foreach(CPP_FILE ${CPP_FILES})
    get_filename_component(EXECUTABLE_NAME ${CPP_FILE} NAME_WE)
    
    # 获取当前CPP_FILE对应的proto文件
    get_filename_component(CPP_FILE_DIR ${CPP_FILE} DIRECTORY)
    set(PROTO_FILE "${CMAKE_SOURCE_DIR}/${PROTOS_DIR}/${EXECUTABLE_NAME}.proto")
    
    if(EXISTS ${PROTO_FILE})
        # protobuf_generate_cpp(PROTO_${EXECUTABLE_NAME}_SRCS PROTO_${EXECUTABLE_NAME}_HDRS ${PROTO_FILE}) 
        
        # 指定protobuf生成文件的目标目录
        set(PROTO_OUTPUT_DIR "${CMAKE_SOURCE_DIR}/include")
        file(MAKE_DIRECTORY ${PROTO_OUTPUT_DIR})  # 创建目标目录
        message(INFO "\${PROTOS_DIR}=${PROTOS_DIR}")
        # 手动调用protoc命令并指定输出目录
        # execute_process(COMMAND protoc 
        #                 -I "${CMAKE_SOURCE_DIR}/${PROTOS_DIR}" 
        #                 --cpp_out=${PROTO_OUTPUT_DIR} 
        #                 ${PROTO_FILE})
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

        
        # 添加生成的.cc和.h文件到可执行目标（假设它们都位于指定的输出目录）
        file(GLOB PROTO_GEN_SRCS "${PROTO_OUTPUT_DIR}/${EXECUTABLE_NAME}*.pb.cc")
        file(GLOB PROTO_GEN_HDRS "${PROTO_OUTPUT_DIR}/${EXECUTABLE_NAME}*.pb.h")

        add_executable(${EXECUTABLE_NAME} ${CPP_FILE} ${PROTO_GEN_SRCS} ${PROTO_GEN_HDRS})
        
    else()
        add_executable(${EXECUTABLE_NAME} ${CPP_FILE})
    endif()

    target_include_directories(${EXECUTABLE_NAME} PRIVATE ${INCLUDE_DIR})
    target_link_libraries(${EXECUTABLE_NAME} ${Protobuf_LIBRARIES})
endforeach()
# 添加清理目标
add_custom_target(clean-all
   COMMAND ${CMAKE_COMMAND} -P clean-all.cmake
)
