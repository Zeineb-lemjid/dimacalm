class UserPreferences {
  String theme;
  bool notificationsEnabled;

  UserPreferences({required this.theme, required this.notificationsEnabled});

  factory UserPreferences.fromMap(Map<String, dynamic> data) {
    return UserPreferences(
      theme: data['theme'] ?? 'light',
      notificationsEnabled: data['notificationsEnabled'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}
