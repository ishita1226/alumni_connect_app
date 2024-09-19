import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF666B73),
                Color(0xFF232426),
              ],
            ),
          ),
          child: ListView(
            children: [
              const Divider(
                thickness: 2,
              ),
              _buildStorySection(constraints),
              const SizedBox(height: 8),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 8),
              _buildEventsCarousel(constraints),
              const SizedBox(height: 8),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 8),
              _buildJobOpportunities(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEventsCarousel(BoxConstraints constraints) {
    final List<Map<String, String>> events = [
      {
        'title': 'AI Workshop',
        'date': '2024-09-20',
        'time': '14:00',
        'speaker': 'Dr. Jane Smith',
        'mode': 'online',
        'link': 'https://meet.google.com/htf-hogo-tsy?authuser=3',
        'image':
            'https://media.istockphoto.com/id/1519542517/photo/convocation-ceremony-rear-view-asian-graduation-university-students-together-with-dean.jpg?s=1024x1024&w=is&k=20&c=SCjB3VsvbrJ3fiQyiByUirflXJuDbBLZr28G2HyuV3k=',
      },
      {
        'title': 'Career Fair',
        'date': '2024-09-25',
        'time': '10:00',
        'speaker': 'Various Industry Experts',
        'mode': 'offline',
        'location': 'AB2 - G6 (Smart Class)',
        'image':
            'https://media.istockphoto.com/id/851021154/photo/3d-illustration-of-a-sign-saying-training-with-a-graduation-cap-on.jpg?s=1024x1024&w=is&k=20&c=EKsdZ0yC5aAsl6tOSaCyyDceN-krOfRyhBHJbq1IXzg=',
      },
      {
        'title': 'Alumni Meetup',
        'date': '2024-10-01',
        'time': '18:00',
        'speaker': 'Alumni Association',
        'mode': 'offline',
        'location': 'University Auditorium',
        'image':
            'https://images.unsplash.com/photo-1462536943532-57a629f6cc60?q=80&w=1473&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ).animate().fadeIn(duration: 1000.ms).slideX(),
        const SizedBox(height: 8),
        CarouselSlider(
          options: CarouselOptions(
            height: constraints.maxWidth <= 400
                ? constraints.maxHeight * 0.6
                : constraints.maxWidth <= 650
                    ? constraints.maxWidth * .55
                    : constraints.maxWidth <= 900
                        ? constraints.maxWidth * .45
                        : constraints.maxWidth * .3,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.decelerate,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: events.map((event) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    if (event['mode'] == 'online') {
                      _launchURL(event['link']!);
                    } else {
                      _showLocationDialog(context, event['location']!);
                    }
                  },
                  child: Container(
                    width: constraints.maxWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade400,
                          Colors.purple.shade500,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              event['image']!,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event['title']!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ).animate().fadeIn(delay: 500.ms).slideY(),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${event['date']} at ${event['time']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ).animate().fadeIn(delay: 800.ms).slideY(),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Speaker: ${event['speaker']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ).animate().fadeIn(delay: 1000.ms).slideY(),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        event['mode'] == 'online'
                                            ? Icons.video_call
                                            : Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        event['mode']!.capitalize(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ).animate().fadeIn(delay: 1200.ms).slideY(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .scale(duration: 300.ms, curve: Curves.fastOutSlowIn)
                      .fade(duration: 500.ms),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStorySection(BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Success Stories',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ).animate().fadeIn(duration: 1000.ms).slideX(),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: constraints.maxHeight * .1,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJobOpportunities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Job Opportunities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: -0.2, end: 0, duration: 500.ms),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Software Engineer'),
              subtitle: const Text('TechCorp Inc.'),
              trailing: ElevatedButton(
                child: const Text('Apply'),
                onPressed: () {},
              ),
            )
                .animate(delay: (200 * index).ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.2, end: 0, duration: 500.ms);
          },
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showLocationDialog(BuildContext context, String location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event Location'),
          content: Text(location),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
