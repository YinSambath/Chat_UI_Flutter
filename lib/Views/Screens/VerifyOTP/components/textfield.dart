import 'package:mcircle_project_ui/chat_app.dart';

Widget buildTextField(
        String labelText,
        TextEditingController textEditingController,
        IconData prefixIcons,
        BuildContext context,
        String? Function(String?)? validator) =>
    Padding(
      padding: const EdgeInsets.all(10.00),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
          obscureText: labelText == "OTP" ? true : false,
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(11),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(11),
            ),
            prefixIcon: Icon(prefixIcons, color: kPrimaryColor),
            hintText: labelText,
            hintStyle: const TextStyle(color: kPrimaryColor),

            // fillColor: Color.fromARGB(255, 231, 236, 238),
          ),
          validator: validator,
        ),
      ),
    );
