import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// B = generics
// S = state
class ButtonWithLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  /** Attributes **/
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;
  final VoidCallback onPressed;
  final String label;

  /** Constructor **/
  const ButtonWithLoader({
    super.key,
    required this.selector,
    required this.bloc,
    required this.onPressed,
    required this.label,
  });

  /** Methods **/
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: BlocSelector<B, S, bool>(
        bloc: bloc,
        selector: selector,
        builder: (context, showLoading) {
          if (!showLoading) {
            return Text(label);
          }

          // Save Button and loading progress
          return Stack(
            alignment: Alignment.center,
            children: [
              Text(label),
              const Align(
                alignment: Alignment.centerRight,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
