import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../config/router/app_router.gr.dart';
import '../../../../../config/themes/app_color.dart';
import '../../../../../constants/typograph.dart';
import '../../../../../utils/helpers/validator_form.dart';
import '../../../../../utils/widgets/button/custom_fill_button.dart';
import '../../../../../utils/widgets/textfield/main_textfield.dart';
import '../cubits/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.msg)),
          );
        } else if (state is LoginSuccess) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                Assets.images.app.logo.path,
                width: 200,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome Back!',
              style: Typograph.subtitle22m.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Log in with username & password available on fakestoreapi',
              style: Typograph.label14m,
            ),
            const SizedBox(height: 20),
            MainTextfield(
              controller: usernameController,
              labelText: 'Username address',
              validator: ValidatorForm.validatedRequired,
              prefixIcon:
                  const Icon(Icons.person, color: AppColor.greyTextColor),
            ),
            const SizedBox(height: 16),
            Text('Password', style: Typograph.subtitle14m),
            const SizedBox(height: 6),
            MainTextfield(
              controller: passwordController,
              prefixIcon: const Icon(Icons.lock, color: AppColor.greyTextColor),
              labelText: 'Masukkan Password',
              validator: ValidatorForm.password,
              obscureText: true,
              minLines: 1,
            ),
            const SizedBox(height: 50),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomFillButton(
                  text: 'Log in',
                  isLoading: state is LoginLoading,
                  onPressed: onTapLogin,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onTapLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final username = usernameController.text;
      final password = passwordController.text;
      context.read<LoginCubit>().login(username, password);
    }
  }
}
