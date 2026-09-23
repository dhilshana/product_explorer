# Product Explorer

A Flutter mobile application that allows users to discover, search, view, and save products using the DummyJSON REST API.

The application includes Firebase Authentication, REST API integration, local favorite persistence, state management, responsive UI, error handling, and navigation between the main application sections.

## Features

* User registration with email and password
* User login with Firebase Authentication
* Authentication state handling
* Logout functionality
* Browse products from DummyJSON API
* Search products
* View detailed product information
* Add and remove products from favorites
* Persist favorites locally
* Favorites screen
* Loading states
* Error states with retry functionality
* Empty states
* Responsive Material 3 UI
* Clean project structure
* Git-based development history

## Screens

The application contains the following major screens:

* Login
* Registration
* Product Listing
* Product Search
* Product Details
* Favorites
* Profile
* Loading State
* Error State
* Empty Search State

## Tech Stack

| Technology              | Purpose                        |
| ----------------------- | ------------------------------ |
| Flutter                 | Mobile application development |
| Dart                    | Programming language           |
| Firebase Authentication | User registration and login    |
| Provider                | State management               |
| HTTP                    | REST API communication         |
| SQLite / Sqflite        | Local favorite persistence     |
| DummyJSON               | Product REST API               |
| Cached Network Image    | Product image loading          |

## API

This project uses the public DummyJSON Products API.

### Base URL

```text
https://dummyjson.com
```

### Get Products

```http
GET https://dummyjson.com/products
```

### Search Products

```http
GET https://dummyjson.com/products/search?q={query}
```

### Get Product Details

```http
GET https://dummyjson.com/products/{id}
```

### API Documentation

https://dummyjson.com/docs/products

No API key is required for the endpoints used in this project.

## Project Structure

```text
lib/
  |   main.dart
  |
  +---core
  |   +---constants
  |   |       api_constants.dart
  |   |
  |   +---error
  |   |       app_exception.dart
  |   |
  |   +---theme
  |   |       app_color_scheme.dart
  |   |       app_theme.dart
  |   |
  |   \---utils
  |           responsive.dart
  |           result_status.dart
  |
  +---data
  |   +---models
  |   |       product_model.dart
  |   |       user_model.dart
  |   |
  |   +---repositories
  |   |       auth_repository.dart
  |   |       favorites_repository.dart
  |   |       product_repository.dart
  |   |
  |   \---services
  |           api_client.dart
  |           firebase_auth_service.dart
  |
  +---viewmodels
  |       app_providers.dart
  |       auth_viewmodel.dart
  |       favorites_viewmodel.dart
  |       product_viewmodel.dart
  |       theme_viewmodel.dart
  |
  +---views
  |   +---auth
  |   |       auth_wrapper.dart
  |   |       login_view.dart
  |   |       register_view.dart
  |   |       splash_view.dart
  |   |
  |   +---favorites
  |   |       favorites_view.dart
  |   |
  |   +---home
  |   |       home_view.dart
  |   |       search_view.dart
  |   |
  |   +---main_nav
  |   |       main_nav_view.dart
  |   |
  |   +---product_details
  |   |       product_details_view.dart
  |   |
  |   \---profile
  |           profile_view.dart
  |
  \---widgets
        custom_app_bar.dart
        custom_button.dart
        custom_icon_button.dart
        custom_outline_button.dart
        custom_snackbar.dart
        custom_text_field.dart
        link_text_style.dart
        logout_dialog.dart
        product_card.dart
        state_views.dart
```

The project separates UI, state management, and service/API responsibilities to keep the code readable and maintainable.

## State Management

Provider is used for application state management.

The main providers are:

### AuthViewModel

Responsible for:

* Login
* Registration
* Logout
* Authentication state
* Authentication errors

### ProductViewModel

Responsible for:

* Fetching products
* Searching products
* Loading state
* API errors
* Product data

### FavoriteViewModel

Responsible for:

* Loading saved favorites
* Adding favorites
* Removing favorites
* Checking whether a product is a favorite
* Synchronizing favorite state with local storage

