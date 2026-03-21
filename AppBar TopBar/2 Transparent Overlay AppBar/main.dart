import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transparent AppBar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A2E)),
        useMaterial3: true,
      ),
      home: const ShowcaseScreen(),
    );
  }
}

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<(String, String, String, Color, Widget)> items = [
      (
        'V1',
        'Pure Transparent',
        'Fully transparent — no tint, no blur',
        const Color(0xFF1565C0),
        const V1PureTransparent(),
      ),
      (
        'V2',
        'Dark Circle Icons',
        'Dark circle behind icons — visible even on light images',
        const Color(0xFF00695C),
        const V2DarkCircleIcons(),
      ),
      (
        'V3',
        'Gradient Overlay',
        'Dark gradient top + bottom — text shows clearly',
        const Color(0xFF4527A0),
        const V3GradientOverlay(),
      ),
      (
        'V4',
        'Scroll-to-Solid',
        'Scrolling transitions from transparent to solid color',
        const Color(0xFFC62828),
        const V4ScrollToSolid(),
      ),
      (
        'V5',
        'Blur / Frosted Glass',
        'Frosted glass blur effect appears on scroll',
        const Color(0xFF37474F),
        const V5BlurEffect(),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: const Text('Transparent AppBar'),
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final (label, title, sub, color, page) = items[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => page),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              sub,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 13,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FakeHeroImage extends StatelessWidget {
  final double height;
  final List<Color> colors;
  const _FakeHeroImage({this.height = 400, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          ...List.generate(18, (i) {
            final x = (i * 83.0) % 340;
            final y = (i * 53.0) % (height - 40);
            final size = 30.0 + (i % 5) * 22;
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.03 + (i % 4) * 0.02),
                ),
              ),
            );
          }),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.landscape,
                  size: 72,
                  color: Colors.white.withOpacity(0.25),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hero Image',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 15,
                    letterSpacing: 2,
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

class V1PureTransparent extends StatelessWidget {
  const V1PureTransparent({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _FakeHeroImage(
              colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
            ),
            _InfoCard(
              title: 'V1 — Pure Transparent',
              color: const Color(0xFF1565C0),
              points: const [
                'extendBodyBehindAppBar: true\n→ body extends behind the AppBar across the full screen',
                'backgroundColor: Colors.transparent\n→ AppBar has no background',
                'elevation: 0 + surfaceTintColor: transparent\n→ disables both shadow and M3 tint',
                'systemOverlayStyle\n→ makes status bar icons white (Android + iOS)',
                'foregroundColor: Colors.white\n→ all icons automatically turn white',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class V2DarkCircleIcons extends StatefulWidget {
  const V2DarkCircleIcons({super.key});
  @override
  State<V2DarkCircleIcons> createState() => _V2State();
}

class _V2State extends State<V2DarkCircleIcons> {
  bool _liked = false;
  Widget _circleBtn({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.38),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: iconColor ?? Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Center(
            child: _circleBtn(
              icon: Icons.arrow_back_ios_new,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          _circleBtn(
            icon: _liked ? Icons.favorite : Icons.favorite_border,
            iconColor: _liked ? Colors.red[300] : Colors.white,
            onTap: () => setState(() => _liked = !_liked),
          ),
          const SizedBox(width: 10),
          _circleBtn(icon: Icons.share_outlined, onTap: () {}),
          const SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _FakeHeroImage(
              colors: [Color(0xFF80DEEA), Color(0xFF26C6DA)],
            ),
            _InfoCard(
              title: 'V2 — Dark Circle Icons',
              color: const Color(0xFF00695C),
              points: const [
                'Container + BoxShape.circle\n→ circle background behind each icon',
                'Colors.black.withOpacity(0.38)\n→ semi-transparent dark, image still visible',
                'leadingWidth: 64\n→ without it, the back button circle gets clipped',
                'Visible even on light images\n→ safe pattern for any image',
                'Tap the favorite button — it turns into a red heart',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class V3GradientOverlay extends StatelessWidget {
  const V3GradientOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    final statusBarH = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Travel Story',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 420,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: _FakeHeroImage(
                      colors: [Color(0xFF4527A0), Color(0xFF6A1B9A)],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: statusBarH + kToolbarHeight + 20,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xCC000000), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 190,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xEE000000), Colors.transparent],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.22),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: const Text(
                              'Travel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Hidden Valleys of\nSoutheast Asia',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                child: const Text(
                                  'T',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Tanvir Ahmed  ·  5 min read',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _InfoCard(
              title: 'V3 — Gradient Overlay',
              color: const Color(0xFF4527A0),
              points: const [
                'Stack → image + top gradient + bottom gradient',
                'Top gradient height = statusBarH + kToolbarHeight + 20\n→ covers only the AppBar area',
                'Bottom gradient → darkens the title/caption area',
                'Color(0xCC000000) = 80% opacity black\n0xEE=93%  0xBB=73%  0x88=53%',
                'Positioned.fill → image spans the entire Stack',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class V4ScrollToSolid extends StatefulWidget {
  const V4ScrollToSolid({super.key});
  @override
  State<V4ScrollToSolid> createState() => _V4State();
}

class _V4State extends State<V4ScrollToSolid> {
  final _scrollCtrl = ScrollController();
  double _opacity = 0.0;
  static const double _threshold = 220.0;
  static const Color _solidColor = Color(0xFFC62828);

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    final newOp = (_scrollCtrl.offset / _threshold).clamp(0.0, 1.0);
    if ((newOp - _opacity).abs() > 0.008) setState(() => _opacity = newOp);
  }

  @override
  void dispose() {
    _scrollCtrl
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _solidColor.withOpacity(_opacity),
        elevation: _opacity > 0.5 ? 2 : 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Opacity(
          opacity: _opacity,
          child: const Text(
            'Product Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollCtrl,
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                const _FakeHeroImage(
                  height: 360,
                  colors: [Color(0xFFEF9A9A), Color(0xFFE53935)],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 80,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0x44000000), Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _InfoCard(
              title: 'V4 — Scroll to Solid',
              color: const Color(0xFFC62828),
              points: const [
                'ScrollController + addListener(_onScroll)\n→ tracks the scroll offset',
                '_opacity = (offset / threshold).clamp(0.0, 1.0)\n→ smooth transition from 0.0 to 1.0',
                'backgroundColor: color.withOpacity(_opacity)\n→ gradually becomes solid',
                'title: Opacity(opacity: _opacity)\n→ title fades in as you scroll',
                'Scroll down — the AppBar turns solid red',
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Item ${i + 1}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              childCount: 14,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class V5BlurEffect extends StatefulWidget {
  const V5BlurEffect({super.key});
  @override
  State<V5BlurEffect> createState() => _V5State();
}

class _V5State extends State<V5BlurEffect> {
  final _scrollCtrl = ScrollController();
  double _opacity = 0.0;
  static const double _threshold = 160.0;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final newOp = (_scrollCtrl.offset / _threshold).clamp(0.0, 1.0);
      if ((newOp - _opacity).abs() > 0.008) setState(() => _opacity = newOp);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarH = MediaQuery.of(context).padding.top;
    final appBarH = kToolbarHeight + statusBarH;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollCtrl,
            slivers: [
              SliverToBoxAdapter(
                child: const _FakeHeroImage(
                  height: 380,
                  colors: [Color(0xFF37474F), Color(0xFF263238)],
                ),
              ),
              SliverToBoxAdapter(
                child: _InfoCard(
                  title: 'V5 — Blur / Frosted Glass',
                  color: const Color(0xFF37474F),
                  points: const [
                    'BackdropFilter does not work inside Flutter AppBar\n→ use Stack + Positioned as a custom overlay',
                    'ClipRect → confines the blur to the AppBar area only',
                    'BackdropFilter + ImageFilter.blur(sigmaX: 14)\n→ blurs the content behind it',
                    'sigmaX * _opacity → blur intensity increases as you scroll',
                    'Scroll down — you will see the frosted glass effect',
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    height: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Item ${i + 1}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  childCount: 12,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: appBarH,
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 14 * _opacity,
                  sigmaY: 14 * _opacity,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  color: Colors.black.withOpacity(0.42 * _opacity),
                ),
              ),
            ),
          ),

          Positioned(
            top: statusBarH,
            left: 0,
            right: 0,
            height: kToolbarHeight,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                Opacity(
                  opacity: _opacity,
                  child: const Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 22,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 22,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> points;
  const _InfoCard({
    required this.title,
    required this.color,
    required this.points,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            ...points.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        p,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.55,
                          color: Colors.grey[750],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
