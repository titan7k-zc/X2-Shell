import sys
# import json

Path = {
    "conservation_mode": "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode",
    "platform_profile": "/sys/class/platform-profile/platform-profile-0/profile"
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



def main():
    inp = sys.argv[1:]
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