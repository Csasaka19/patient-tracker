class MockDoctors {
  static final List<Map<String, dynamic>> doctors = [
    {
      'id': 1,
      'name': 'Dr. Jane Smith',
      'specialty': 'Cardiologist',
      'hospital': 'Central Hospital',
      'image': 'assets/doctors/doctor_1.png',
      'phone': '+1-234-567-8900',
      'email': 'jane.smith@example.com',
      'rating': 4.8,
    },
    {
      'id': 2,
      'name': 'Dr. Michael Johnson',
      'specialty': 'Neurologist',
      'hospital': 'City Medical Center',
      'image': 'assets/doctors/doctor_2.png',
      'phone': '+1-234-567-8901',
      'email': 'michael.johnson@example.com',
      'rating': 4.6,
    },
    {
      'id': 3,
      'name': 'Dr. Sarah Williams',
      'specialty': 'Pediatrician',
      'hospital': 'Children\'s Hospital',
      'image': 'assets/doctors/doctor_3.png',
      'phone': '+1-234-567-8902',
      'email': 'sarah.williams@example.com',
      'rating': 4.9,
    },
    {
      'id': 4,
      'name': 'Dr. Robert Brown',
      'specialty': 'Orthopedic Surgeon',
      'hospital': 'Joint & Bone Center',
      'image': 'assets/doctors/doctor_4.jpg',
      'phone': '+1-234-567-8903',
      'email': 'robert.brown@example.com',
      'rating': 4.7,
    },
  ];
}

class MockHospitals {
  static final List<Map<String, dynamic>> hospitals = [
    {
      'id': 1,
      'name': 'Central Hospital',
      'address': '123 Main Street, City',
      'image': 'assets/images/hospital.jpg',
      'phone': '+1-234-567-8910',
      'email': 'info@centralhospital.com',
      'rating': 4.5,
    },
    {
      'id': 2,
      'name': 'City Medical Center',
      'address': '456 Park Avenue, City',
      'image': 'assets/images/hospital.jpg',
      'phone': '+1-234-567-8911',
      'email': 'info@citymedical.com',
      'rating': 4.3,
    },
    {
      'id': 3,
      'name': 'Children\'s Hospital',
      'address': '789 Pine Road, City',
      'image': 'assets/images/hospital.jpg',
      'phone': '+1-234-567-8912',
      'email': 'info@childrenshospital.com',
      'rating': 4.8,
    },
  ];
}

class MockMedications {
  static final List<Map<String, dynamic>> medications = [
    {
      'id': 1,
      'name': 'Lisinopril',
      'dosage': '10mg',
      'frequency': 'Once daily',
      'start_date': '2023-01-15',
      'end_date': '2023-07-15',
      'instructions': 'Take with water in the morning',
    },
    {
      'id': 2,
      'name': 'Amoxicillin',
      'dosage': '500mg',
      'frequency': 'Three times daily',
      'start_date': '2023-03-10',
      'end_date': '2023-03-17',
      'instructions': 'Take with food',
    },
    {
      'id': 3,
      'name': 'Metformin',
      'dosage': '1000mg',
      'frequency': 'Twice daily',
      'start_date': '2023-02-01',
      'end_date': '2023-08-01',
      'instructions': 'Take with meals',
    },
  ];
}

class MockMedicalRecords {
  static final List<Map<String, dynamic>> records = [
    {
      'id': 1,
      'title': 'Annual Physical',
      'doctor': 'Dr. Jane Smith',
      'date': '2023-01-10',
      'notes':
          'Overall health is good. Blood pressure is normal. Recommended to maintain current diet and exercise routine.',
      'attachments': 2,
    },
    {
      'id': 2,
      'title': 'Blood Test Results',
      'doctor': 'Dr. Michael Johnson',
      'date': '2023-02-15',
      'notes':
          'All blood work within normal ranges. Cholesterol levels have improved since last test.',
      'attachments': 1,
    },
    {
      'id': 3,
      'title': 'X-Ray Results',
      'doctor': 'Dr. Robert Brown',
      'date': '2023-03-05',
      'notes':
          'No fractures or abnormalities detected in right ankle. Mild sprain should heal within 2-3 weeks.',
      'attachments': 3,
    },
  ];
}

class MockHospitalVisits {
  static final List<Map<String, dynamic>> visits = [
    {
      'id': 1,
      'hospital': 'Central Hospital',
      'reason': 'Annual Physical',
      'date': '2023-01-10',
      'doctor': 'Dr. Jane Smith',
      'notes': 'Routine checkup completed. No concerns.',
    },
    {
      'id': 2,
      'hospital': 'City Medical Center',
      'reason': 'Blood Tests',
      'date': '2023-02-15',
      'doctor': 'Dr. Michael Johnson',
      'notes': 'Blood samples taken for routine monitoring.',
    },
    {
      'id': 3,
      'hospital': 'Joint & Bone Center',
      'reason': 'Ankle Injury',
      'date': '2023-03-05',
      'doctor': 'Dr. Robert Brown',
      'notes': 'X-ray taken of right ankle. Diagnosed with mild sprain.',
    },
  ];
}

class MockUser {
  static final Map<String, dynamic> userData = {
    'id': 1,
    'username': 'johndoe',
    'email': 'john.doe@example.com',
    'firstName': 'John',
    'lastName': 'Doe',
    'dob': '1985-06-15',
    'gender': 'Male',
    'phone': '+1-234-567-8920',
    'address': '123 Main Street, City',
    'bloodType': 'O+',
    'allergies': ['Penicillin', 'Peanuts'],
    'emergencyContact': {
      'name': 'Jane Doe',
      'relationship': 'Spouse',
      'phone': '+1-234-567-8921',
    }
  };
}
