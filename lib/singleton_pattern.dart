// Singleton в застосунку

// клас UserPreferences є синглтоном, тому що ми використовуємо приватний
// конструктор _internal() для створення лише одного екземпляру класу.
// Замість створення нових екземплярів класу, ми використовуємо статичний
// метод factory для повернення вже існуючого екземпляру.

// В прикладі UserPreferences ми використовуємо синглтон для збереження
// користувацьких налаштувань, таких як ім'я користувача та включений режим
// темної теми. Клас має публічні геттери та сеттери для цих властивостей.

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  String _username = '';
  bool _darkModeEnabled = false;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  bool get darkModeEnabled => _darkModeEnabled;

  set darkModeEnabled(bool value) {
    _darkModeEnabled = value;
  }
}

// створюємо два екземпляри класу UserPreferences та задаємо значення для ім'я
// користувача та включеного режиму темної теми для першого екземпляру.
// При виклику геттерів для обох екземплярів, ми отримуємо однакові значення,
// оскільки вони використовують один і той самий екземпляр класу UserPreferences.

void main() {
  var preferences1 = UserPreferences();
  var preferences2 = UserPreferences();

  preferences1.username = 'John';
  preferences1.darkModeEnabled = true;

  print(preferences1.username); // Output: John
  print(preferences2.username); // Output: John

  print(preferences1.darkModeEnabled); // Output: true
  print(preferences2.darkModeEnabled); // Output: true
}
