import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int systemsDesigned = 0;
  int totalQuizzesTaken = 0;
  int highestScore = 0;
  String fastestTime = "N/A";
  List<Map<String, dynamic>> quizHistory = [];
  String userName = "Quiz Master";
  String userCountry = "United States"; // Default country
  String? royalTitle;
  bool hasRoyalTitle = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadRoyalTitleFromLeaderboard();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // Load user name from system or allow user to set it
      userName = prefs.getString('userName') ?? _getSystemUsername();

      // Load user country
      userCountry = prefs.getString('userCountry') ?? 'United States';

      // Load quiz statistics from quiz_history (the actual source)
      final historyJson = prefs.getStringList('quiz_history') ?? [];

      totalQuizzesTaken = prefs.getInt('total_quizzes') ?? 0;

      if (historyJson.isNotEmpty) {
        // Parse quiz history
        final List<Map<String, dynamic>> scoresData =
            historyJson
                .map((jsonStr) => json.decode(jsonStr) as Map<String, dynamic>)
                .toList();

        // Get highest score
        highestScore = scoresData
            .map((result) => result['score'] as int)
            .reduce((a, b) => a > b ? a : b);

        // Get fastest completion time
        final fastestTimeSeconds = scoresData
            .map((result) => result['timeTakenInSeconds'] as int)
            .reduce((a, b) => a < b ? a : b);

        // Format as min:sec
        final minutes = fastestTimeSeconds ~/ 60;
        final seconds = fastestTimeSeconds % 60;
        fastestTime = "${minutes}min${seconds}sec";

        // Prepare quiz history for chart
        quizHistory =
            scoresData.asMap().entries.map((entry) {
              return {
                'quizNumber': entry.key + 1,
                'score': entry.value['score'],
                'completionTime':
                    entry.value['timeTakenInSeconds'] *
                    1000, // Convert to ms for compatibility
              };
            }).toList();
      }

      // Count actual systems designed using best_score_ keys (same as leaderboard)
      systemsDesigned = 0;
      final systemNames = [
        'URL Shortener (e.g., TinyURL)',
        'Pastebin Service (e.g., Pastebin.com)',
        'Web Crawler',
        'Social Media News Feed (e.g., Facebook, X/Twitter)',
        'Video Streaming Service (e.g., Netflix, YouTube)',
        'Ride-Sharing Service (e.g., Uber, Lyft)',
        'Collaborative Editor (e.g., Google Docs, Figma)',
        'Live Streaming Platform (e.g., Twitch, YouTube Live)',
        'Global Gaming Leaderboard',
      ];

      for (final systemName in systemNames) {
        final systemId = systemName.toLowerCase().replaceAll(' ', '_');
        final bestScore = prefs.getInt('best_score_$systemId') ?? 0;
        if (bestScore > 0) {
          systemsDesigned++;
        }
      }

      // ALSO COUNT UNLIMITED DESIGN SYSTEMS
      final unlimitedDesignKeys =
          prefs
              .getKeys()
              .where((key) => key.startsWith('best_score_unlimited_design_'))
              .toList();

      for (final key in unlimitedDesignKeys) {
        final bestScore = prefs.getInt(key) ?? 0;
        if (bestScore > 0) {
          systemsDesigned++;
        }
      }
    });
  }

  String _getSystemUsername() {
    try {
      // Try to get system username
      return Platform.environment['USER'] ??
          Platform.environment['USERNAME'] ??
          'User';
    } catch (e) {
      return 'User';
    }
  }

  Future<void> _loadRoyalTitleFromLeaderboard() async {
    // Only load the title if it was saved by the leaderboard screen
    final prefs = await SharedPreferences.getInstance();
    final savedTitle = prefs.getString('saved_royal_title');
    final hasTitle = prefs.getBool('has_royal_title') ?? false;

    setState(() {
      royalTitle = savedTitle;
      hasRoyalTitle = hasTitle;
    });
  }

  // Comprehensive list of countries with flags
  List<Map<String, String>> getAllCountries() {
    return [
      {'name': 'Afghanistan', 'flag': '🇦🇫'},
      {'name': 'Albania', 'flag': '🇦🇱'},
      {'name': 'Algeria', 'flag': '🇩🇿'},
      {'name': 'Andorra', 'flag': '🇦🇩'},
      {'name': 'Angola', 'flag': '🇦🇴'},
      {'name': 'Antigua and Barbuda', 'flag': '🇦🇬'},
      {'name': 'Argentina', 'flag': '🇦🇷'},
      {'name': 'Armenia', 'flag': '🇦🇲'},
      {'name': 'Australia', 'flag': '🇦🇺'},
      {'name': 'Austria', 'flag': '🇦🇹'},
      {'name': 'Azerbaijan', 'flag': '🇦🇿'},
      {'name': 'Bahamas', 'flag': '🇧🇸'},
      {'name': 'Bahrain', 'flag': '🇧🇭'},
      {'name': 'Bangladesh', 'flag': '🇧🇩'},
      {'name': 'Barbados', 'flag': '🇧🇧'},
      {'name': 'Belarus', 'flag': '🇧🇾'},
      {'name': 'Belgium', 'flag': '🇧🇪'},
      {'name': 'Belize', 'flag': '🇧🇿'},
      {'name': 'Benin', 'flag': '🇧🇯'},
      {'name': 'Bhutan', 'flag': '🇧🇹'},
      {'name': 'Bolivia', 'flag': '🇧🇴'},
      {'name': 'Bosnia and Herzegovina', 'flag': '🇧🇦'},
      {'name': 'Botswana', 'flag': '🇧🇼'},
      {'name': 'Brazil', 'flag': '🇧🇷'},
      {'name': 'Brunei', 'flag': '🇧🇳'},
      {'name': 'Bulgaria', 'flag': '🇧🇬'},
      {'name': 'Burkina Faso', 'flag': '🇧🇫'},
      {'name': 'Burundi', 'flag': '🇧🇮'},
      {'name': 'Cabo Verde', 'flag': '🇨🇻'},
      {'name': 'Cambodia', 'flag': '🇰🇭'},
      {'name': 'Cameroon', 'flag': '🇨🇲'},
      {'name': 'Canada', 'flag': '🇨🇦'},
      {'name': 'Central African Republic', 'flag': '🇨🇫'},
      {'name': 'Chad', 'flag': '🇹🇩'},
      {'name': 'Chile', 'flag': '🇨🇱'},
      {'name': 'China', 'flag': '🇨🇳'},
      {'name': 'Colombia', 'flag': '🇨🇴'},
      {'name': 'Comoros', 'flag': '🇰🇲'},
      {'name': 'Congo', 'flag': '🇨🇬'},
      {'name': 'Costa Rica', 'flag': '🇨🇷'},
      {'name': 'Croatia', 'flag': '🇭🇷'},
      {'name': 'Cuba', 'flag': '🇨🇺'},
      {'name': 'Cyprus', 'flag': '🇨🇾'},
      {'name': 'Czech Republic', 'flag': '🇨🇿'},
      {'name': 'Denmark', 'flag': '🇩🇰'},
      {'name': 'Djibouti', 'flag': '🇩🇯'},
      {'name': 'Dominica', 'flag': '🇩🇲'},
      {'name': 'Dominican Republic', 'flag': '🇩🇴'},
      {'name': 'Ecuador', 'flag': '🇪🇨'},
      {'name': 'Egypt', 'flag': '🇪🇬'},
      {'name': 'El Salvador', 'flag': '🇸🇻'},
      {'name': 'Equatorial Guinea', 'flag': '🇬🇶'},
      {'name': 'Eritrea', 'flag': '🇪🇷'},
      {'name': 'Estonia', 'flag': '🇪🇪'},
      {'name': 'Eswatini', 'flag': '🇸🇿'},
      {'name': 'Ethiopia', 'flag': '🇪🇹'},
      {'name': 'Fiji', 'flag': '🇫🇯'},
      {'name': 'Finland', 'flag': '🇫🇮'},
      {'name': 'France', 'flag': '🇫🇷'},
      {'name': 'Gabon', 'flag': '🇬🇦'},
      {'name': 'Gambia', 'flag': '🇬🇲'},
      {'name': 'Georgia', 'flag': '🇬🇪'},
      {'name': 'Germany', 'flag': '🇩🇪'},
      {'name': 'Ghana', 'flag': '🇬🇭'},
      {'name': 'Greece', 'flag': '🇬🇷'},
      {'name': 'Grenada', 'flag': '🇬🇩'},
      {'name': 'Guatemala', 'flag': '🇬🇹'},
      {'name': 'Guinea', 'flag': '🇬🇳'},
      {'name': 'Guinea-Bissau', 'flag': '🇬🇼'},
      {'name': 'Guyana', 'flag': '🇬🇾'},
      {'name': 'Haiti', 'flag': '🇭🇹'},
      {'name': 'Honduras', 'flag': '🇭🇳'},
      {'name': 'Hungary', 'flag': '🇭🇺'},
      {'name': 'Iceland', 'flag': '🇮🇸'},
      {'name': 'India', 'flag': '🇮🇳'},
      {'name': 'Indonesia', 'flag': '🇮🇩'},
      {'name': 'Iran', 'flag': '🇮🇷'},
      {'name': 'Iraq', 'flag': '🇮🇶'},
      {'name': 'Ireland', 'flag': '🇮🇪'},
      {'name': 'Israel', 'flag': '🇮🇱'},
      {'name': 'Italy', 'flag': '🇮🇹'},
      {'name': 'Jamaica', 'flag': '🇯🇲'},
      {'name': 'Japan', 'flag': '🇯🇵'},
      {'name': 'Jordan', 'flag': '🇯🇴'},
      {'name': 'Kazakhstan', 'flag': '🇰🇿'},
      {'name': 'Kenya', 'flag': '🇰🇪'},
      {'name': 'Kiribati', 'flag': '🇰🇮'},
      {'name': 'Kosovo', 'flag': '🇽🇰'},
      {'name': 'Kuwait', 'flag': '🇰🇼'},
      {'name': 'Kyrgyzstan', 'flag': '🇰🇬'},
      {'name': 'Laos', 'flag': '🇱🇦'},
      {'name': 'Latvia', 'flag': '🇱🇻'},
      {'name': 'Lebanon', 'flag': '🇱🇧'},
      {'name': 'Lesotho', 'flag': '🇱🇸'},
      {'name': 'Liberia', 'flag': '🇱🇷'},
      {'name': 'Libya', 'flag': '🇱🇾'},
      {'name': 'Liechtenstein', 'flag': '🇱🇮'},
      {'name': 'Lithuania', 'flag': '🇱🇹'},
      {'name': 'Luxembourg', 'flag': '🇱🇺'},
      {'name': 'Madagascar', 'flag': '🇲🇬'},
      {'name': 'Malawi', 'flag': '🇲🇼'},
      {'name': 'Malaysia', 'flag': '🇲🇾'},
      {'name': 'Maldives', 'flag': '🇲🇻'},
      {'name': 'Mali', 'flag': '🇲🇱'},
      {'name': 'Malta', 'flag': '🇲🇹'},
      {'name': 'Marshall Islands', 'flag': '🇲🇭'},
      {'name': 'Mauritania', 'flag': '🇲🇷'},
      {'name': 'Mauritius', 'flag': '🇲🇺'},
      {'name': 'Mexico', 'flag': '🇲🇽'},
      {'name': 'Micronesia', 'flag': '🇫🇲'},
      {'name': 'Moldova', 'flag': '🇲🇩'},
      {'name': 'Monaco', 'flag': '🇲🇨'},
      {'name': 'Mongolia', 'flag': '🇲🇳'},
      {'name': 'Montenegro', 'flag': '🇲🇪'},
      {'name': 'Morocco', 'flag': '🇲🇦'},
      {'name': 'Mozambique', 'flag': '🇲🇿'},
      {'name': 'Myanmar', 'flag': '🇲🇲'},
      {'name': 'Namibia', 'flag': '🇳🇦'},
      {'name': 'Nauru', 'flag': '🇳🇷'},
      {'name': 'Nepal', 'flag': '🇳🇵'},
      {'name': 'Netherlands', 'flag': '🇳🇱'},
      {'name': 'New Zealand', 'flag': '🇳🇿'},
      {'name': 'Nicaragua', 'flag': '🇳🇮'},
      {'name': 'Niger', 'flag': '🇳🇪'},
      {'name': 'Nigeria', 'flag': '🇳🇬'},
      {'name': 'North Korea', 'flag': '🇰🇵'},
      {'name': 'North Macedonia', 'flag': '🇲🇰'},
      {'name': 'Norway', 'flag': '🇳🇴'},
      {'name': 'Oman', 'flag': '🇴🇲'},
      {'name': 'Pakistan', 'flag': '🇵🇰'},
      {'name': 'Palau', 'flag': '🇵🇼'},
      {'name': 'Palestine', 'flag': '🇵🇸'},
      {'name': 'Panama', 'flag': '🇵🇦'},
      {'name': 'Papua New Guinea', 'flag': '🇵🇬'},
      {'name': 'Paraguay', 'flag': '🇵🇾'},
      {'name': 'Peru', 'flag': '🇵🇪'},
      {'name': 'Philippines', 'flag': '🇵🇭'},
      {'name': 'Poland', 'flag': '🇵🇱'},
      {'name': 'Portugal', 'flag': '🇵🇹'},
      {'name': 'Qatar', 'flag': '🇶🇦'},
      {'name': 'Romania', 'flag': '🇷🇴'},
      {'name': 'Russia', 'flag': '🇷🇺'},
      {'name': 'Rwanda', 'flag': '🇷🇼'},
      {'name': 'Saint Kitts and Nevis', 'flag': '🇰🇳'},
      {'name': 'Saint Lucia', 'flag': '🇱🇨'},
      {'name': 'Saint Vincent and the Grenadines', 'flag': '🇻🇨'},
      {'name': 'Samoa', 'flag': '🇼🇸'},
      {'name': 'San Marino', 'flag': '🇸🇲'},
      {'name': 'Sao Tome and Principe', 'flag': '🇸🇹'},
      {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
      {'name': 'Senegal', 'flag': '🇸🇳'},
      {'name': 'Serbia', 'flag': '🇷🇸'},
      {'name': 'Seychelles', 'flag': '🇸🇨'},
      {'name': 'Sierra Leone', 'flag': '🇸🇱'},
      {'name': 'Singapore', 'flag': '🇸🇬'},
      {'name': 'Slovakia', 'flag': '🇸🇰'},
      {'name': 'Slovenia', 'flag': '🇸🇮'},
      {'name': 'Solomon Islands', 'flag': '🇸🇧'},
      {'name': 'Somalia', 'flag': '🇸🇴'},
      {'name': 'South Africa', 'flag': '🇿🇦'},
      {'name': 'South Korea', 'flag': '🇰🇷'},
      {'name': 'South Sudan', 'flag': '🇸🇸'},
      {'name': 'Spain', 'flag': '🇪🇸'},
      {'name': 'Sri Lanka', 'flag': '🇱🇰'},
      {'name': 'Sudan', 'flag': '🇸🇩'},
      {'name': 'Suriname', 'flag': '🇸🇷'},
      {'name': 'Sweden', 'flag': '🇸🇪'},
      {'name': 'Switzerland', 'flag': '🇨🇭'},
      {'name': 'Syria', 'flag': '🇸🇾'},
      {'name': 'Taiwan', 'flag': '🇹🇼'},
      {'name': 'Tajikistan', 'flag': '🇹🇯'},
      {'name': 'Tanzania', 'flag': '🇹🇿'},
      {'name': 'Thailand', 'flag': '🇹🇭'},
      {'name': 'Timor-Leste', 'flag': '🇹🇱'},
      {'name': 'Togo', 'flag': '🇹🇬'},
      {'name': 'Tonga', 'flag': '🇹🇴'},
      {'name': 'Trinidad and Tobago', 'flag': '🇹🇹'},
      {'name': 'Tunisia', 'flag': '🇹🇳'},
      {'name': 'Turkey', 'flag': '🇹🇷'},
      {'name': 'Turkmenistan', 'flag': '🇹🇲'},
      {'name': 'Tuvalu', 'flag': '🇹🇻'},
      {'name': 'Uganda', 'flag': '🇺🇬'},
      {'name': 'Ukraine', 'flag': '🇺🇦'},
      {'name': 'United Arab Emirates', 'flag': '🇦🇪'},
      {'name': 'United Kingdom', 'flag': '🇬🇧'},
      {'name': 'United States', 'flag': '🇺🇸'},
      {'name': 'Uruguay', 'flag': '🇺🇾'},
      {'name': 'Uzbekistan', 'flag': '🇺🇿'},
      {'name': 'Vanuatu', 'flag': '🇻🇺'},
      {'name': 'Vatican City', 'flag': '🇻🇦'},
      {'name': 'Venezuela', 'flag': '🇻🇪'},
      {'name': 'Vietnam', 'flag': '🇻🇳'},
      {'name': 'Yemen', 'flag': '🇾🇪'},
      {'name': 'Zambia', 'flag': '🇿🇲'},
      {'name': 'Zimbabwe', 'flag': '🇿🇼'},
    ];
  }

  String getCountryFlag(String countryName) {
    final countries = getAllCountries();
    final country = countries.firstWhere(
      (c) => c['name'] == countryName,
      orElse: () => {'name': 'United States', 'flag': '🇺🇸'},
    );
    return country['flag']!;
  }

  Future<void> _selectCountry() async {
    final countries = getAllCountries();
    String searchQuery = '';

    final selectedCountry = await showDialog<String>(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setDialogState) {
              final filteredCountries =
                  countries.where((country) {
                    return country['name']!.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    );
                  }).toList();

              return Dialog(
                backgroundColor: const Color(0xFF4A3420),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: const Color(0xFFFF6B35), width: 3),
                ),
                child: Container(
                  width: 400,
                  height: 500,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        '🌍 Select Your Country',
                        style: GoogleFonts.pressStart2p(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: const Color(0xFFF4E4BC),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Search Bar
                      TextField(
                        onChanged: (value) {
                          setDialogState(() {
                            searchQuery = value;
                          });
                        },
                        style: GoogleFonts.pressStart2p(
                          fontSize: 10,
                          color: const Color(0xFFF4E4BC),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search country...',
                          hintStyle: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: const Color(0xFFF4E4BC).withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: const Color(0xFFFF6B35),
                            size: 20,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF2C1810),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFFFF6B35),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFFFF6B35).withOpacity(0.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFFFF6B35),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Results count
                      if (searchQuery.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${filteredCountries.length} countries found',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 8,
                              color: const Color(0xFFF4E4BC).withOpacity(0.7),
                            ),
                          ),
                        ),
                      Expanded(
                        child:
                            filteredCountries.isEmpty
                                ? Center(
                                  child: Text(
                                    'No countries found',
                                    style: GoogleFonts.pressStart2p(
                                      fontSize: 8,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                : ListView.builder(
                                  itemCount: filteredCountries.length,
                                  itemBuilder: (context, index) {
                                    final country = filteredCountries[index];
                                    final isSelected =
                                        country['name'] == userCountry;

                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isSelected
                                                ? const Color(
                                                  0xFFFF6B35,
                                                ).withOpacity(0.3)
                                                : Colors.transparent,
                                        border: Border.all(
                                          color:
                                              isSelected
                                                  ? const Color(0xFFFF6B35)
                                                  : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: Text(
                                          country['flag']!,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        title: Text(
                                          country['name']!,
                                          style: GoogleFonts.pressStart2p(
                                            fontSize: 8,
                                            color: const Color(0xFFF4E4BC),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(
                                            context,
                                          ).pop(country['name']);
                                        },
                                      ),
                                    );
                                  },
                                ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );

    if (selectedCountry != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userCountry', selectedCountry);
      setState(() {
        userCountry = selectedCountry;
      });
    }
  }

  Future<void> _editUsername() async {
    final TextEditingController controller = TextEditingController(
      text: userName,
    );

    final newName = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF4A3420),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Pixel art style
              side: BorderSide(color: const Color(0xFFFF6B35), width: 3),
            ),
            title: Text(
              '🏠 Edit Name',
              style: GoogleFonts.pressStart2p(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: const Color(0xFFF4E4BC),
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4E4BC),
                border: Border.all(color: const Color(0xFF8B4513), width: 2),
              ),
              child: TextField(
                controller: controller,
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: const Color(0xFF4A3420),
                ),
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: GoogleFonts.pressStart2p(
                    fontSize: 8,
                    color: const Color(0xFF8B4513),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8),
                ),
                maxLength: 30,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, controller.text.trim()),
                child: Text(
                  'Save',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 8,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
    );

    if (newName != null && newName.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', newName);
      setState(() {
        userName = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A1F1A), // Dark cozy background
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A3420),
        foregroundColor: const Color(0xFFF4E4BC),
        title: Row(
          children: [
            // Pixel art cabin icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                border: Border.all(color: const Color(0xFFF4E4BC), width: 2),
              ),
              child: CustomPaint(painter: PixelCabinPainter()),
            ),
            const SizedBox(width: 12),
            Text(
              '🏠 Profile 🔥',
              style: GoogleFonts.pressStart2p(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFFF4E4BC),
              ),
            ),
          ],
        ),
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFFF6B35), width: 3),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Cozy Profile Header with Pixel Art Design
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF4E4BC), // Warm cream background
                border: Border.all(color: const Color(0xFF8B4513), width: 4),
              ),
              child: CustomPaint(
                painter: PixelBorderPainter(color: const Color(0xFFFF6B35)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Pixel Art Avatar
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A3420),
                          border: Border.all(
                            color: const Color(0xFFFF6B35),
                            width: 3,
                          ),
                        ),
                        child: CustomPaint(painter: PixelAvatarPainter()),
                      ),
                      const SizedBox(height: 16),

                      // Username with pixel font
                      GestureDetector(
                        onTap: _editUsername,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B4513),
                            border: Border.all(
                              color: const Color(0xFFFF6B35),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                userName,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFFF4E4BC),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B35),
                                  border: Border.all(
                                    color: const Color(0xFFF4E4BC),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 12,
                                  color: Color(0xFFF4E4BC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Country Selection
                      GestureDetector(
                        onTap: _selectCountry,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B4513),
                            border: Border.all(
                              color: const Color(0xFFFF6B35),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                getCountryFlag(userCountry),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userCountry,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFFF4E4BC),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B35),
                                  border: Border.all(
                                    color: const Color(0xFFF4E4BC),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.public,
                                  size: 12,
                                  color: Color(0xFFF4E4BC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Cozy title
                      // Royal Title or Design Master
                      hasRoyalTitle
                          ? AnimatedFireTitle(title: royalTitle!)
                          : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD2B48C),
                              border: Border.all(
                                color: const Color(0xFF8B4513),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '🏠 Design Master 🔥',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 10,
                                color: const Color(0xFF4A3420),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Stats Cards with Pixel Art
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Systems\nDesigned',
                    systemsDesigned.toString(),
                    '🏠',
                    const Color(0xFF228B22), // Forest green
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Quizzes\nTaken',
                    totalQuizzesTaken.toString(),
                    '📚',
                    const Color(0xFFFF6347), // Tomato red
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Best\nScore',
                    '$highestScore/50',
                    '⭐',
                    const Color(0xFFFFD700), // Gold
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Fastest\nTime',
                    fastestTime,
                    '⚡',
                    const Color(0xFF9370DB), // Medium purple
                    valueFontSize: 7, // Half of default 14
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Progress Chart or Empty State
            if (quizHistory.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4E4BC),
                  border: Border.all(color: const Color(0xFF8B4513), width: 4),
                ),
                child: CustomPaint(
                  painter: PixelBorderPainter(color: const Color(0xFFFF6B35)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // Header with pixel styling
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B4513),
                            border: Border.all(
                              color: const Color(0xFFFF6B35),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            '📈 Progress Journey 🔥',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFFF4E4BC),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: const Color(0xFF8B4513),
                                  width: 2,
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots:
                                      quizHistory
                                          .map(
                                            (quiz) => FlSpot(
                                              quiz['quizNumber'].toDouble(),
                                              quiz['score'].toDouble(),
                                            ),
                                          )
                                          .toList(),
                                  isCurved:
                                      false, // Pixel art style - no curves
                                  color: const Color(0xFFFF6B35),
                                  barWidth: 3,
                                  dotData: const FlDotData(show: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4E4BC),
                  border: Border.all(color: const Color(0xFF8B4513), width: 4),
                ),
                child: CustomPaint(
                  painter: PixelBorderPainter(color: const Color(0xFFFF6B35)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // Pixel art icon for no data
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B4513),
                            border: Border.all(
                              color: const Color(0xFFFF6B35),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text('📊', style: TextStyle(fontSize: 30)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No data yet!',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 12,
                            color: const Color(0xFF4A3420),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Take some quizzes to see your\nprogress journey!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: const Color(0xFF8B4513),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    String emoji,
    Color color, {
    double? valueFontSize,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4E4BC), // Warm cream
        border: Border.all(color: const Color(0xFF8B4513), width: 3),
        // No border radius for pixel art style
      ),
      child: CustomPaint(
        painter: PixelBorderPainter(color: color),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Pixel art style emoji container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: const Color(0xFFF4E4BC), width: 2),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 12),

              // Value with pixel font
              Text(
                value,
                style: GoogleFonts.pressStart2p(
                  fontSize: valueFontSize ?? 14,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF4A3420),
                ),
              ),
              const SizedBox(height: 8),

              // Label with pixel font
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 8,
                  color: const Color(0xFF8B4513),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for pixel art cabin icon
class PixelCabinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Roof (brown)
    paint.color = const Color(0xFF8B4513);
    canvas.drawRect(Rect.fromLTWH(4, 4, 24, 8), paint);

    // Roof peak
    canvas.drawRect(Rect.fromLTWH(8, 0, 16, 4), paint);

    // Wall (lighter brown)
    paint.color = const Color(0xFFD2B48C);
    canvas.drawRect(Rect.fromLTWH(6, 12, 20, 16), paint);

    // Door (dark brown)
    paint.color = const Color(0xFF654321);
    canvas.drawRect(Rect.fromLTWH(12, 18, 8, 10), paint);

    // Window (yellow - warm light)
    paint.color = const Color(0xFFFFD700);
    canvas.drawRect(Rect.fromLTWH(8, 14, 4, 4), paint);
    canvas.drawRect(Rect.fromLTWH(20, 14, 4, 4), paint);

    // Chimney
    paint.color = const Color(0xFF696969);
    canvas.drawRect(Rect.fromLTWH(20, 2, 4, 10), paint);

    // Chimney smoke (light gray)
    paint.color = const Color(0xFFD3D3D3);
    canvas.drawRect(Rect.fromLTWH(22, 0, 2, 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for pixel decorative border
class PixelBorderPainter extends CustomPainter {
  final Color color;

  PixelBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Top border pattern
    for (double x = 0; x < size.width; x += 8) {
      canvas.drawRect(Rect.fromLTWH(x, 0, 4, 4), paint);
    }

    // Bottom border pattern
    for (double x = 0; x < size.width; x += 8) {
      canvas.drawRect(Rect.fromLTWH(x, size.height - 4, 4, 4), paint);
    }

    // Left border pattern
    for (double y = 0; y < size.height; y += 8) {
      canvas.drawRect(Rect.fromLTWH(0, y, 4, 4), paint);
    }

    // Right border pattern
    for (double y = 0; y < size.height; y += 8) {
      canvas.drawRect(Rect.fromLTWH(size.width - 4, y, 4, 4), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Animated Fire Title Widget with Red Crowns in Corners
class AnimatedFireTitle extends StatefulWidget {
  final String title;

  const AnimatedFireTitle({super.key, required this.title});

  @override
  State<AnimatedFireTitle> createState() => _AnimatedFireTitleState();
}

class _AnimatedFireTitleState extends State<AnimatedFireTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFD700), // Gold
                Color(0xFFFFA500), // Orange
                Color(0xFFFFD700), // Gold
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5 + (_controller.value * 0.5), 1.0],
            ),
            border: Border.all(color: const Color(0xFFFF4500), width: 3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(
                  0xFFFF4500,
                ).withOpacity(0.6 + (_controller.value * 0.2)),
                blurRadius: 15,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color(0xFFFF6347).withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Red crown shapes in corners (custom painted)
              Positioned(
                top: 0,
                left: 0,
                child: CustomPaint(
                  size: Size(12, 12),
                  painter: CrownPainter(
                    color: Color(0xFFFF0000),
                    glowIntensity: _controller.value,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CustomPaint(
                  size: Size(12, 12),
                  painter: CrownPainter(
                    color: Color(0xFFFF0000),
                    glowIntensity: _controller.value,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomPaint(
                  size: Size(8, 12),
                  painter: FirePainter(intensity: _controller.value),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  size: Size(8, 12),
                  painter: FirePainter(intensity: _controller.value),
                ),
              ),
              // Title text
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.pressStart2p(
                      fontSize: 8,
                      color: const Color(0xFF1A0D00),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Color(0xFFFF4500).withOpacity(0.8),
                          blurRadius: 3 + (_controller.value * 2),
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Custom Crown Painter
class CrownPainter extends CustomPainter {
  final Color color;
  final double glowIntensity;

  CrownPainter({required this.color, required this.glowIntensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Crown base
    canvas.drawRect(Rect.fromLTWH(2, 8, 8, 4), paint);

    // Crown peaks (3 points)
    canvas.drawRect(Rect.fromLTWH(2, 5, 2, 3), paint);
    canvas.drawRect(Rect.fromLTWH(5, 3, 2, 5), paint);
    canvas.drawRect(Rect.fromLTWH(8, 5, 2, 3), paint);

    // Glow effect
    final glowPaint =
        Paint()
          ..color = Color(0xFFFF4500).withOpacity(0.3 + (glowIntensity * 0.3))
          ..style = PaintingStyle.fill
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            2 + glowIntensity * 2,
          );

    canvas.drawRect(Rect.fromLTWH(1, 7, 10, 6), glowPaint);
  }

  @override
  bool shouldRepaint(CrownPainter oldDelegate) =>
      oldDelegate.glowIntensity != glowIntensity;
}

// Custom Fire Painter
class FirePainter extends CustomPainter {
  final double intensity;

  FirePainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    // Fire flame shape (simple triangle/flame)
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..shader = LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFFF0000), // Red at bottom
              Color(0xFFFF4500), // Orange-red
              Color(0xFFFFA500), // Orange at top
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Animated flame path
    final flamePath = Path();
    flamePath.moveTo(size.width / 2, size.height);
    flamePath.lineTo(0, size.height - 6);
    flamePath.lineTo(size.width / 2, intensity * 3);
    flamePath.lineTo(size.width, size.height - 6);
    flamePath.close();

    canvas.drawPath(flamePath, paint);

    // Inner brighter flame
    final innerPaint =
        Paint()
          ..color = Color(0xFFFFFF00).withOpacity(0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1 + intensity);

    canvas.drawCircle(
      Offset(size.width / 2, size.height - 4),
      2 + intensity,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(FirePainter oldDelegate) =>
      oldDelegate.intensity != intensity;
}

// Custom painter for pixel art avatar
class PixelAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Head (skin color)
    paint.color = const Color(0xFFFFDBB3);
    canvas.drawRect(Rect.fromLTWH(30, 20, 40, 40), paint);

    // Eyes (black)
    paint.color = const Color(0xFF000000);
    canvas.drawRect(Rect.fromLTWH(35, 30, 6, 6), paint);
    canvas.drawRect(Rect.fromLTWH(59, 30, 6, 6), paint);

    // Nose (darker skin)
    paint.color = const Color(0xFFE6C2A6);
    canvas.drawRect(Rect.fromLTWH(47, 38, 6, 4), paint);

    // Mouth (red)
    paint.color = const Color(0xFFFF4444);
    canvas.drawRect(Rect.fromLTWH(42, 48, 16, 4), paint);

    // Hair (brown)
    paint.color = const Color(0xFF8B4513);
    canvas.drawRect(Rect.fromLTWH(25, 10, 50, 15), paint);

    // Body (shirt - cozy sweater color)
    paint.color = const Color(0xFFD2B48C);
    canvas.drawRect(Rect.fromLTWH(25, 60, 50, 30), paint);

    // Cozy scarf
    paint.color = const Color(0xFFFF6B35);
    canvas.drawRect(Rect.fromLTWH(30, 55, 40, 8), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
