import 'package:flutter/material.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import 'category_levels_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeTab _tab = _HomeTab.newItems;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final cards = _cards();
    final visible = cards.where((e) => e.tabs.contains(_tab)).toList();
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF8E45FE)),
      child: Stack(children: [
        Positioned.fill(child: _background()),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 18, 14, 150),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _hero(strings),
            const SizedBox(height: 28),
            _section(strings.text('homeTrending'), strings.text('homeViewMore')),
            const SizedBox(height: 14),
            SizedBox(
              height: 164,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (_, i) => SizedBox(
                  width: 134,
                  child: _card(cards[i], strings, compact: true),
                ),
              ),
            ),
            const SizedBox(height: 26),
            _section(strings.text('homeLeaderboard'), strings.text('homeViewMore')),
            const SizedBox(height: 14),
            SizedBox(
              height: 122,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _leaders.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(top: _leaders[i].topInset),
                  child: _leader(_leaders[i]),
                ),
              ),
            ),
            const SizedBox(height: 22),
            _tabs(strings),
            const SizedBox(height: 18),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visible.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                mainAxisExtent: 214,
              ),
              itemBuilder: (_, i) => _card(visible[i], strings),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _background() => Stack(children: const [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8E45FE),
                  Color(0xFF9752FF),
                  Color(0xFF7F3AF5),
                  Color(0xFF6E2CF0),
                ],
              ),
            ),
          ),
        ),
        _Glow(size: 240, top: -110, left: -60, color: Color(0x55FFFFFF)),
        _Glow(size: 180, top: -34, right: -58, color: Color(0x40D5A8FF)),
        _Glow(size: 200, top: 118, right: -64, color: Color(0x2FFFD86B)),
        _Glow(size: 180, left: -44, bottom: 120, color: Color(0x3697EEFF)),
      ]);

  Widget _hero(AppStrings strings) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Row(children: [
            Stack(clipBehavior: Clip.none, children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFF1C9), Color(0xFFFFBEA3)],
                    ),
                  ),
                  child: Icon(Icons.face_3_rounded, color: Color(0xFF8E45FE)),
                ),
              ),
              Positioned(
                top: 2,
                right: -1,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4B73),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(strings.text('homeGreetingName'),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(strings.text('homePlayEnjoy'),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xD9FFFFFF))),
                ],
              ),
            ),
          ]),
        ),
        _coin(),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(color: Color(0xFFFFD53A), shape: BoxShape.circle),
          child: const Icon(Icons.add_rounded, color: Color(0xFF6B39E1)),
        ),
      ]);

  Widget _coin() => Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          _Coin(),
          SizedBox(width: 8),
          Text('1400', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
        ]),
      );

  Widget _section(String title, String action) => Row(children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
        Text(
          action,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xD9FFFFFF)),
        ),
      ]);

  Widget _tabs(AppStrings strings) => Row(children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _HomeTab.values.map((tab) {
                final active = tab == _tab;
                return Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: GestureDetector(
                    onTap: () => setState(() => _tab = tab),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(strings.text(tab.key),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                            color: active ? Colors.white : Colors.white.withValues(alpha: 0.74),
                          )),
                      const SizedBox(height: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: active ? 16 : 0,
                        height: 3,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)),
                      ),
                    ]),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.grid_view_rounded, size: 18, color: Colors.white),
        ),
      ]);

  Widget _card(_CardData card, AppStrings strings, {bool compact = false}) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _open(card.category),
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [BoxShadow(color: Color(0x4D6E2ED8), blurRadius: 22, offset: Offset(0, 12))],
            ),
            child: Padding(
              padding: EdgeInsets.all(compact ? 8 : 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    height: compact ? 84 : 116,
                    width: double.infinity,
                    child: _preview(card),
                  ),
                ),
                SizedBox(height: compact ? 10 : 12),
                Text(
                  strings.text(card.titleKey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF5A3AE5)),
                ),
                const SizedBox(height: 5),
                Text(
                  strings.text('homeCardMeta'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF9A97B4)),
                ),
              ]),
            ),
          ),
        ),
      );

  Widget _preview(_CardData card) => Stack(fit: StackFit.expand, children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: card.colors),
          ),
        ),
        Positioned(
          top: -12,
          right: -10,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.24), shape: BoxShape.circle),
          ),
        ),
        Positioned(
          left: -8,
          bottom: -14,
          child: Container(
            width: 88,
            height: 42,
            decoration: BoxDecoration(
              color: card.colors.last.withValues(alpha: 0.9),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(color: Color(0x26FFFFFF), shape: BoxShape.circle),
            child: const Icon(Icons.auto_awesome_rounded, size: 13, color: Colors.white),
          ),
        ),
        Center(
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(card.icon, size: 30, color: Colors.white),
          ),
        ),
      ]);

  Widget _leader(_LeaderData leader) => SizedBox(
        width: 74,
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 32, 8, 10),
              decoration: BoxDecoration(
                color: leader.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: leader.cardColor.withValues(alpha: 0.4), blurRadius: 18, offset: const Offset(0, 12))],
              ),
              child: Column(children: [
                Text(leader.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                const Spacer(),
                Container(
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
                  child: Text(leader.score, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ]),
            ),
          ),
          Positioned(
            top: 0,
            left: 11,
            right: 11,
            child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
              Container(
                width: 52,
                height: 52,
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFFFFF7EE), shape: BoxShape.circle),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [leader.top, leader.bottom]),
                  ),
                  child: Icon(leader.icon, size: 24, color: leader.iconColor),
                ),
              ),
              if (leader.crown)
                const Positioned(
                  top: -10,
                  child: Icon(Icons.workspace_premium_rounded, size: 20, color: Color(0xFFFFD84A)),
                ),
            ]),
          ),
        ]),
      );

  void _open(QuizCategory category) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => CategoryLevelsScreen(category: category)));
  }

  List<_CardData> _cards() {
    final history = _cat('history');
    final quran = _cat('quran');
    final geography = _cat('geography');
    final fiqh = _cat('fiqh');
    final mixed = _cat('mixed');
    final culture = _cat('culture');
    return [
      _CardData('homeCardAnimal', history.copyAs(id: 'seerah', labelKey: 'seerah', icon: Icons.auto_stories_rounded, color: const Color(0xFFFFBE6D)), Icons.pets_rounded, const [Color(0xFFFFF7EA), Color(0xFF8EDB8A)], const {_HomeTab.newItems, _HomeTab.special, _HomeTab.characters}),
      _CardData('homeCardFlower', quran, Icons.menu_book_rounded, const [Color(0xFFFFF2E9), Color(0xFFFFBBD2)], const {_HomeTab.newItems, _HomeTab.special, _HomeTab.flowers}),
      _CardData('homeCardTravel', geography.copyAs(id: 'travel', labelKey: 'travel', icon: Icons.travel_explore_rounded, color: const Color(0xFFFF9069)), Icons.flight_rounded, const [Color(0xFFFFF5EC), Color(0xFFFFC28C)], const {_HomeTab.newItems, _HomeTab.special}),
      _CardData('homeCardAnimal', fiqh, Icons.wb_sunny_rounded, const [Color(0xFFFFF8D9), Color(0xFFFFD84A)], const {_HomeTab.newItems, _HomeTab.characters}),
      _CardData('homeCardFlower', mixed.copyAs(id: 'hadith', labelKey: 'hadith', icon: Icons.chat_bubble_rounded, color: const Color(0xFF8F64FF)), Icons.egg_rounded, const [Color(0xFFF2F6FF), Color(0xFF9B86FF)], const {_HomeTab.newItems, _HomeTab.special, _HomeTab.characters}),
      _CardData('homeCardFlower', culture.copyAs(id: 'ethics', labelKey: 'ethics', icon: Icons.favorite_rounded, color: const Color(0xFFFEA95A)), Icons.cruelty_free_rounded, const [Color(0xFFF4FFF6), Color(0xFF7FDF74)], const {_HomeTab.newItems, _HomeTab.flowers}),
      _CardData('homeCardArtDay', geography, Icons.landscape_rounded, const [Color(0xFFF4FBFF), Color(0xFF9ED0FF)], const {_HomeTab.special, _HomeTab.flowers}),
    ];
  }

  QuizCategory _cat(String id) => quizCatalog.firstWhere((e) => e.id == id);
}

