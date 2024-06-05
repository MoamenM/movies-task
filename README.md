# MovieDB iOS App

This is an iOS application that displays a list of now playing, popular, and upcoming movies from The Movie Database (TMDb) API. Users can view detailed information about each movie by tapping on it.

## Features

### List Screen
- **Three Tabs:** Displays now playing, popular, and upcoming movies using a native tab bar.
- **Movie List View:** Fetches and displays a list of movies under each tab from the TMDb API.
- **Movie Information:** Shows basic movie information such as title, release date, and poster image.

### Detail Screen
- **Comprehensive Movie Details:** Provides additional details about the selected movie, including overview, genres, and runtime.
- **Navigation:** Includes a button to navigate back to the list screen.

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern for managing UI-related logic. The codebase is organized following Domain-Driven Design principles, separating concerns into domain, data, and presentation layers.

### Layers
- **Domain Layer:** Contains domain models representing movie entities and use cases for fetching movie data.
- **Data Layer:** Responsible for data retrieval and includes network service classes to interact with the TMDb API.
- **Presentation Layer:** Manages UI components and ViewModels to handle UI-related logic.

## Error Handling

The app includes error handling mechanisms to gracefully handle network errors, API failures, and unexpected exceptions. Informative error messages are displayed to the user.

## Unit Tests

Unit tests have been written to cover critical components and functionalities of the app. These tests ensure comprehensive test coverage for domain logic, data retrieval, and UI interactions.

## Requirements

- **Xcode:** Version 12.0 or later
- **iOS:** Version 15.0 or later
- **Swift:** Version 5.0 or later

## How to Run the App

1. Clone the repository.
    ```sh
    git@github.com:MoamenM/movies-task.git
    ```
2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device.

## Screenshots

### List Screen
| Now Playing Movies | Popular Movies | Upcoming Movies |
|-------------|---------|----------|
| ![IMG_4551](https://github.com/MoamenM/movies-task/assets/11499145/95c92c03-1bf4-4e44-99ce-3dde555abae5) | ![IMG_4552](https://github.com/MoamenM/movies-task/assets/11499145/87b64ffb-c77b-494a-a458-064e275fb368) | ![IMG_4553](https://github.com/MoamenM/movies-task/assets/11499145/e943b55f-f44f-43c3-b01e-1dce73e4452a) |

### Detail Screen
| Now Playing Movie Details | Popular Movie Details | Upcoming Movie Details |
|----------|----------|----------|
| ![IMG_4555](https://github.com/MoamenM/movies-task/assets/11499145/4781a613-f0da-4fec-afd7-3cccd2a2e881) | ![IMG_4557](https://github.com/MoamenM/movies-task/assets/11499145/cb16aac2-d948-43bf-ba5b-3d25a524afff) | ![IMG_4556](https://github.com/MoamenM/movies-task/assets/11499145/63da03b4-6509-4ce6-864c-9f965ba368a5) |


### App Empity State
| Empity State |
|----------|
| ![IMG_4558](https://github.com/MoamenM/movies-task/assets/11499145/91163cce-952f-4547-8b1e-3e619ec55d37) |


## Thanks!
