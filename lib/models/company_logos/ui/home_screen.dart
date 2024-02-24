import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CompanyNameTextField(),
                BlocBuilder<CompanyLogoCubit, CompanyLogoState>(
                  builder: (context, state) {
                    if (state is CompanyLogoSuccessState) {
                      return Text("Success : ${state.state?.image}");
                    } else if (state is CompanyLogoFailedState) {
                      return const Text("Failed: Something went wrong, check out the spelling and your internet connection");
                    } else if (state is CompanyLogoLoadingState) {
                      return const Text("Waiting ...");
                    } else {
                        return const Text("Please type a company name, make sure you spell it correctly");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyNameTextField extends StatefulWidget {
  const CompanyNameTextField({super.key});

  @override
  State<CompanyNameTextField> createState() => _CompanyNameTextFieldState();
}

class _CompanyNameTextFieldState extends State<CompanyNameTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
          ),
        ),
        ElevatedButton(
          onPressed: (() {
            context.read<CompanyLogoCubit>().get(_controller.text);
          }),
          child: const Text("Search"),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
