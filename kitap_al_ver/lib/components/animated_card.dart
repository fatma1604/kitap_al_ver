import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';


class AnimatedPostCard extends StatefulWidget {
  final Posts post;
  final VoidCallback onDelete;

  const AnimatedPostCard(
      {super.key, required this.post, required this.onDelete});

  @override
  _AnimatedPostCardState createState() => _AnimatedPostCardState();
}

class _AnimatedPostCardState extends State<AnimatedPostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _offsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.1)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.red).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedPostCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post.postId != widget.post.postId) {
      _controller.reset();
      _controller.forward();
    }
  }

  void _handleDelete() async {
    await _controller.forward();
    widget.onDelete(); 
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: widget.post.imageUrls.isNotEmpty
                        ? Image.network(widget.post.imageUrls.first)
                        : const Icon(Icons.image, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.title,
                         style: AppTextTheme.caption(context)
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Category',
                          style: AppTextTheme.caption(context)
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: _handleDelete,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
