#!/bin/bash

# Print a line of dashes for separation
print_separator() {
    echo "----------------------------------------"
}

# Get list of available devices
echo "Checking for connected devices..."
devices=$(flutter devices | grep -E "•" | awk -F'•' '{print $2}' | awk '{print $1}')

# Check if any devices are available
if [ -z "$devices" ]; then
    echo "No devices found. Please connect a device or start an emulator."
    exit 1
fi

# Count devices
device_count=$(echo "$devices" | wc -l)
echo "Found $device_count device(s):"
echo "$devices"
print_separator

# Run tests on each device
echo "$devices" | while read -r device; do
    if [ ! -z "$device" ]; then
        echo "Running tests on device: $device"
        print_separator
        flutter test integration_test/app_test.dart -d "$device"
        print_separator
    fi
done

echo "All tests completed!" 