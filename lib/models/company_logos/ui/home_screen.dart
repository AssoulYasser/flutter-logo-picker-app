import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_picker/core/colors.dart';
import 'package:logo_picker/models/company_logos/ui/company_logo_state.dart';

import '../../../dependency_injection.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.get<CompanyLogoCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Logo Picker"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
        ),
        body: Container(
          color: backgroundDarkColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchWidget(),
                  BlocBuilder<CompanyLogoCubit, CompanyLogoState>(
                    builder: (context, state) {
                      if (state is CompanyLogoSuccessState) {
                        return Image.network(state.state!.image);
                      } else if (state is CompanyLogoFailedState) {
                        return const Text(
                            "Failed: Something went wrong, check out the spelling and your internet connection");
                      } else if (state is CompanyLogoLoadingState) {
                        return const Text("Waiting ...");
                      } else {
                        return Container(
                          color: Colors.purple,
                          child: const Row(
                            children: [
                              Text(
                                "make sure you spell it correctly",
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String query = "";

    void onSearch() {
      if (formKey.currentState != null && formKey.currentState!.validate()) {
        formKey.currentState!.save();
        context.read<CompanyLogoCubit>().get(query);
      }
    }

    void onSavedQuery(String? value) {
      query = value ?? "";
    }

    return IntrinsicHeight(
      child: Form(
        key: formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //   TODO: Chnage it to custom
            CostumeTextField(
              onSaved: onSavedQuery,
              hintText: "Company Name",
            ),
            const WidthGap(gap: 20.0),
            Button(
              textButton: "Search",
              onPressed: onSearch,
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;

  const Button({required this.onPressed, required this.textButton, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (onPressed),
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(primaryColor),
        elevation: const MaterialStatePropertyAll(0),
        foregroundColor: const MaterialStatePropertyAll(whiteColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      child: Text(textButton),
    );
  }
}

class CostumeTextField extends StatefulWidget {
  final String hintText;
  final void Function(String? value) onSaved;

  const CostumeTextField(
      {required this.hintText, super.key, required this.onSaved});

  @override
  State<CostumeTextField> createState() => _CostumeTextFieldState();
}

class _CostumeTextFieldState extends State<CostumeTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        _isFocus = !_isFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  bool _isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        focusNode: focusNode,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle:
              TextStyle(color: _isFocus ? primaryColor : backgroundBrightColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundBrightColor),
          ),
        ),
      ),
    );
  }
}

class WidthGap extends StatelessWidget {
  final double gap;

  const WidthGap({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap,
    );
  }
}

class HeightGap extends StatelessWidget {
  final double gap;

  const HeightGap({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gap,
    );
  }
}
