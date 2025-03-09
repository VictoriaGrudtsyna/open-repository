cmake_minimum_required(VERSION 3.10)
project(boost_api_server)

set(CMAKE_CXX_STANDARD 17)

find_package(Boost REQUIRED COMPONENTS system)

include_directories(${Boost_INCLUDE_DIRS})
include_directories(include)

find_package(SQLite3 REQUIRED)
find_package(PostgreSQL REQUIRED)
find_package(OpenSSL REQUIRED)

file(GLOB HANDLERS_SOURCES src/handlers/*.cpp)
file(GLOB MAIN_SOURCES src/*.cpp)

set(SOURCES ${MAIN_SOURCES} ${HANDLERS_SOURCES})

add_executable(boost_api_server ${SOURCES})
target_link_libraries(boost_api_server ${Boost_LIBRARIES}
    bcrypt
    SQLite::SQLite3
    PRIVATE 
    ${PostgreSQL_LIBRARIES}
    OpenSSL::Crypto
)