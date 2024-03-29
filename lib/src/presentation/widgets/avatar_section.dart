import 'package:be_chill/src/domain/entities/user_model.dart';
import 'package:be_chill/src/presentation/shared/bechill_painter.dart';
import 'package:flutter/material.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(user: user),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextUsername(username: user.username),
              TextDescription(bio: user.bio),
            ],
          ),
        ),
      ],
    );
  }
}

class TextUsername extends StatelessWidget {
  const TextUsername({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Text(
      bio,
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 12,
        fontFamily: "monospace",
        fontFamilyFallback: <String>["Courier"],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.user,
  });

  static const border = 2.0;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxRadius = constraints.maxHeight / 2.0;

        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: maxRadius,
              backgroundColor: Colors.black,
              child: Opacity(
                opacity: 0.9,
                child: CircleAvatar(
                  radius: maxRadius - border,
                  backgroundColor: Colors.amber.shade200,
                  foregroundImage: user.profilePicUrl != null
                      ? AssetImage('assets/images/fake_1.png')
                      // ? NetworkImage(user.profilePicUrl!)
                      : null,
                ),
              ),
            ),
            CustomPaint(
              size: Size.fromRadius(maxRadius - 20.0),
              painter: BeChillPainter(rating: user.averageRate),
            ),
          ],
        );
      },
    );
  }
}
