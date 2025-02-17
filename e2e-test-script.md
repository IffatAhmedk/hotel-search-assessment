## End-to-End (E2E) Testing
After setting up the environment, the next step was to create an E2E tests to validate the core functionality of the app. Additionally, to write a script that detects all connected devices and runs the E2E tests on each device automatically.

### Test Flow:

1. User opens the app.
2. User searches for hotels.
3. User adds a hotel to favorites.
4. User verifies that the hotel appears in the favorites list.
5. User removes the hotel from favorites.
6. User confirms that the hotel is no longer in the favorites list.

This test ensures that the app’s primary features—search, favorites management, and state persistence—are functioning correctly across devices.

## Running Tests

### Manual Test Execution

To run the tests manually on a single device, use the following command:
```flutter test integration_test/app_test.dart```

### Running Tests on All Devices
To execute tests across all available devices:

Run the test script:

`./integration_test/run_tests.sh`

If you encounter a permission error, make the script executable first:

`chmod +x integration_test/run_tests.sh`
