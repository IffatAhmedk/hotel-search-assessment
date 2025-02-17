# Hotel Booking Application - Test Scenarios

## Search Functionality

### Empty State
#### Test Objective: 
Verify empty state when no keyword is searched

#### Pre-condition: 
User is on the hotel search page

#### Test Steps:
1. Navigate to search page
2. Leave search field empty
3. Click search button

#### Expected Result: Application should display appropriate empty state message

### Basic Search
#### Test Objective: 
Verify that users can search for hotels using keywords

#### Pre-condition: 
User is on the hotel search page

#### Test Steps:
1. Enter valid hotel name or location in search field
2. Click search button

#### Expected Result: Search results should display matching hotels

## Hotel List View

### List Display
#### Test Objective: 
Verify that search results display correctly with hotels names

#### Pre-condition: 
Search has been performed with results

#### Test Steps:
1. Perform a search with known results
2. Observe the display of hotel listings

#### Expected Result: All hotel names should be clearly visible and properly formatted

### Pagination

#### Test Objective: 
Verify that pagination works correctly when many results are returned

#### Pre-condition: 
Search has returned multiple pages of results

#### Test Steps:
1. Perform a search that returns many results
2. Navigate through different pages
3. Click on different page numbers

#### Expected Result: Pagination controls work correctly and display appropriate results per page

### Hotel Details

#### Test Objective: 
Verify that hotels show correct description

#### Pre-condition:
User is viewing hotel search results

#### Test Steps:

1. Select a specific hotel from search results
2. View hotel description

#### Expected Result: Hotel description should be accurate and complete

## Favorites Functionality

### Add Favorite

#### Test Objective: 
Verify that users can mark a hotel as favorite

#### Pre-condition: 
User is logged in and viewing a hotel

#### Test Steps:
1. Navigate to a hotel listing
2. Click favorite icon

#### Expected Result: Hotel should be marked as favorite with visual indication

### Favorites List

#### Test Objective: 
Verify that favorited hotels appear in the user's favorites list

#### Pre-condition:
User has favorited at least one hotel

#### Test Steps:
1. Navigate to favorites section
2. Check for favorited hotel

#### Expected Result: All favorited hotels should appear in the favorites list

### Multiple Favorites

#### Test Objective: 
Verify ability to favorite multiple hotels

#### Pre-condition: 
User is logged in

#### Test Steps:
1. Navigate to different hotel listings
2. Favorite multiple hotels
3. Check favorites list

#### Expected Result: All favorited hotels should be saved and displayed in favorites list

### Unfavorite Functionality

#### Remove Favorite

#### Test Objective: 
Verify that users can unfavorite a previously favorited hotel

#### Pre-condition: 
User has at least one favorited hotel

#### Test Steps:
1. Navigate to a favorited hotel
2. Click unfavorite icon

#### Expected Result: Hotel should be removed from favorites

### Visual Update

#### Test Objective: 
Verify that unfavorited hotels no longer show favorite indication

#### Pre-condition: 
User has just unfavorited a hotel

#### Test Steps:
1. Unfavorite a hotel
2. Observe favorite icon state

#### Expected Result: Favorite icon should return to unfavorited state

### Removal from List

#### Test Objective: 
Verify that unfavorited hotels are removed from favorites list

#### Pre-condition: 
User has just unfavorited a hotel

#### Test Steps:
1. Navigate to favorites list
2. Check for unfavorited hotel

#### Expected Result: Unfavorited hotel should no longer appear in favorites list
