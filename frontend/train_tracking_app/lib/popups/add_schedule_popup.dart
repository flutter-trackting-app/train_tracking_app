import 'package:flutter/material.dart';
import 'package:train_tracking_app/services/schedule_service.dart';

class AddSchedulePopup extends StatefulWidget {
  const AddSchedulePopup({super.key});

  @override
  AddTrainPopupState createState() => AddTrainPopupState();
}

class AddTrainPopupState extends State<AddSchedulePopup> {
  final ScheduleService _trainService = ScheduleService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController departureTimeController = TextEditingController();
  final TextEditingController delayTimeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  bool isDelayed = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final trainData = {
        "name": nameController.text,
        "type": typeController.text,
        "origin": originController.text,
        "destination": destinationController.text,
        "departureTime": departureTimeController.text,
        "delayed": isDelayed.toString(),
        "delay_time": delayTimeController.text,
        "distance": distanceController.text,
      };

      final response = await _trainService.addTrain(trainData);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Train added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add train.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Schedule',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Train Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter name' : null,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter type' : null,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: originController,
                decoration: const InputDecoration(labelText: 'Origin'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter origin' : null,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: destinationController,
                decoration: const InputDecoration(labelText: 'Destination'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter destination' : null,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: departureTimeController,
                decoration: const InputDecoration(labelText: 'Departure Time'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter departure time' : null,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: distanceController,
                decoration: const InputDecoration(labelText: 'Distance'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter distance' : null,
              ),
              SizedBox(
                width: double.infinity,
                child: SwitchListTile(
                  title: const Text(
                    'Delayed',
                    style: TextStyle(fontSize: 18),
                  ),
                  value: isDelayed,
                  onChanged: (value) {
                    setState(() {
                      isDelayed = value;
                    });
                  },
                ),
              ),
              if (isDelayed)
                TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: delayTimeController,
                  decoration: const InputDecoration(labelText: 'Delay Time'),
                  validator: (value) => isDelayed && value!.isEmpty
                      ? 'Please enter delay time'
                      : null,
                ),
            ],
          ),
        ),
      ),
      actions: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
