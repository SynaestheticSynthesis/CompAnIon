import 'package:flutter/material.dart';
// Προσθήκη για γεωεντοπισμό (mock ή πραγματικό)
import 'package:geolocator/geolocator.dart';

class PalliativeCareScreen extends StatefulWidget {
  const PalliativeCareScreen({super.key});

  @override
  State<PalliativeCareScreen> createState() => _PalliativeCareScreenState();
}

class _PalliativeCareScreenState extends State<PalliativeCareScreen> {
  String? _userRegion;
  List<Map<String, String>> _units = [
    {
      'name': 'Μονάδα Ανακουφιστικής Φροντίδας "Γαλιλαία"',
      'region': 'Αττική',
      'address': 'Σπάτα Αττικής, τηλ: 210-6635955',
      'url': 'https://galilee.gr',
    },
    {
      'name': 'Μονάδα "Jenny Karezi"',
      'region': 'Αθήνα',
      'address': 'Αθήνα, τηλ: 210-7462421',
      'url': 'https://www.palliativecare.gr',
    },
    {
      'name': 'Μονάδα Ανακουφιστικής Φροντίδας Θεσσαλονίκης',
      'region': 'Θεσσαλονίκη',
      'address': 'Θεσσαλονίκη, τηλ: 2310-123456',
      'url': '',
    },
    // ...μπορείτε να προσθέσετε και άλλες μονάδες...
  ];

  @override
  void initState() {
    super.initState();
    _detectRegion();
  }

  Future<void> _detectRegion() async {
    // Mock γεωεντοπισμός: μπορείτε να χρησιμοποιήσετε πραγματικό geolocation αν θέλετε
    // Εδώ για παράδειγμα, αν ο χρήστης είναι στην Αττική, εμφανίζουμε μόνο τις σχετικές μονάδες
    // Για demo, θα βάλουμε "Αττική"
    setState(() {
      _userRegion = 'Αττική'; // ή πάρτε το από geolocation API
    });

    // Για πραγματικό geolocation:
    // Position pos = await Geolocator.getCurrentPosition();
    // Χρησιμοποιήστε reverse geocoding για να βρείτε περιοχή/νομό
  }

  @override
  Widget build(BuildContext context) {
    final filteredUnits = _userRegion == null
        ? _units
        : _units.where((u) => u['region'] == _userRegion).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ανακουφιστική Φροντίδα'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Τι είναι η Ανακουφιστική Φροντίδα;',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            'Η ανακουφιστική φροντίδα προσφέρει στήριξη σε άτομα με σοβαρή ασθένεια και στις οικογένειές τους. Εστιάζει στην ποιότητα ζωής, την ανακούφιση του πόνου και τη συναισθηματική υποστήριξη.',
          ),
          const SizedBox(height: 18),
          Text(
            _userRegion != null
                ? 'Μονάδες στην περιοχή σας (${_userRegion!}):'
                : 'Μονάδες & Ιατρεία Ανακουφιστικής Φροντίδας:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...filteredUnits.map((unit) => Card(
                child: ListTile(
                  title: Text(unit['name'] ?? ''),
                  subtitle: Text(unit['address'] ?? ''),
                  trailing: unit['url'] != null && unit['url']!.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.link),
                          onPressed: () {
                            // TODO: url_launcher για άνοιγμα συνδέσμου
                          },
                        )
                      : null,
                ),
              )),
          if (filteredUnits.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Δεν βρέθηκαν μονάδες στην περιοχή σας.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          const SizedBox(height: 18),
          const Text(
            'Προτεινόμενοι Πόροι & Υποστήριξη:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Ελληνική Εταιρεία Ανακουφιστικής Φροντίδας'),
            subtitle: const Text('https://www.palliativecare.gr'),
            onTap: () {
              // TODO: Add url_launcher integration
            },
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Μονάδα "Γαλιλαία"'),
            subtitle: const Text('https://galilee.gr'),
            onTap: () {
              // TODO: Add url_launcher integration
            },
          ),
          const SizedBox(height: 18),
          const Text(
            'Συναισθηματική Υποστήριξη:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '• Μίλησε με τους δικούς σου ανθρώπους για όσα νιώθεις.\n'
            '• Ζήτησε βοήθεια από επαγγελματίες αν το χρειάζεσαι.\n'
            '• Θυμήσου: Δεν είσαι μόνος/η σε αυτή τη διαδρομή.',
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.yellow[100],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Αποποίηση ευθύνης: Οι πληροφορίες παρέχονται μόνο για ενημερωτικούς σκοπούς και δεν υποκαθιστούν την ιατρική συμβουλή. Για κάθε απόφαση υγείας, συμβουλευτείτε τον γιατρό σας.',
                style: const TextStyle(fontSize: 13, color: Colors.brown),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
