import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String leftText;
  final String rightText;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;

  const StandardAppBar({
    super.key,
    this.title,
    this.leftText = "이전",
    this.rightText = "다음",
    this.onBackPressed,
    this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(250, 100, 100, 255),
      elevation: 1.0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (onBackPressed != null)
            GestureDetector(
              onTap: onBackPressed,
              child: Row(
                children: [
                  const Icon(
                    Icons.chevron_left,
                    size: 30,
                  ),
                  Text(
                    leftText,
                    style: const TextStyle(
                      fontFamily: 'NanumGothicFamily',
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(width: 60),

          if (title != null)
            Expanded(
              child: Center(
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontFamily: 'NanumGothicFamily',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else
            const Spacer(),

          if (onNextPressed != null)
            GestureDetector(
              onTap: onNextPressed,
              child: Row(
                children: [
                  Text(
                    rightText,
                    style: const TextStyle(
                      fontFamily: 'NanumGothicFamily',
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          else
            const SizedBox(width: 60),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}