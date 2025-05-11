import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD3C4), // Soft Peach Background
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40), // Replace with your logo asset

            const SizedBox(width: 10),
            const Expanded( // Prevents overflow by allowing text to adjust
              child: Text(
                "About us",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis, // Prevents text from spilling out
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: const Color(0xFFFFB5A7), // Lighter peach
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Icon(Icons.keyboard, size: 50, color: Colors.deepOrange),
                  SizedBox(height: 8),
                  Text(
                    'Typing Tutor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // "Meet Our Team" Section
            _buildSectionTitle('Meet Our Team'),
            _buildInfoCard([
              _buildInfoRow('Developed by', 'Vruta Gambhava (230310701016)'),
              _buildInfoRow('Mentored by',
                  'Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science'),
              _buildInfoRow('Explored by',
                  'ASWDC, School Of Computer Science, Darshan University'),
              _buildInfoRow('Eulogized by',
                  'Darshan University, Rajkot, Gujarat - INDIA'),
            ]),

            // About ASWDC
            _buildSectionTitle('About ASWDC'),
            _buildInfoCard([
              Image.asset(
                'assets/image/Screenshot 2025-01-27 174954.png',
                width: 300,
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School of Computer Science.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ]),

            // Contact Us
            _buildSectionTitle('Contact Us'),
            _buildInfoCard([
              _buildContactRow(Icons.email, 'aswdc@darshan.ac.in'),
              _buildContactRow(Icons.phone, '+91-9727747317'),
              _buildContactRow(Icons.web, 'www.darshan.ac.in'),
            ]),

            // Action Buttons
            _buildSectionTitle('Stay Connected'),
            _buildInfoCard([
              _buildActionButton(Icons.share, 'Share App'),
              _buildActionButton(Icons.apps, 'More Apps'),
              _buildActionButton(Icons.star_rate, 'Rate Us'),
              _buildActionButton(Icons.thumb_up, 'Like us on Facebook'),
              _buildActionButton(Icons.update, 'Check for Update'),
            ]),

            // Footer
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      '© 2025 Darshan University\nAll Rights Reserved - Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Made with ', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Icon(Icons.favorite, size: 12, color: Colors.red),
                        Text(' in India', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFB5A7),
          border: Border.all(color: Colors.deepOrange, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
      ),
    );
  }

  // Info Card
  Widget _buildInfoCard(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.deepOrange, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  // Contact Row
  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  // Action Button
  Widget _buildActionButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // Info Row
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}
