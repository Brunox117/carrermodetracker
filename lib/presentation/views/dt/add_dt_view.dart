import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/presentation/widgets/forms/add_image_widget.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';

class AddDtView extends StatelessWidget {
  final String? managerId;
  const AddDtView({super.key, this.managerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((managerId == null) ? 'Agregar DT' : 'Editar DT'),
      ),
      body: _ManagerForm(
        managerId: managerId,
      ),
    );
  }
}

class _ManagerForm extends ConsumerStatefulWidget {
  final String? managerId;

  const _ManagerForm({required this.managerId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ManagerFormState();
}

class __ManagerFormState extends ConsumerState<_ManagerForm> {
  void submitManager(Manager manager) async {
    ref.read(managersProvider.notifier).addManager(manager, _selectedImageFile);
  }

  void updateManager(Manager manager) async {
    ref.read(managersProvider.notifier).updateManager(
        int.parse(widget.managerId!), manager, _selectedImageFile);
  }

  final _formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();

  String name = '';
  String imageURL = '';
  XFile? _selectedImageFile;

  void getOldManagerInfo() async {
    Manager? oldManager =
        await ref.read(managersProvider.notifier).getManager();
    if (oldManager != null) {
      setState(() {
        name = oldManager.name;
        imageURL = oldManager.imageUrl;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.managerId != null) {
      getOldManagerInfo();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final manager = Manager(name: name, imageUrl: imageURL);
      _formKey.currentState!.reset();
      if (widget.managerId == null) {
        submitManager(manager);
        context.pop();
      } else {
        updateManager(manager);
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomFormField(
              isTopField: true,
              isBottomField: true,
              hint: "Ingresa el nombre del entrenador",
              key: ValueKey(name),
              initialValue: name,
              onChanged: (value) => name = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            AddImageWidget(
              key: (imageURL.isNotEmpty) ? ValueKey(imageURL) : null,
              hintText: 'Agrega una imagen o toma una foto',
              documentsFolder: 'managers',
              onImageUploaded: (selectedImage) {
                setState(() => _selectedImageFile = selectedImage);
              },
              imageURLFromFather: imageURL,
            ),
            const SizedBox(height: 20),
            SaveFormButton(
              submitForm: _submitForm,
              onSaveTextAlert: (widget.managerId != null)
                  ? "DT actualizado!"
                  : "DT creado exitosamente!",
            ),
          ],
        ),
      ),
    );
  }
}
