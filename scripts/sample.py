import glob
import subprocess

paths = glob.glob("/sys/bus/platform/drivers/ideapad_acpi/VPC2004:*/conservation_mode")


def get_conservation_mode():
    with open(paths[0], "r") as f:
        return f.read().strip()


def set_conservation_mode(mode):
    subprocess.run(
        ["sudo", "tee", paths[0]],
        input=mode + "\n",
        text=True,
        stdout=subprocess.DEVNULL,
        check=True
    )


while True:
    conservation_value = get_conservation_mode()
    print(f"Current conservation mode: {conservation_value}")
    print("1. Set conservation mode")
    print("3. Exit")
    choice = input("Enter your choice: ")

    if choice == "1":
        mode = input("Enter the conservation mode (1 or 0): ")
        if mode in ("0", "1"):
            set_conservation_mode(mode)
        else:
            print("Please enter only 1 or 0.")

    elif choice == "3":
        break

    else:
        print("Invalid choice.")