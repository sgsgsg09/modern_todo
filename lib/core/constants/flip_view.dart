import 'dart:math';
import 'package:flutter/material.dart';

class FlipView extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlipView({
    Key? key,
    required this.front,
    required this.back,
  }) : super(key: key);

  @override
  FlipViewState createState() => FlipViewState();
}

class FlipViewState extends State<FlipView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = true;

  // 드래그에 따른 민감도 (값이 작을수록 적은 드래그로 변화)
  static const double dragSensitivity = 300.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  // 외부에서 호출 가능한 플립 메서드 (플립 버튼 등에서 활용 가능)
  void flip() {
    if (_isFrontVisible) {
      _controller.forward();
      _isFrontVisible = false;
    } else {
      _controller.reverse();
      _isFrontVisible = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 드래그 중: 드래그한 양에 따라 애니메이션 진행 정도 업데이트
      onHorizontalDragUpdate: (details) {
        // details.primaryDelta: 드래그한 x축 변화량 (양수면 오른쪽, 음수면 왼쪽)
        _controller.value += details.primaryDelta! / dragSensitivity;
      },
      // 드래그 종료 시: controller.value가 0.5 이상이면 플립 완료, 아니면 원래 상태로 복귀
      onHorizontalDragEnd: (details) {
        // 드래그 속도가 일정 임계치 이상이면 속도에 따라 방향 결정
        if (details.primaryVelocity != null) {
          if (details.primaryVelocity! < -300) {
            // 왼쪽으로 빠르게 드래그한 경우
            _controller.forward();
            _isFrontVisible = false;
            return;
          } else if (details.primaryVelocity! > 300) {
            // 오른쪽으로 빠르게 드래그한 경우
            _controller.reverse();
            _isFrontVisible = true;
            return;
          }
        }
        // 속도가 미약한 경우 진행 정도(controller.value)에 따라 결정
        if (_controller.value > 0.5) {
          _controller.forward();
          _isFrontVisible = false;
        } else {
          _controller.reverse();
          _isFrontVisible = true;
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value;
          final isFront = angle < (pi / 2);
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // 원근감 효과 부여
              ..rotateY(angle),
            child: isFront
                ? widget.front
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: widget.back,
                  ),
          );
        },
      ),
    );
  }
}
