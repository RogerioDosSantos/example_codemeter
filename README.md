# CodeMeter Example

This is an example on how to connect to codemeter license server. Additional Information about CodeMeter can be found [here](http://rogeriodossantos.github.io/Wiki/stage/codemeter.html)

## How to compile

### Linux

- Run `./build/compile.sh ./build/linux-x64.cmake`

### Windows

- Open *The project on Visual Studio (2017 or later)* using the *Open CMAKE* option.
- Compile the desired projects

## Output location and details

  The compiled binaries will be located on the */stage* folder which follows the structure below:

      /stage
      ├── build
      │   └── cmake - CMake project files that can be used on to find the libraries by other projects
      │       ├── project-config.cmake
      │       └── project-configversion.cmake
      ├── include
      │       └── project.h
      └── Linux-4.4.0-43-Microsoft - It can change depending on the platform
          └── x86_64 - It can change depending on the platform
              ├── bin
              │   └── project - Executable or shared libraries
              ├── lib
              │   └── project.a - Static libraries
              └── cmake - CMake target for that specific platform
                  ├── project.cmake
                  └── project-noconfig.cmake

