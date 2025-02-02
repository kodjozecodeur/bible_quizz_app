# Bible Quiz App

A fun and interactive Bible quiz game where players unscramble book names from the Bible. This project  goal is to practice logical thinking with dart in flutter and also have fun. 


## Demo

[Link to demo](https://postimg.cc/r0Mp1fFJ)


## Features  

- **Scrambled Words**: Challenge yourself by guessing the correct Bible book name from scrambled letters.  
- **Dynamic Game Flow**: Randomly select and scramble Bible book names to keep the gameplay engaging.  
- **Interactive UI**: Clean and responsive design, built with Material Design principles.  
- **State Management**: Powered by the Provider package to handle app state effectively. 

## Installation  

### Prerequisites  
- Flutter SDK (Version 3.x or higher)  
- Dart SDK  
- Code editor (e.g., VS Code, Android Studio)  

### Steps  

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/bible-quiz-app.git
   ```
2. Navigate to the project folder:
   ```bash
   cd bible-quiz-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```
## Project Structure
```
lib/
├── main.dart                  # Main entry point of the app
├── provider/
│   └── books_retreiver_provider.dart   # State management logic for retrieving and handling books
├── screens/
│   └── game_screen.dart       # Main game screen with UI
├── widgets/
│   └── stats_tile.dart        # Reusable widget for displaying statistics
└── assets/
    └── books.json             # JSON file containing Bible book data
```


## Usage  

1. Launch the app and start the game.  
2. Unscramble the word displayed on the screen by typing your guess in the text field.  
3. Submit your answer to see if it's correct and proceed to the next word.  

## Acknowledgments  

- [Flutter Documentation](https://flutter.dev/docs)  
- [Provider Package](https://pub.dev/packages/provider)  
- [Bible Data](https://example.com)  


## Contact  

For any inquiries, reach out to:  

- GitHub: (https://github.com/kodjozecodeur)  
- Email: kojocode6@gmail.com
```