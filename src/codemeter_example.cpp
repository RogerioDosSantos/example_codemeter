
#include <cstdio>
#include <iostream>
#include <cstring>

#include "./codemeter_example.h"

#include <codemeter/CodeMeter.h>

using CodeMeterExample::CodeMeter;

CodeMeter::CodeMeter()
{
}

bool CodeMeter::ConsumeServerLicense(const char* server_ip, const char* company_code, const char* product_code)
{
	//The FirmCode 6000010 and Product Code 201000 are public code that can be used for testting
    printf("Connecting to server %s. Company Code: %s ; Product Code: %s\n", server_ip, company_code, product_code);
    std::string ip(server_ip);
    ip += '.';

    unsigned char ip_address[4];
    memset(ip_address, 0, sizeof(ip_address));
    for(int position = 0, index = 0; index < 4; ++index)
    {
      position = ip.find('.');
      if(position == std::string::npos)
        break;

      std::string token = ip.substr(0, position);
      ip_address[index] = atol(token.c_str());
      ip.erase(0, position + 1);
    }

    CMACCESS codemeter_access;
    memset(&codemeter_access, 0, sizeof(codemeter_access));
    codemeter_access.mflCtrl |= CM_ACCESS_NOUSERLIMIT;
    codemeter_access.mulFirmCode = atol(company_code);
    codemeter_access.mulProductCode = atol(product_code);
    memcpy(&codemeter_access.mabIPv4Address, ip_address, 4);

    HCMSysEntry handle = CmAccess(CM_ACCESS_LAN, &codemeter_access);
    system("pause");
    CmRelease(handle);
    handle = NULL;
    return true;
}
