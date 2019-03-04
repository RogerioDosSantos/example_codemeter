
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <sstream>
#include <string>

#include "./codemeter_example.h"

using CodeMeterExample::CodeMeter;

int main(int argc, char const* argv[])
{
    std::string arguments[4];
    switch (argc)
    {
    case 5:
        arguments[3] = argv[4];
    case 4:
        arguments[2] = argv[3];
    case 3:
        arguments[1] = argv[2];
    case 2:
        arguments[0] = argv[1];
        break;
    default:
        break;
    }

    if (!arguments[0].compare("--consume_server_license") || !arguments[0].compare("-sl"))
    {
      CodeMeter codemeter;
        if (argc < 4)
            printf("Invalid number of arguments. Expected: %d ; Current: %d\n", 3, argc - 1);
        if (!codemeter.ConsumeServerLicense(arguments[1].c_str(), arguments[2].c_str(), arguments[3].c_str()))
            return 1;
    }
    else
    {
        printf("Invalid Command (%d)\n\t%s\nOptions:\n", argc, arguments[0].c_str());
        printf("\t--consume_server_license [-sl] <server_ip> <company_code> <product_code>\t-E.g.: -sl 192.168.0.10 6000010 201000\n");
        printf("\t--test");
    }

    return 0;
}
