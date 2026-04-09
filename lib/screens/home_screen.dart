import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import 'category_levels_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _homeCategories();

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFFF9F4EF)),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(26, 16, 26, 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Reveal(
                  controller: _controller,
                  begin: 0,
                  end: 0.2,
                  offset: const Offset(0, -16),
                  child: const _Header(),
                ),
                const SizedBox(height: 42),
                _Reveal(
                  controller: _controller,
                  begin: 0.1,
                  end: 0.36,
                  offset: const Offset(0, 18),
                  child: const _GreetingBlock(),
                ),
                const SizedBox(height: 34),
                _Reveal(
                  controller: _controller,
                  begin: 0.2,
                  end: 0.5,
                  offset: const Offset(0, 22),
                  child: const _DailyQuestCard(),
                ),
                const SizedBox(height: 48),
                _Reveal(
                  controller: _controller,
                  begin: 0.34,
                  end: 0.62,
                  offset: const Offset(0, 18),
                  child: const _SectionHeader(),
                ),
                const SizedBox(height: 28),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 20.0;
                    final width = (constraints.maxWidth - spacing) / 2;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: 20,
                      children: List.generate(categories.length, (index) {
                        final item = categories[index];

                        return SizedBox(
                          width: width,
                          child: _Reveal(
                            controller: _controller,
                            begin: 0.45 + (index * 0.055),
                            end: 0.78 + (index * 0.035),
                            offset: Offset(0, 28 + (index * 3)),
                            child: _KnowledgeTile(
                              item: item,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => CategoryLevelsScreen(
                                      category: item.category,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 44),
                _Reveal(
                  controller: _controller,
                  begin: 0.72,
                  end: 1,
                  offset: const Offset(0, 24),
                  child: const _StatsRow(),
                ),
              ],
            ),
          ),
          const Positioned(
            right: 32,
            bottom: 14,
            child: _FloatingAction(),
          ),
        ],
      ),
    );
  }

  List<_KnowledgeItem> _homeCategories() {
    final history = _categoryById('history');
    final quran = _categoryById('quran');
    final culture = _categoryById('culture');
    final mixed = _categoryById('mixed');
    final geography = _categoryById('geography');

    return [
      _KnowledgeItem(
        label: 'Seerah',
        category: history.copyAs(
          id: 'seerah',
          labelKey: 'history',
          icon: Icons.auto_stories_rounded,
          color: const Color(0xFF7EF0C5),
        ),
        icon: Icons.auto_stories_rounded,
        iconColor: const Color(0xFF075D4E),
        color: const Color(0xFF7EF0C5),
        pattern: _TilePattern.dots,
      ),
      _KnowledgeItem(
        label: 'History',
        category: history,
        icon: Icons.mosque_rounded,
        iconColor: const Color(0xFF4B229F),
        color: const Color(0xFFA889FF),
        pattern: _TilePattern.stripes,
      ),
      _KnowledgeItem(
        label: 'Quran',
        category: quran,
        icon: Icons.menu_book_rounded,
        iconColor: const Color(0xFF761D15),
        color: const Color(0xFFFF7A67),
        pattern: _TilePattern.none,
      ),
      _KnowledgeItem(
        label: 'Ethics',
        category: culture.copyAs(
          id: 'ethics',
          labelKey: 'ethics',
          icon: Icons.family_restroom_rounded,
          color: const Color(0xFFE4E2DC),
        ),
        icon: Icons.family_restroom_rounded,
        iconColor: const Color(0xFF2E2D2A),
        color: const Color(0xFFE4E2DC),
        pattern: _TilePattern.none,
      ),
      _KnowledgeItem(
        label: 'Hadith',
        category: mixed.copyAs(
          id: 'hadith',
          labelKey: 'hadith',
          icon: Icons.psychology_rounded,
          color: const Color(0xFFA98DF4),
        ),
        icon: Icons.psychology_rounded,
        iconColor: const Color(0xFF472394),
        color: const Color(0xFFA98DF4),
        pattern: _TilePattern.none,
      ),
      _KnowledgeItem(
        label: 'Explore',
        category: geography.copyAs(
          id: 'explore',
          labelKey: 'explore',
          icon: Icons.travel_explore_rounded,
          color: const Color(0xFF73DEB5),
        ),
        icon: Icons.travel_explore_rounded,
        iconColor: const Color(0xFF075D4E),
        color: const Color(0xFF73DEB5),
        pattern: _TilePattern.none,
      ),
    ];
  }

  QuizCategory _categoryById(String id) {
    return quizCatalog.firstWhere((category) => category.id == id);
  }
}

