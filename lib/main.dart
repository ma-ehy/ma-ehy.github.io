import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(BedrockRankedApp());
}

class BedrockRankedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bedrock Ranked',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        cardColor: Color(0xFF1D1E33),
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.purpleAccent,
          surface: Color(0xFF1D1E33),
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          LeaderboardScreen(),
          SoloTab(),
          TutorialScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Color(0xFF1D1E33),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Solo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tutorial',
          ),
        ],
      ),
    );
  }
}

// Social buttons widget for reuse across screens
class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _launchURL('https://discord.gg/9phEyBQXbN'),
              icon: Icon(Icons.discord, size: 20),
              label: Text('JOIN DISCORD'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5865F2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _launchURL('https://www.youtube.com/@MCBESRRanked'),
              icon: Icon(Icons.play_arrow, size: 20),
              label: Text('YOUTUBE'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF0000),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0E21), Color(0xFF1D1E33)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(8),
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.deepPurple, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/title.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Text(
                                    'BEDROCK RANKED',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        
                        // Subtitle
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Welcome to Bedrock Ranked!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.purpleAccent,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        
                        // Buttons
                        SizedBox(height: 16),
                        _buildActionButton(
                          context,
                          'GET STARTED',
                          Icons.play_arrow,
                          () => _showInfoDialog(context, 'Get Started', 'Welcome to Bedrock Ranked!\n\nRanked is a concept where you compete with fellow runners to see who can complete a seed fastest.\nThere are currently 7 modes in Ranked:\nstronghold village 1.16, ruined portal 1.16, village 1.16, desert temple 1.16, shipwreck 1.16,warped forest 1.18+ and bastion 1.18+.\nTo start, you will need the correct version of Minecraft Bedrock Edition (either 1.16 or any version 1.21.60+)\nand, if you are able to download them, the behavior packs in the packs channel of the discord server https://discord.gg/9phEyBQXbN.\nIf you cannot download the packs (i.e. you are a console player or dont have discord) you will have to play 1.21 warped seeds.\nYou will also need a recording software to record your ranked runs, but not solo runs.'),
                        ),
                        SizedBox(height: 12),
                        _buildActionButton(
                          context,
                          'RULES',
                          Icons.rule,
                          () => _showInfoDialog(context, 'Rules', 'To start playing:\n\n• Do the command !queue in the queue channel or in the bots DMs\n• When an opponent is found, you will be pinged and the match will start in a dedicated thread.\n• In the matches, dont spam ping your opponent, answer to pings, never use commands or creative or any other form of cheating\n(where not started, speedrun.com rules apply) and report issues in the dedicated channel.\n\nViolations may result in penalties or bans.'),
                        ),
                        SizedBox(height: 12),
                        _buildActionButton(
                          context,
                          'FAQ',
                          Icons.question_answer,
                          () => _showInfoDialog(context, 'FAQ', 'Frequently Asked Questions:\n\nQ: How does this work?\nA: Bedrock Ranked is hosted through this discord bot in the server https://discord.gg/9phEyBQXbN.\nIn this website you can get statistics and get solo seeds.\n\nQ: What is an add-on?\nA: An add-on is a collection of behavior and resource packs, which modify some aspect of the game.\nDownload the .mcaddon file from packs and open it with Minecraft.\nThen, in "resource packs" section in the settings page and in "behavior pack" section in world creation there will show up a pack.\n\nQ: Is this viable on console?\nA: Yes! Just make sure to choose "1.18+" and "no pack" when prompted.\nYou will play warped forest 1.18+ seeds as they are those that dont require any pack to be played.'),
                        ),
                        SizedBox(height: 32),
                        
                        // Quick Stats Section
                        Text(
                          'QUICK STATS',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: Colors.purpleAccent,
                          ),
                        ),
                        SizedBox(height: 16),
                        FutureBuilder<Map<String, dynamic>>(
                          future: BedrockAPI().getOverview(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
                            }
                            
                            final data = snapshot.data!;
                            return _buildQuickStatsCard(
                              data['total_players'] ?? 0,
                              data['total_games'] ?? 0,
                              data['active_players'] ?? 0,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildActionButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1D1E33),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.deepPurple.withOpacity(0.5)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.deepPurple),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1D1E33),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        title: Row(
          children: [
            Icon(Icons.info, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            content,
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CLOSE', style: TextStyle(color: Colors.deepPurple)),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickStatsCard(int totalPlayers, int totalGames, int activePlayers) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, color: Colors.purpleAccent),
                SizedBox(width: 8),
                Text(
                  'SERVER STATISTICS',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn('TOTAL\nPLAYERS', '$totalPlayers', Icons.people),
                Container(width: 2, height: 50, color: Colors.deepPurple.withOpacity(0.3)),
                _buildStatColumn('ACTIVE\nPLAYERS', '$activePlayers', Icons.people_alt),
                Container(width: 2, height: 50, color: Colors.deepPurple.withOpacity(0.3)),
                _buildStatColumn('TOTAL\nGAMES', '$totalGames', Icons.sports_esports),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatColumn(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 9, color: Colors.grey[400]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  bool _isLoading = true;
  List<dynamic>? _leaderboard;
  String _errorMessage = '';
  int _leaderboardLimit = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = _leaderboard == null;
      _errorMessage = '';
    });

    try {
      final api = BedrockAPI();
      final leaderboard = await api.getLeaderboard(limit: _leaderboardLimit);

      setState(() {
        _leaderboard = leaderboard;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMorePlayers() async {
    final currentPosition = _scrollController.position.pixels;

    setState(() {
      _leaderboardLimit += 10;
    });

    await _loadData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(currentPosition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0E21), Color(0xFF1D1E33)],
        ),
      ),
      child: SafeArea(
        child: _isLoading && _leaderboard == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.deepPurple),
                    SizedBox(height: 20),
                    Text('Loading...'),
                  ],
                ),
              )
            : _errorMessage.isNotEmpty && _leaderboard == null
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 64, color: Colors.red),
                          SizedBox(height: 16),
                          Text(
                            _errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadData,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                            child: Text('RETRY'),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _leaderboardLimit = 10;
                            await _loadData();
                          },
                          color: Colors.deepPurple,
                          child: CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              SliverToBoxAdapter(
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'LEADERBOARD',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.5,
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'TOP $_leaderboardLimit',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    child: SizedBox(),
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                sliver: SliverToBoxAdapter(
                                  child: Center(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 800),
                                      child: Column(
                                        children: _leaderboard != null && _leaderboard!.isNotEmpty
                                            ? _leaderboard!.map((entry) => _buildLeaderboardCard(entry)).toList()
                                            : [Center(child: Text('No players found'))],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                                      child: Center(
                                        child: _isLoading
                                            ? CircularProgressIndicator(color: Colors.deepPurple)
                                            : ElevatedButton.icon(
                                                onPressed: _loadMorePlayers,
                                                icon: Icon(Icons.expand_more),
                                                label: Text('LOAD MORE PLAYERS'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.deepPurple,
                                                  foregroundColor: Colors.white,
                                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 800),
                          child: SocialButtons(),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildLeaderboardCard(Map<String, dynamic> entry) {
    final rank = entry['rank'] as int;
    final user = entry['user'] as Map<String, dynamic>;
    final elo = entry['elo'] as int;
    final wins = entry['wins'] as int;
    final losses = entry['losses'] as int;
    final winRate = entry['win_rate'] as double;
    final userId = user['id'] as String;

    Color rankColor = rank == 1
        ? Colors.amber
        : rank == 2
            ? Colors.grey
            : rank == 3
                ? Colors.brown
                : Colors.deepPurple;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: rank <= 3 ? rankColor.withOpacity(0.5) : Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayerDetailScreen(userId: userId)),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: rankColor, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '#$rank',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: rank <= 3 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['display_name'] ?? user['name'] ?? 'Player',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 12, color: Colors.green),
                          SizedBox(width: 4),
                          Text('$wins', style: TextStyle(color: Colors.green, fontSize: 12)),
                          SizedBox(width: 8),
                          Icon(Icons.cancel, size: 12, color: Colors.red),
                          SizedBox(width: 4),
                          Text('$losses', style: TextStyle(color: Colors.red, fontSize: 12)),
                          SizedBox(width: 8),
                          Text('${winRate.toStringAsFixed(1)}%',
                              style: TextStyle(color: Colors.grey[400], fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '$elo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text('ELO', style: TextStyle(fontSize: 9, color: Colors.grey[500])),
                  ],
                ),
                SizedBox(width: 4),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Mode colors mapping
class ModeColors {
  static Color getColor(String modeId) {
    switch (modeId) {
      case 'stronghold':
        return Colors.grey;
      case 'ruined_portal':
        return Colors.red;
      case 'village':
        return Color(0xFFD2B48C); // Light brown
      case 'desert_temple':
        return Color(0xFFC2B280); // Sandy
      case 'shipwreck':
        return Colors.blue;
      case 'bastion':
        return Colors.black;
      case 'warped_forest':
        return Colors.cyan.shade300; // Light cyan
      case 'buried_treasure':
        return Colors.brown;
      default:
        return Colors.deepPurple;
    }
  }
}

class SoloTab extends StatefulWidget {
  @override
  _SoloTabState createState() => _SoloTabState();
}

class _SoloTabState extends State<SoloTab> {
  String? _selectedVersion;
  String? _selectedMode;
  Map<String, dynamic>? _modes;
  bool _isLoadingModes = true;
  String? _currentSeed;
  String? _currentModeDisplay;
  bool _isLoadingSeed = false;

  @override
  void initState() {
    super.initState();
    _loadModes();
  }

  Future<void> _loadModes() async {
    try {
      final api = BedrockAPI();
      final modes = await api.getModes();
      setState(() {
        _modes = modes;
        _isLoadingModes = false;
      });
    } catch (e) {
      setState(() => _isLoadingModes = false);
    }
  }

  Future<void> _getSeed() async {
    if (_selectedVersion == null || _selectedMode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select version and mode')),
      );
      return;
    }

    setState(() => _isLoadingSeed = true);

    try {
      final api = BedrockAPI();
      final result = await api.getSoloSeed(_selectedVersion!, _selectedMode!);

      setState(() {
        _currentSeed = result['seed'];
        _currentModeDisplay = result['mode'];
        _isLoadingSeed = false;
      });
    } catch (e) {
      setState(() => _isLoadingSeed = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingModes) {
      return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0E21), Color(0xFF1D1E33)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Card(
                        color: Color(0xFF1D1E33),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.sports_esports, color: Colors.deepPurple),
                                  SizedBox(width: 12),
                                  Text(
                                    'SOLO PRACTICE',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Practice speedrunning without affecting your ELO',
                                style: TextStyle(color: Colors.grey[400], fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('SELECT VERSION',
                          style: TextStyle(fontSize: 14, color: Colors.grey[400], letterSpacing: 1.2)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _VersionCard(
                              version: '116',
                              label: '1.16',
                              isSelected: _selectedVersion == '116',
                              onTap: () {
                                setState(() {
                                  _selectedVersion = '116';
                                  _selectedMode = null;
                                  _currentSeed = null;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _VersionCard(
                              version: '118',
                              label: '1.18+',
                              isSelected: _selectedVersion == '118',
                              onTap: () {
                                setState(() {
                                  _selectedVersion = '118';
                                  _selectedMode = null;
                                  _currentSeed = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      if (_selectedVersion != null && _modes != null) ...[
                        Text('SELECT MODE',
                            style: TextStyle(fontSize: 14, color: Colors.grey[400], letterSpacing: 1.2)),
                        SizedBox(height: 8),
                        ..._buildModeCards(),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoadingSeed ? null : _getSeed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.deepPurple.withOpacity(0.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: _isLoadingSeed
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'GET SEED',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                      if (_currentSeed != null) ...[
                        SizedBox(height: 24),
                        Card(
                          color: ModeColors.getColor(_selectedMode!).withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: ModeColors.getColor(_selectedMode!), width: 2),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Icon(Icons.key, size: 48, color: ModeColors.getColor(_selectedMode!)),
                                SizedBox(height: 16),
                                Text(_currentModeDisplay ?? 'Seed',
                                    style: TextStyle(fontSize: 18, color: Colors.grey[400])),
                                SizedBox(height: 12),
                                SelectableText(
                                  _currentSeed!,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: ModeColors.getColor(_selectedMode!),
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                Text('Tap to copy',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildModeCards() {
    if (_selectedVersion == null || _modes == null) return [];

    final versionModes = _modes![_selectedVersion!]['modes'] as List;

    return versionModes.map((mode) {
      final modeId = mode['id'] as String;
      final modeName = mode['name'] as String;
      final isSelected = _selectedMode == modeId;

      return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedMode = modeId;
              _currentSeed = null;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.deepPurple.withOpacity(0.3) : Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.deepPurple : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? Colors.deepPurple : Colors.grey,
                ),
                SizedBox(width: 12),
                Text(
                  modeName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _VersionCard extends StatelessWidget {
  final String version;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  _VersionCard({
    required this.version,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple.withOpacity(0.3) : Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final Map<String, bool> _expandedSections = {
    'gettingStarted': false,
    'overworld': false,
    'nether': false,
    'end': false,
    'more': false,
  };

  final Map<String, bool> _expandedNested = {
    'introText': false,
    'strongholdNav': false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0E21), Color(0xFF1D1E33)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Text(
                        'TUTORIALS',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.purpleAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Welcome to Minecraft Bedrock Edition speedrunning! Here are comprehensive guides to help you get started and improve your runs.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      
                      // Getting Started
                      _buildSection(
                        'gettingStarted',
                        'Getting Started',
                        [
                          _buildNestedToggle(
                            'introText',
                            'Introduction to speedrunning',
                            'Speedrunning means completing a game as fast as possible. In Minecraft: Bedrock Edition, you beat the game by killing the Ender Dragon. You can do it on a random seed (RSG), a set seed (SSG) or a filtered seed (FSG). You can play on multiple versions, the best for RSG and FSG being 1.16.1.',
                          ),
                          _buildVideoLink('Setup video', 'https://www.youtube.com/watch?v=ZmYLPMXG78E'),
                          _buildTextLink('How to Downgrade and manage versions', 'https://bedrocklauncher.github.io/'),
                          _buildTextLink('Multi Instance', 'https://github.com/l0l869/Multi-Resets'),
                          _buildTextLink('Aurora Store', 'https://share.google/UMaWaBII1OYU0G03O'),
                        ],
                      ),
                      
                      // Overworld
                      _buildSection(
                        'overworld',
                        'Overworld',
                        [
                          _buildTextLink('How to loot villages', 'https://www.youtube.com/watch?v=82Edi8ISiGI&list=PLUsJ33X2NbX07_6J7X8ZBflh5O_AZYrlC&index=2'),
                          _buildTextLink('Sprinkz Strat (always dig into a stronghold)', 'https://www.youtube.com/playlist?list=PLyDxVGuWeXOXJEAIy-ZP4xk6iY44LIG8X'),
                          _buildNestedToggle(
                            'strongholdNav',
                            'Stronghold navigation tips',
                            _buildStrongholdContent(),
                          ),
                          _buildVideoLink('How to build nether portal', 'https://www.youtube.com/watch?v=8kxGrxXm-TI'),
                        ],
                      ),
                      
                      // Nether
                      _buildSection(
                        'nether',
                        'Nether',
                        [
                          _buildVideoLink('Nether navigation', 'https://www.youtube.com/watch?v=BctoHt7iT3w'),
                          _buildVideoLink('Bastion routes (1.16)', 'https://www.youtube.com/watch?v=fVKeNVLXvu8'),
                          _buildTextLink('Bastion Routes (1.18+)', 'https://youtube.com/playlist?list=PLGBrWpXuQPk8PqIKPAaMxN4ubnfCNFJKq&si=fBzCrqT2-M_aOS3t'),
                          _buildVideoLink('Fortress navigation', 'https://www.youtube.com/watch?v=QDsZZbN2TlM'),
                        ],
                      ),
                      
                      // End
                      _buildSection(
                        'end',
                        'End',
                        [
                          _buildDragonBehavior(),
                          _buildVideoLink('One cycle tutorial', 'https://www.youtube.com/watch?v=tqHYjEGC29g'),
                        ],
                      ),
                      
                      // More
                      _buildSection(
                        'more',
                        'More',
                        [
                          _buildVideoLink('All achievements speedrun', 'https://www.youtube.com/watch?v=1an3IF2L9X0'),
                          _buildTextLink('RSG Manifesto', 'https://docs.google.com/document/d/1cOCFuveIcJtDyydTCs33HRvk9e-ZlHgfrfTk8Ao82Ck/edit?usp=sharing'),
                          _buildTextLink('Village Grid 1.16', 'https://docs.google.com/spreadsheets/d/1fkdKPOZW-yeP1R0rSzqSvdzquAaNfiqdRlpCCIRHXOY/edit?usp=sharing'),
                          _buildTextLink('Other tutorials playlist', 'https://youtube.com/playlist?list=PLGBrWpXuQPk9oNIyUGr72mToubz9arJ45&si=WmA9j0gJLg4zZJka'),
                          _buildTextLink('mcbe.wtf - Comprehensive Bedrock speedrunning resource', 'https://mcbe.wtf'),
                        ],
                      ),
                      
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Keep practicing and don\'t get discouraged! Every speedrunner started as a beginner.',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String key, String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[key] = !_expandedSections[key]!;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    _expandedSections[key]! ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_expandedSections[key]!)
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNestedToggle(String key, String title, dynamic content) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedNested[key] = !(_expandedNested[key] ?? false);
              });
            },
            child: Row(
              children: [
                Icon(
                  _expandedNested[key] ?? false ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.deepPurple,
                  size: 20,
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.purpleAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_expandedNested[key] ?? false)
            Padding(
              padding: EdgeInsets.only(left: 24, top: 8),
              child: content is String
                  ? Text(
                      content,
                      style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                    )
                  : content,
            ),
        ],
      ),
    );
  }

  Widget _buildTextLink(String title, String url) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            Icon(Icons.link, size: 16, color: Colors.blue),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoLink(String title, String url) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey[300]),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () => _launchURL(url),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.play_circle_outline, color: Colors.red, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Watch on YouTube',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(Icons.open_in_new, color: Colors.red, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrongholdContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good rooms:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        Text('• Stairs are good, go down when you can', style: TextStyle(fontSize: 13)),
        Text('• 4 ways are good', style: TextStyle(fontSize: 13)),
        Text('• 5/6 ways are good', style: TextStyle(fontSize: 13)),
        Text('• Long hallways (jail rooms) are good', style: TextStyle(fontSize: 13)),
        SizedBox(height: 8),
        Text(
          'Bad rooms:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        Text('• Small rooms like corners are bad', style: TextStyle(fontSize: 13)),
        SizedBox(height: 8),
        Text(
          'Tips:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan),
        ),
        Text('• Go about 8-10 rooms deep in each direction', style: TextStyle(fontSize: 13)),
        Text('• If starter has multiple directions, try the most isolated way', style: TextStyle(fontSize: 13)),
        Text('• 2 directions off same wall in starter are almost always bad', style: TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _buildDragonBehavior() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dragon behavior:',
            style: TextStyle(fontSize: 14, color: Colors.grey[300]),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              InkWell(
                onTap: () => _launchURL('https://youtu.be/_658wh9_yE8?si=HRF-0K6XbtFfY6qt'),
                child: Text(
                  '1.18+',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              Text(' | ', style: TextStyle(color: Colors.grey)),
              InkWell(
                onTap: () => _launchURL('https://youtu.be/ZB-woZUvmbQ?si=4sHiq5PZbvA1b4jF'),
                child: Text(
                  '1.16',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open link')),
      );
    }
  }
}

class PlayerDetailScreen extends StatefulWidget {
  final String userId;

  PlayerDetailScreen({required this.userId});

  @override
  _PlayerDetailScreenState createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _playerData;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final api = BedrockAPI();
      final player = await api.getPlayerStats(widget.userId);

      setState(() {
        _playerData = player;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _showFullStats() async {
    showDialog(
      context: context,
      builder: (context) => FullStatsDialog(userId: widget.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E21), Color(0xFF1D1E33)],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.deepPurple))
              : _errorMessage.isNotEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, size: 64, color: Colors.red),
                            SizedBox(height: 16),
                            Text(
                              _errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadPlayerData,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                              child: Text('RETRY'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : _buildPlayerDetails(),
        ),
      ),
    );
  }

  Widget _buildPlayerDetails() {
    if (_playerData == null) {
      return Center(child: Text('No player data'));
    }

    final user = _playerData!['user'] as Map<String, dynamic>;
    final elo = _playerData!['elo'] as int;
    final peakElo = _playerData!['peak_elo'] as int;
    final totalGames = _playerData!['total_games'] as int;
    final wins = _playerData!['wins'] as int;
    final losses = _playerData!['losses'] as int;
    final draws = _playerData!['draws'] as int;
    final forfeits = _playerData!['forfeits'] as int;
    final winRate = _playerData!['win_rate'] as double;
    final wlRatio = _playerData!['wl_ratio'] as double;
    final avgTime = _playerData!['avg_completion_time'] as String?;
    
    final streaks = _playerData!['streaks'] as Map<String, dynamic>;
    final currentStreak = streaks['current_streak'] as int;
    final currentStreakType = streaks['current_streak_type'] as String?;
    final bestWinStreak = streaks['best_win_streak'] as int;
    final bestLossStreak = streaks['best_loss_streak'] as int;
    
    final modeStats = _playerData!['mode_stats'] as Map<String, dynamic>;
    final eloHistory = _playerData!['elo_history'] as List<dynamic>?;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: Color(0xFF1D1E33),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: ElevatedButton.icon(
                onPressed: _showFullStats,
                icon: Icon(Icons.assessment, size: 20),
                label: Text('FULL STATS'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepPurple, Color(0xFF1D1E33)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage:
                        user['avatar_url'] != null ? NetworkImage(user['avatar_url']) : null,
                    child: user['avatar_url'] == null ? Icon(Icons.person, size: 50) : null,
                  ),
                  SizedBox(height: 12),
                  Text(
                    user['display_name'] ?? user['name'] ?? 'Player',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Statistics for ${user['display_name'] ?? user['name'] ?? 'Player'}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // ELO Stats
                    _buildEloCard(elo, peakElo),
                    SizedBox(height: 12),
                    
                    // Main Stats Grid
                    Row(
                      children: [
                        Expanded(child: _buildStatCard('TOTAL GAMES', '$totalGames', Icons.sports_esports, Colors.blue)),
                        SizedBox(width: 12),
                        Expanded(child: _buildStatCard('WINS', '$wins', Icons.check_circle, Colors.green)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildStatCard('LOSSES', '$losses', Icons.cancel, Colors.red)),
                        SizedBox(width: 12),
                        Expanded(child: _buildStatCard('DRAWS', '$draws', Icons.minimize, Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 12),
                    
                    // Streak Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'CURRENT STREAK',
                            currentStreak > 0
                                ? '$currentStreak ${currentStreakType == 'win' ? 'Win' : 'Loss'} Streak'
                                : 'No Streak',
                            currentStreakType == 'win' ? Icons.local_fire_department : Icons.ac_unit,
                            currentStreakType == 'win' ? Colors.orange : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard('BEST WIN STREAK', '$bestWinStreak', Icons.emoji_events, Colors.amber),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard('WORST LOSS STREAK', '$bestLossStreak', Icons.sentiment_dissatisfied, Colors.purple),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    
                    // Additional Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'W/L RATIO',
                            wlRatio == wlRatio.toInt() ? '${wlRatio.toInt()}' : wlRatio.toStringAsFixed(2),
                            Icons.percent,
                            Colors.teal,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(child: _buildStatCard('FORFEITS', '$forfeits', Icons.flag, Colors.orange)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'AVG TIME',
                            avgTime ?? 'N/A',
                            Icons.timer,
                            Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Performance Analytics
                    Text(
                      'PERFORMANCE ANALYTICS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildPieChart(wins, losses, draws),
                    
                    if (eloHistory != null && eloHistory.isNotEmpty) ...[
                      SizedBox(height: 16),
                      _buildEloProgression(eloHistory),
                    ],
                    
                    SizedBox(height: 24),
                    
                    // Mode Stats
                    Text(
                      'STATS BY MODE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildModeStats(modeStats),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEloCard(int elo, int peakElo) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, color: Colors.purpleAccent, size: 28),
              SizedBox(width: 8),
              Text(
                'ELO RATING',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Current ELO', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
                  SizedBox(height: 8),
                  Text(
                    '$elo',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              Container(width: 2, height: 60, color: Colors.deepPurple.withOpacity(0.3)),
              Column(
                children: [
                  Text('Peak ELO', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
                  SizedBox(height: 8),
                  Text(
                    '$peakElo',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey[400], letterSpacing: 1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(int wins, int losses, int draws) {
    final total = wins + losses + draws;
    if (total == 0) {
      return Container(
        height: 250,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
        ),
        child: Center(child: Text('No games played yet')),
      );
    }

    return Container(
      height: 250,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            'WIN/LOSS/DRAW DISTRIBUTION',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        if (wins > 0)
                          PieChartSectionData(
                            value: wins.toDouble(),
                            title: '$wins',
                            color: Colors.green,
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        if (losses > 0)
                          PieChartSectionData(
                            value: losses.toDouble(),
                            title: '$losses',
                            color: Colors.red,
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        if (draws > 0)
                          PieChartSectionData(
                            value: draws.toDouble(),
                            title: '$draws',
                            color: Colors.grey,
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (wins > 0) _buildLegendItem('Wins', Colors.green),
                      if (wins > 0) SizedBox(height: 8),
                      if (losses > 0) _buildLegendItem('Losses', Colors.red),
                      if (losses > 0) SizedBox(height: 8),
                      if (draws > 0) _buildLegendItem('Draws', Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildEloProgression(List<dynamic> eloHistory) {
    if (eloHistory.length < 2) {
      return Container();
    }

    final List<FlSpot> spots = [];
    for (int i = 0; i < eloHistory.length; i++) {
      final entry = eloHistory[i];
      spots.add(FlSpot(i.toDouble(), (entry['elo'] as int).toDouble()));
    }

    final maxElo = eloHistory.map((e) => e['elo'] as int).reduce((a, b) => a > b ? a : b).toDouble();
    final minElo = eloHistory.map((e) => e['elo'] as int).reduce((a, b) => a < b ? a : b).toDouble();
    
    // Calculate interval to ensure at least 150 ELO between marks
    final eloRange = maxElo - minElo;
    double interval = 150.0;
    
    // If the range is very large, increase the interval
    if (eloRange > 1000) {
      interval = 200.0;
    } else if (eloRange > 1500) {
      interval = 250.0;
    }

    return Container(
      height: 250,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            'ELO PROGRESSION',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: interval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: (eloHistory.length / 5).ceilToDouble(),
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toInt() + 1}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: interval,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                minX: 0,
                maxX: (eloHistory.length - 1).toDouble(),
                minY: (minElo - 50).floorToDouble(),
                maxY: (maxElo + 50).ceilToDouble(),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.deepPurple,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.deepPurple.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeStats(Map<String, dynamic> modeStats) {
    final modeDisplay = {
      "stronghold_116": "Stronghold (1.16)",
      "ruined_portal_116": "Ruined Portal (1.16)",
      "village_116": "Village (1.16)",
      "desert_temple_116": "Desert Temple (1.16)",
      "shipwreck_116": "Shipwreck (1.16)",
      "bastion_118": "Bastion (1.18+)",
      "warped_forest_118": "Warped Forest (1.18+)",
      "ruined_portal_118": "Ruined Portal (1.18+)",
      "buried_treasure_118": "Buried Treasure (1.18+)"
    };

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: modeDisplay.entries.where((entry) {
          final stats = modeStats[entry.key] as Map<String, dynamic>?;
          return stats != null && stats['total'] > 0;
        }).map((entry) {
          final mode = entry.key;
          final displayName = entry.value;
          final stats = modeStats[mode] as Map<String, dynamic>;
          final wins = stats['wins'];
          final losses = stats['losses'];
          final draws = stats['draws'];
          final avgTime = stats['avg_time'];

          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('W:', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                    Text('$wins', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(width: 12),
                    Text('L:', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                    Text('$losses', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(width: 12),
                    Text('D:', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                    Text('$draws', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                    if (avgTime != null) ...[
                      SizedBox(width: 12),
                      Text('| Avg:', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                      SizedBox(width: 4),
                      Text(avgTime, style: TextStyle(color: Colors.cyan, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FullStatsDialog extends StatefulWidget {
  final String userId;

  FullStatsDialog({required this.userId});

  @override
  _FullStatsDialogState createState() => _FullStatsDialogState();
}

class _FullStatsDialogState extends State<FullStatsDialog> {
  bool _isLoading = true;
  List<dynamic>? _matches;
  String _errorMessage = '';
  int _displayLimit = 50;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMatches() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final api = BedrockAPI();
      final data = await api.getMatches(widget.userId);

      setState(() {
        _matches = data['matches'] as List;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _loadMore() {
    setState(() {
      _displayLimit += 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF1D1E33),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.deepPurple, width: 2),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: 700),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.assessment, color: Colors.deepPurple),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Full Match History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.deepPurple))
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 48, color: Colors.red),
                              SizedBox(height: 16),
                              Text(_errorMessage, style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        )
                      : _matches == null || _matches!.isEmpty
                          ? Center(child: Text('No matches found'))
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: _matches!.length < _displayLimit 
                                        ? _matches!.length 
                                        : _displayLimit,
                                    itemBuilder: (context, index) {
                                      final match = _matches![index];
                                      return _buildMatchCard(match);
                                    },
                                  ),
                                ),
                                if (_matches!.length > _displayLimit)
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: ElevatedButton.icon(
                                      onPressed: _loadMore,
                                      icon: Icon(Icons.expand_more),
                                      label: Text('LOAD MORE (${_matches!.length - _displayLimit} remaining)'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    final result = match['result'] as String;
    final eloChange = match['elo_change'] as int;
    final newElo = match['new_elo'] as int;
    final timestamp = match['timestamp'] as int;
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    Color resultColor = result == 'win'
        ? Colors.green
        : result == 'loss'
            ? Colors.red
            : Colors.grey;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF0A0E21),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: resultColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: resultColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  result.toUpperCase(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ELO Change',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                  Text(
                    '${eloChange >= 0 ? '+' : ''}$eloChange',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: eloChange >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'New ELO',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                  Text(
                    '$newElo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BedrockAPI {
  static const String baseUrl = 'https://ranked.maehy.aninternettroll.xyz';

  Future<Map<String, dynamic>?> getPlayer(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/player/$userId'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load player: $e');
    }
  }

  Future<Map<String, dynamic>?> getPlayerStats(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/stats/$userId'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load player stats: $e');
    }
  }

  Future<Map<String, dynamic>> getMatches(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/matches/$userId'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception('Failed to load matches');
    } catch (e) {
      throw Exception('Failed to load matches: $e');
    }
  }

  Future<List<dynamic>> getLeaderboard({int limit = 10}) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/leaderboard?limit=$limit'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['leaderboard'] as List;
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load leaderboard: $e');
    }
  }

  Future<Map<String, dynamic>> getOverview() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/overview')).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return {};
    } catch (e) {
      throw Exception('Failed to load overview: $e');
    }
  }

  Future<Map<String, dynamic>> getModes() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/modes')).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return {};
    } catch (e) {
      throw Exception('Failed to load modes: $e');
    }
  }

  Future<Map<String, dynamic>> getSoloSeed(String version, String mode) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/solo'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'version': version, 'mode': mode}),
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception('Failed to get seed');
    } catch (e) {
      throw Exception('Failed to get seed: $e');
    }
  }
}