Provider was selected because the application has a relatively small amount of shared state and Provider provides a simple and readable way to manage it without unnecessary architectural complexity.

## Local Storage

SQLite is used to persist favorite products locally.

Only the required favorite information is stored locally.

This allows favorites to remain available when the application is closed and reopened.

## Firebase Authentication

Firebase Authentication is used for email/password authentication.

The application supports:

* Account registration
* Login
* Logout
* Authentication state changes
* Authentication errors handled
* Invalid email
* Invalid credentials
* Existing email during registration
* Weak password
* Network-related errors
* Unexpected authentication errors

## Loading, Error and Empty States

The application provides feedback for common application states.

### Loading

A loading indicator is displayed while:

* Products are being retrieved
* Search requests are running
* Authentication requests are processing

### Error

API and authentication failures are displayed using user-friendly error messages.

Where appropriate, users can retry the failed operation.

### Empty

Empty states are provided for:

* No search results
* No favorite products
* No available products

## How to Run

### Requirements

Make sure the following are installed:

* Flutter SDK
* Dart SDK
* Android Studio or Visual Studio Code
* Android SDK
* A Firebase project

Check your Flutter installation:

```bash
flutter doctor
```

### Clone the Repository

```bash
git clone https://github.com/dhilshana/product_explorer
```

### Navigate into the Project

```bash
cd product_explorer
```

### Install Dependencies

```bash
flutter pub get
```

## Firebase Setup

1. Create a Firebase project from the Firebase Console.
2. Add an Android application to the Firebase project.
3. Configure Firebase for the Flutter application.
4. Enable Authentication.
5. Enable the Email/Password sign-in provider.
6. Add the required Firebase configuration files.
7. Run the application.

Firebase configuration files and private credentials should not be committed to the repository when they contain sensitive information.

## Running the Application

```bash
flutter pub get
flutter run
```

To build a release APK:

```bash
flutter build apk --release
```

## How to Use

1. Create a new account or log in.
2. Browse the available products.
3. Use the search field to search for products.
4. Tap a product to view its details.
5. Add products to favorites.
6. Open the Favorites section to view saved products.
7. Remove products from favorites when required.
8. Close and reopen the application to verify that favorites persist.
9. Log out when finished.

## Error Handling

The application handles common failures without crashing.

Examples include:

* Invalid login credentials
* Existing email during registration
* Network failures
* API failures
* Empty API responses
* Empty search results
* Missing product data
* Unexpected errors

Users are provided with appropriate feedback and retry options where applicable.

## AI Usage

### Tool

**ChatGPT**

### Usage

AI assistance was used for:

* Understanding and configuring Firebase Authentication
* Discussing Flutter architecture and project structure
* Assisting with REST API integration
* Debugging development issues
* Improving loading, error, and empty-state handling
* Reviewing UI and code organization
* Preparing project documentation

All submitted code was reviewed, tested, and understood by me, and I am able to explain the implementation and technical decisions made in the project.

## Technical Decisions

### Provider

Provider was selected because the application has a moderate amount of shared state and does not require a highly complex state-management architecture.

### Repository / Service Separation

API and Firebase operations are kept outside UI widgets. This makes the UI easier to maintain and keeps responsibilities separated.

### SQLite

SQLite was selected for local favorite persistence because favorites need to remain available after the application is restarted.

### Bottom Navigation

Bottom navigation provides quick access to the two primary areas of the application: Products and Favorites.

## Known Limitations

This application was developed as part of a time-limited technical assessment.

Possible future improvements include:

* Auth with Google
* Forgot password functionality

## Application Scope

This project focuses on demonstrating:

* Flutter fundamentals
* Dart programming
* UI development
* Responsive design
* State management
* REST API integration
* Firebase Authentication
* Local persistence
* Navigation
* Error handling
* Git workflow
* Documentation

The implementation intentionally avoids unnecessary complexity and focuses on delivering the required functionality in a maintainable way.