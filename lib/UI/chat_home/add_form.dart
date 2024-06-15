import 'package:weather/services/database.dart';
import 'package:weather/shared/my_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/mess.dart';
import '../../models/my_user.dart';
import '../../provider/loading_provider.dart';
import '../../widgets/loading.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> healths = [0, 1, 2, 3, 4, 5];
  //controller
  int? _health;
  late ValueNotifier<double> _outlayNotifier = ValueNotifier<double>(100);
  final _contentController = TextEditingController();
  File? _image;
  @override
  void dispose() {
    _outlayNotifier.dispose();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    _outlayNotifier = ValueNotifier<double>(50);
  }
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final user = Provider.of<MyUser?>(context);
    return Consumer<LoadingProvider>(
      builder:(BuildContext context, loadingProvider, _) =>loadingProvider.isLoading?Loading():
        Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                  'Send your message to friend',
                  style: TextStyle(fontSize: 19.0)
              ),
              SizedBox(height: 20,),
              buildTextFormField(
                controller: _contentController,
                validator: (val) =>
                val!.isEmpty
                    ? 'Please enter message'
                    : null,
                obscureText: false,
                labelText: '',
                hintText: 'How are you today?',
                icon: Icon(Icons.message),
              ),
              SizedBox(height: 20,),
              ValueListenableBuilder<double>(
                valueListenable: _outlayNotifier,
                builder: (context, value, child) =>
                    Column(
                        children: [
                          Slider(
                            value: value,
                            activeColor: Colors.pink[200],
                            inactiveColor: Colors.orange[100],
                            min: 0.00,
                            max: 100.00,
                            divisions: 10000,
                            onChanged: (val) => _outlayNotifier.value = val,
                          ),
                          Text('I spent ${_outlayNotifier.value
                              .toStringAsFixed(2)} dollars ')
                        ]
                    ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 150,
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                      hintText: 'Health',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10)
                  ),
                  value: _health ?? 0,
                  items: healths.map((healths) {
                    return DropdownMenuItem(
                      value: healths,
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: '$healths health ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              WidgetSpan(child: Icon(
                                Icons.favorite, color: Colors.red[300],))
                            ]
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    _health = val;
                  },
                  validator: (val) {
                    if (val == null) return 'Please choose your health';
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    String? imageUrl;
                    loadingProvider.setLoading(true);
                    if (_image != null) {
                      imageUrl = await DatabaseService(uid: user!.uid).uploadImage(_image!);
                    }
                    try{
                      await DatabaseService(uid: user!.uid).addUserData(
                        _contentController.text,
                        _health??0,
                        _outlayNotifier.value.toString(),
                        imageUrl,
                      );
                      final snackBar = SnackBar(content: Text('Data posted successfully!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } catch(e){
                      final snackBar = SnackBar(content: Text('An error occurred: $e'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } finally{
                      loadingProvider.setLoading(false);
                    }
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Send', style: TextStyle(color: Colors.orange[50]),),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.pink[200],
                ),
              ),
            ],
          )
        ),
      );
  }
}
