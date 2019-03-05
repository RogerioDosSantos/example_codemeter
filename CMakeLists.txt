cmake_minimum_required(VERSION 3.0)

include(CMakePackageConfigHelpers)
include(GenerateExportHeader)

project(codemeter_example VERSION 1.0.0)

# Link Directories
# TODO(Roger) - Add this here only because the target_link_directories is not supported in the Visual Studio I am using
link_directories(
	PUBLIC ./third_party/codemeter_sdk_64_6.80/DevKit/lib
)

# Executable
add_executable(codemeter_example
  ./src/main.cpp
  ./src/codemeter_example.cpp
  )
target_include_directories(codemeter_example
  PRIVATE ./third_party/codemeter_sdk_64_6.80/DevKit/include
  )
# target_link_directories(codemeter_example
# 	PUBLIC ./third_party/codemeter_sdk_64_6.80/DevKit/lib
# )
target_link_libraries(codemeter_example
  PUBLIC WibuCm32
  )

  # Install Include
install(
  DIRECTORY "./include"
  DESTINATION include
  FILES_MATCHING PATTERN "*"
  )

  # Install Targets (Binaries)
install(TARGETS
  codemeter_example
  EXPORT codemeter_example_targets
  LIBRARY DESTINATION bin
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION include
  )

  # Install CMAKE Configuration Files
install(
  EXPORT codemeter_example_targets
  NAMESPACE example
  DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/cmake"
  )
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/cmake/${CMAKE_PROJECT_NAME}-configversion.cmake" COMPATIBILITY SameMajorVersion
  )
configure_package_config_file(
  "./build/config.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake/${CMAKE_PROJECT_NAME}-config.cmake"
  INSTALL_DESTINATION "build/cmake"
  )
install(
  DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/cmake"
  DESTINATION "build"
  FILES_MATCHING PATTERN "*"
  )
