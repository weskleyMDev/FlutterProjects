import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SvgPicture.asset('assets/images/person.svg', height: 150.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: Weskley'),
                    SizedBox(
                      height: 14.0,
                      child: VerticalDivider(
                        thickness: 2.0,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Text('Age: 25'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