class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.controller,
    required this.begin,
    required this.end,
    required this.offset,
    required this.child,
  });

  final AnimationController controller;
  final double begin;
  final double end;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        final progress =
            ((controller.value - begin) / (end - begin)).clamp(0.0, 1.0);
        final eased = Curves.easeOutCubic.transform(progress.toDouble());

        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(
              offset.dx * (1 - eased),
              offset.dy * (1 - eased),
            ),
            child: Transform.scale(
              scale: 0.965 + (0.035 * eased),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star_rounded,
          size: 27,
          color: Color(0xFFFF7A67),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'DEENRUSH',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 27,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: 43,
          height: 43,
          padding: const EdgeInsets.all(2.5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: const ClipOval(
            child: CustomPaint(
              painter: _MiniAvatarPainter(),
              child: SizedBox.expand(),
            ),
          ),
        ),
      ],
    );
  }
}

class _GreetingBlock extends StatelessWidget {
  const _GreetingBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Hey, Ahmed!',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 28,
                            height: 0.95,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                            color: Color(0xFF242121),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 22,
                        color: Color(0xFF242121),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Ready for today's wisdom?",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.8,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF504D4B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: const Color(0xFFFF7A67),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    size: 15,
                    color: Color(0xFF220D0A),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '12 DAY STREAK',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF220D0A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const _XpProgress(),
      ],
    );
  }
}

class _XpProgress extends StatelessWidget {
  const _XpProgress();

  @override
  Widget build(BuildContext context) {
    const progress = 0.65;

    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFFE4E2DC),
        borderRadius: BorderRadius.circular(999),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF067B5D),
              ),
            ),
          ),
          const Center(
            child: Text(
              '650 / 1000 XP',
              style: TextStyle(
                fontSize: 12,
                height: 1,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyQuestCard extends StatelessWidget {
  const _DailyQuestCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -20,
          top: -22,
          child: Container(
            width: 118,
            height: 118,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD7C8FF),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(27, 27, 27, 27),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F4EF),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Quest',
                          style: TextStyle(
                            fontSize: 32,
                            height: 0.96,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.2,
                            color: Color(0xFF252323),
                            shadows: [
                              Shadow(
                                color: Color(0xFFE7E2DD),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 13),
                        Text(
                          'Conquer the Pillars Challenge',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.5,
                            height: 1,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF504D4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF4A75),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.timer_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Expanded(
                    child: _QuestMetric(
                      label: 'TIME REMAINING',
                      value: '14:22:05',
                      valueColor: Color(0xFFB2382A),
                    ),
                  ),
                  SizedBox(width: 17),
                  SizedBox(
                    height: 43,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Color(0xFFE5E0DB),
                    ),
                  ),
                  SizedBox(width: 17),
                  Expanded(
                    child: _QuestMetric(
                      label: 'REWARDS',
                      value: '+150 XP',
                      valueColor: Color(0xFF067B5D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _StartJourneyButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuestMetric extends StatelessWidget {
  const _QuestMetric({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.2,
              color: Color(0xFF8E8884),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            value,
            style: TextStyle(
              fontSize: 23,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.1,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartJourneyButton extends StatefulWidget {
  const _StartJourneyButton();

  @override
  State<_StartJourneyButton> createState() => _StartJourneyButtonState();
}

class _StartJourneyButtonState extends State<_StartJourneyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        height: 70,
        width: double.infinity,
        transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFFB23B2E),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB23B2E).withValues(alpha: 0.22),
              blurRadius: 14,
              offset: Offset(0, _pressed ? 2 : 7),
            ),
          ],
        ),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'START JOURNEY',
                style: TextStyle(
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Icon(
                Icons.rocket_launch_rounded,
                color: Colors.white,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Knowledge Hub',
            style: TextStyle(
              fontSize: 22,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              color: Color(0xFF242121),
            ),
          ),
        ),
        Text(
          'See All',
          style: TextStyle(
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.w900,
            color: Color(0xFF9B140B),
          ),
        ),
      ],
    );
  }
}

class _KnowledgeTile extends StatefulWidget {
  const _KnowledgeTile({
    required this.item,
    required this.onTap,
  });

  final _KnowledgeItem item;
  final VoidCallback onTap;

  @override
  State<_KnowledgeTile> createState() => _KnowledgeTileState();
}

class _KnowledgeTileState extends State<_KnowledgeTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOutCubic,
            scale: _pressed ? 0.965 : 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
                decoration: BoxDecoration(
                  color: widget.item.color,
                  borderRadius: BorderRadius.circular(49),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _TilePatternPainter(
                          pattern: widget.item.pattern,
                          color: widget.item.iconColor,
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        widget.item.icon,
                        size: 38,
                        color: widget.item.iconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          widget.item.label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15.5,
            height: 1,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'RANK',
            value: '#42',
            suffix: '2',
            suffixColor: Color(0xFF007B59),
            showUpArrow: true,
          ),
        ),
        SizedBox(width: 18),
        Expanded(
          child: _StatCard(
            label: 'TOTAL XP',
            value: '12.5k',
            suffix: 'LEGEND',
            suffixColor: Color(0xFFB0170E),
            showUpArrow: false,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.suffix,
    required this.suffixColor,
    required this.showUpArrow,
  });

  final String label;
  final String value;
  final String suffix;
  final Color suffixColor;
  final bool showUpArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      padding: const EdgeInsets.fromLTRB(20, 18, 14, 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4EF),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.1,
              color: Color(0xFF8E8884),
            ),
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    color: Color(0xFF242121),
                  ),
                ),
                const SizedBox(width: 7),
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Row(
                    children: [
                      if (showUpArrow)
                        Icon(
                          Icons.arrow_drop_up_rounded,
                          size: 13,
                          color: suffixColor,
                        ),
                      Text(
                        suffix,
                        style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          color: suffixColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingAction extends StatelessWidget {
  const _FloatingAction();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF05775D),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2605775D),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.add_rounded,
        color: Colors.white,
        size: 36,
      ),
    );
  }
}

