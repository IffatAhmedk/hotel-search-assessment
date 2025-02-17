# Hotel Search Tests Structure

## Setup
1. Mock Repository: MockHotelsRepository extends Mock
2. Initial Configuration:
   a. Repository registration
   b. Default response setup
   c. Mock data configuration for "New York" search

## Test Groups

### HotelSearchPage Widget Tests
#### Search Field Input Test
**Objective**: Verify search field updates on user input
**Setup**:
1. Initialize Hive directory
2. Set up BlocProvider with HotelsBloc
3. Configure mock repository

**Test Steps:**
1. Enter "New York" in search field
2. Verify initial empty state

#### Search Results Display Test
**Objective**: Verify hotel names display correctly in search results
**Setup**:
1. Initialize Hive directory
2. Set up BlocProvider with HotelsBloc
3. Configure mock repository

**Test Steps:**
1. Enter "New York" in search field
2. Verify "Hotel 1" and "Hotel 2" appear in results

### Mock Data
Two hotel entries with:
Names: "Hotel 1", "Hotel 2"
Locations: Different coordinates
Description: "testing"