class _Glow extends StatelessWidget {
  const _Glow({this.top, this.right, this.bottom, this.left, required this.size, required this.color});
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)])),
        ),
      );
}

class _Coin extends StatelessWidget {
  const _Coin();
  @override
  Widget build(BuildContext context) => Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(color: Color(0xFFFDD73B), shape: BoxShape.circle),
        child: const Icon(Icons.monetization_on_rounded, size: 15, color: Color(0xFF9A5F00)),
      );
}

class _CardData {
  const _CardData(this.titleKey, this.category, this.icon, this.colors, this.tabs);
  final String titleKey;
  final QuizCategory category;
  final IconData icon;
  final List<Color> colors;
  final Set<_HomeTab> tabs;
}

class _LeaderData {
  const _LeaderData(this.name, this.score, this.cardColor, this.top, this.bottom, this.icon, this.iconColor, this.topInset, {this.crown = false});
  final String name;
  final String score;
  final Color cardColor;
  final Color top;
  final Color bottom;
  final IconData icon;
  final Color iconColor;
  final double topInset;
  final bool crown;
}

const _leaders = [
  _LeaderData('Calzoni', '12400', Color(0xFFF0B320), Color(0xFFFFF1D9), Color(0xFFFFD383), Icons.person_rounded, Color(0xFF946100), 0, crown: true),
  _LeaderData('Donin', '11200', Color(0xFF6B53E3), Color(0xFFF4E9FF), Color(0xFFBC9BFF), Icons.psychology_alt_rounded, Color(0xFF4323B6), 10),
  _LeaderData('Baptista', '10500', Color(0xFFEEA940), Color(0xFFFFF1DB), Color(0xFFFFC277), Icons.support_agent_rounded, Color(0xFFA75C02), 4),
  _LeaderData('saris', '1400', Color(0xFF8C93A4), Color(0xFFF2F4F7), Color(0xFFCBD2DF), Icons.face_4_rounded, Color(0xFF596071), 12),
];

enum _HomeTab {
  newItems('homeTabNew'),
  special('homeTabSpecial'),
  characters('homeTabCharacters'),
  flowers('homeTabFlowers');

  const _HomeTab(this.key);
  final String key;
}

extension _QuizCategoryCopy on QuizCategory {
  QuizCategory copyAs({String? id, String? labelKey, IconData? icon, Color? color}) {
    return QuizCategory(
      id: id ?? this.id,
      labelKey: labelKey ?? this.labelKey,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      levels: levels,
    );
  }
}