class _MiniAvatarPainter extends CustomPainter {
  const _MiniAvatarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF173A42),
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.56),
      w * 0.41,
      Paint()..color = const Color(0xFF315F66),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.43),
        width: w * 0.47,
        height: h * 0.55,
      ),
      Paint()..color = const Color(0xFFFFB18D),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.23, h * 0.42)
        ..cubicTo(w * 0.28, h * 0.06, w * 0.69, h * 0.06, w * 0.77, h * 0.38)
        ..cubicTo(w * 0.66, h * 0.23, w * 0.43, h * 0.24, w * 0.33, h * 0.47)
        ..close(),
      Paint()..color = const Color(0xFF11151B),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.38, h * 0.43),
        width: w * 0.05,
        height: h * 0.04,
      ),
      Paint()..color = Colors.black,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.62, h * 0.43),
        width: w * 0.05,
        height: h * 0.04,
      ),
      Paint()..color = Colors.black,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.54),
        width: w * 0.18,
        height: h * 0.12,
      ),
      0.2,
      math.pi - 0.4,
      false,
      Paint()
        ..color = const Color(0xFF8E3D35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.22, h)
        ..lineTo(w * 0.38, h * 0.68)
        ..lineTo(w * 0.62, h * 0.68)
        ..lineTo(w * 0.78, h)
        ..close(),
      Paint()..color = const Color(0xFFE9F1F0),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.39, h * 0.75)
        ..lineTo(w * 0.5, h * 0.92)
        ..lineTo(w * 0.61, h * 0.75),
      Paint()
        ..color = const Color(0xFF0C6E7A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.1,
    );
  }

  @override
  bool shouldRepaint(_MiniAvatarPainter oldDelegate) => false;
}

class _TilePatternPainter extends CustomPainter {
  const _TilePatternPainter({
    required this.pattern,
    required this.color,
  });

  final _TilePattern pattern;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (pattern == _TilePattern.none) {
      return;
    }

    final paint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..strokeWidth = 1;

    if (pattern == _TilePattern.dots) {
      for (var y = 14.0; y < size.height; y += 14) {
        for (var x = 14.0; x < size.width; x += 14) {
          canvas.drawCircle(Offset(x, y), 1.1, paint);
        }
      }
      return;
    }

    for (var i = -size.height; i < size.width + size.height; i += 8) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_TilePatternPainter oldDelegate) {
    return pattern != oldDelegate.pattern || color != oldDelegate.color;
  }
}

class _KnowledgeItem {
  const _KnowledgeItem({
    required this.label,
    required this.category,
    required this.icon,
    required this.iconColor,
    required this.color,
    required this.pattern,
  });

  final String label;
  final QuizCategory category;
  final IconData icon;
  final Color iconColor;
  final Color color;
  final _TilePattern pattern;
}

enum _TilePattern {
  none,
  dots,
  stripes,
}

extension _QuizCategoryCopy on QuizCategory {
  QuizCategory copyAs({
    required String id,
    required String labelKey,
    required IconData icon,
    required Color color,
  }) {
    return QuizCategory(
      id: id,
      labelKey: labelKey,
      icon: icon,
      color: color,
      levels: levels,
    );
  }
}
