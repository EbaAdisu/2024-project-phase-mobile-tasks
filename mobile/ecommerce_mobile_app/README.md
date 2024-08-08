# E-commerce Mobile App

This is an E-commerce mobile application built with Flutter. The application provides basic CRUD (Create, Read, Update, Delete) operations for managing products.

## Directory Structure

The project is organized into three main directories: `models`,`widgets` and `screens`.

### Models

The models directory contains the data models used in the application. These models define the structure of the objects used in the application, particularly those related to products. For these project there is only one object in models:

-   `product.dart`: This file defines the Product model. This model represents a product in the e-commerce application, with properties such as name, description, price, rate, and category.

### Widgets

The `widgets` directory contains reusable UI components used across the application. Here's a brief description of each file:

-   `form_button.dart`: This file defines the `FormButton` widget, a reusable component used in both the Add and Update screens. It encapsulates the functionality for submitting form data, triggering the creation or update of a product in the application.

-   `form_text_field.dart`: This file defines the `FormTextField` widget. This widget is a custom text field used in the Add and Update screens. It is designed to capture and validate user input, ensuring that the data entered meets the application's requirements.

-   `product_action_button.dart`: This file contains the `ProductActionButton` widget. This widget is used on the Detail screen and provides the user with the ability to delete a product or navigate to the Update screen for the selected product.

-   `product_card.dart`: This file defines the `ProductCard` widget. This widget is used to display individual products in a consistent and visually appealing manner. It is used throughout the application wherever a product's information is displayed in a card-like format.

### Screens

The `screens` directory contains the different screens of the application. Here's a brief description of each file:

-   `home_screen.dart`: This is the main screen of the application. It displays a list of all products.
-   `detail_screen.dart`: This screen displays detailed information about a specific product.
-   `add_screen.dart`: This screen provides a form to add a new product to the list.
-   `update_screen.dart`: This screen provides a form to update the details of an existing product.

## Main Application File

The `main.dart` file is the entry point of the application. It imports the necessary Flutter packages and the screens used in the application. It defines a `MyApp` class that extends `StatelessWidget` and builds the `MaterialApp` with the title 'E-commerce Mobile App'.

## Running the Application

To run the application, navigate to the project directory in your terminal and run the following command:

```bash
flutter pub get
flutter run
```
