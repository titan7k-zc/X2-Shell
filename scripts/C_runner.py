import sys
import json

Path = {
    "conservation_mode": "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode",
    "platform_profile": "/sys/class/platform-profile/platform-profile-0/profile",
    "system_config": "/home/titan/.config/hypr/config.json"
}
    # "platform_profile": "/sys/firmware/acpi/platform_profile"  <- cant use "custom"

inp = []

def getValue(path):
    try:
        with open(path,"r") as pathFile:
            value = pathFile.readline().strip()
            return value
    except Exception as e:
        return -2
        # return "Error: Unable to read data from :" + path + " - " + str(e)


def setValue(path,value):
    try:
        with open(path,"w") as pathFile:
            pathFile.write(str(value.strip()))
        return getValue(path)
    except Exception as e:
        # return -3
        return "Error: " + str(e)


def setSysColor(path,c1,c2):
    color1 = c1[1:7]+"ee"
    color2 = c2[1:7]+"aa"

    try:
        with open(path,"r") as configFile:
            data = json.load(configFile)
        data["colors"]["active_border"] = color1
        data["colors"]["inactive_border"] = color2

        with open(path,"w") as configFile:
            json.dump(data,configFile,indent=4)
    except Exception as e:
        return -4


def main():
    inp = sys.argv[1:]

    if inp[0] == "sys_conf":
        setSysColor(Path.get("system_config"),inp[1],inp[2])
    else:

        if len(inp) == 1:
            if inp[0] in Path.keys():
                print(getValue(Path.get(inp[0])))
                # print(json.dumps(data))
            else:   
                print(-1)

        elif len(inp) == 2:
            if inp[0] in Path.keys():
                print(setValue(Path.get(inp[0]),inp[1]))
            else:   
                print(-1)
                



main()
# print("sys.argv: " + str(sys.argv))
# print("Length of sys.argv: " + str(len(sys.argv)))