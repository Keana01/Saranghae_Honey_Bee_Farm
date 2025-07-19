import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(const SaranghaeBeeFarmApp());

class SaranghaeBeeFarmApp extends StatelessWidget {
  const SaranghaeBeeFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saranghae Honey Bee Farm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFA47148),
        scaffoldBackgroundColor: const Color(0xFFFFF3B0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFA47148),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HiveStatusPage(),
    );
  }
}

class HiveStatusPage extends StatefulWidget {
  const HiveStatusPage({super.key});

  @override
  State<HiveStatusPage> createState() => _HiveStatusPageState();
}

class _HiveStatusPageState extends State<HiveStatusPage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool isFanOn = false;
  TimeOfDay? reminderTime;

  List<Map<String, String>> notifications = [
    {
      "title": "Low Temperature Warning!",
      "subtitle": "Temperature has dropped below 30°C",
      "time": "39m"
    },
    {
      "title": "High Humidity Warning!",
      "subtitle": "Humidity level is 80%",
      "time": "3h"
    },
    {
      "title": "Low Humidity Warning!",
      "subtitle": "Humidity has fallen below 45%",
      "time": "2d"
    },
    {
      "title": "Honey is ready to harvest!",
      "subtitle": "Beehive has reached 35.0 kg",
      "time": "2w"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3B0),
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.bug_report, color: Colors.white),
              SizedBox(width: 8),
              Text(
              'Saranghae Honey Bee Farm',
              style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'TitleFont',
              ),
            ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildHomeTab(),
          buildNotificationTab(),
          buildHistoryTab(),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFA47148),
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
  Tab(
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.home, color: Colors.white),
        SizedBox(height: 2),
        Text(
          "Home",
          style: TextStyle(
            fontFamily: 'TitleFont', // 👈 DIFFERENT FONT
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
  Tab(
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.notifications, color: Colors.white),
        SizedBox(height: 2),
        Text(
          "Notif",
          style: TextStyle(
            fontFamily: 'Lexend', 
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
  Tab(
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.history, color: Colors.white),
        SizedBox(height: 2),
        Text(
          "History",
          style: TextStyle(
            fontFamily: 'Lexend', 
            fontSize: 12,
            color: Colors.white,
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

  Widget buildHomeTab() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min, // make row take only needed width
              children: [
                const Text(
                  "Hive Status",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E342E),
                  ),
                ),
                const SizedBox(width: 4), // very small space to keep them close
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF90BE6D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "Normal",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                gauge("Temperature", "34.8", "°C"),
                gauge("Humidity", "60", "%"),
                gauge("Weight", "33.5", "kg"),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  "Cooling Fan:",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6D4C41),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFanOn = !isFanOn;
                    });
                  },
                  child: Icon(
                    isFanOn ? Icons.toggle_on : Icons.toggle_off,
                    color: isFanOn ? const Color(0xFF90BE6D) : Colors.grey,
                    size: 44,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reminder:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6D4C41),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA47148),
                  ),
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: reminderTime ?? TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        reminderTime = picked;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Reminder set at ${picked.format(context)}")),
                      );
                    }
                  },
                  child: const Text(
                    "Set Reminder",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            if (reminderTime != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Reminder set at: ${reminderTime!.format(context)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4E342E),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            buildGraph("Temperature"),
            buildGraph("Humidity"),
            buildGraph("Weight"),
          ],
        ),
      ),
    );
  }

  Widget gauge(String label, String value, String unit) {
    double val = double.tryParse(value) ?? 0;
    double max = label == "Humidity" ? 100 : 50;
    double progress = val / max;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF90BE6D)),
                strokeWidth: 8,
              ),
            ),
            Column(
              children: [
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(unit, style: const TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget buildGraph(String label) {
  List<FlSpot> generateData(String type) {
    switch (type) {
      case "Temperature":
        // Updated range 34 to 36 (closer range)
        return [
          FlSpot(0, 34.2),
          FlSpot(1, 34.5),
          FlSpot(2, 34.8),
          FlSpot(3, 35.1),
          FlSpot(4, 35.4),
          FlSpot(5, 35.7),
          FlSpot(6, 36.0),
        ];
      case "Humidity":
        // Only one graph line now with values from 50 to 70
        return [
          FlSpot(0, 50),
          FlSpot(1, 55),
          FlSpot(2, 60),
          FlSpot(3, 65),
          FlSpot(4, 70),
          FlSpot(5, 68),
          FlSpot(6, 66),
        ];
      case "Weight":
        // No change here
        return [
          FlSpot(0, 30),
          FlSpot(1, 31),
          FlSpot(2, 32),
          FlSpot(3, 33),
          FlSpot(4, 34),
          FlSpot(5, 35),
          FlSpot(6, 36),
        ];
      default:
        return [FlSpot(0, 0)];
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF4E342E),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                isCurved: label != "Weight",
                color: Colors.black,
                barWidth: 3,
                dotData: FlDotData(show: false),
                spots: generateData(label),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}


  Widget buildNotificationTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notifications",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Notification deleted")),
                      );
                    },
                    child: notificationCard(
                      notif["title"]!,
                      notif["subtitle"]!,
                      notif["time"]!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationCard(String title, String subtitle, String timeAgo) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailPage(title: title, subtitle: subtitle),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF4E342E),
            ),
          ),
          subtitle: Text(subtitle),
          trailing: Text(
            timeAgo,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6D4C41),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHistoryTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "History Logs",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  historyItem("Temperature stable at 34.8°C", "Today 8:00 AM"),
                  historyItem("Humidity increased to 65%", "Yesterday 5:00 PM"),
                  historyItem("Weight reached 32.5kg", "2 days ago"),
                  historyItem("Cooling fan activated", "3 days ago"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyItem(String event, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.brightness_low, color: Color(0xFFA47148)),
        title: Text(
          event,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          time,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
