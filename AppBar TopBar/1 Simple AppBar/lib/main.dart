import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple AppBar Variations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
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
    final items = [
      (
        'V1',
        'Minimal AppBar',
        'Back + Center title only',
        const Color(0xFF6C63FF),
        const V1MinimalAppBar(),
      ),
      (
        'V2',
        'With Action Icons',
        'Back + Title + 2-3 action icons',
        const Color(0xFF00897B),
        const V2WithActionsAppBar(),
      ),
      (
        'V3',
        'With 3-dot Menu',
        'Back + Title + PopupMenu',
        const Color(0xFFE53935),
        const V3PopupMenuAppBar(),
      ),
      (
        'V4',
        'Colored AppBar',
        'Brand color + white icons',
        const Color(0xFF5C6BC0),
        const V4ColoredAppBar(),
      ),
      (
        'V5',
        'With Subtitle',
        'Title + small subtitle line',
        const Color(0xFFFF7043),
        const V5SubtitleAppBar(),
      ),
      (
        'V6',
        'With Bottom Divider',
        'White AppBar + border bottom',
        const Color(0xFF546E7A),
        const V6DividerAppBar(),
      ),
      (
        'V7',
        'Left-aligned Title',
        'No back button, logo left',
        const Color(0xFF00ACC1),
        const V7LeftTitleAppBar(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Simple AppBar Variations'),
        backgroundColor: const Color(0xFF6C63FF),
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
                          color: color.withValues(alpha: 0.12),
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

class V1MinimalAppBar extends StatelessWidget {
  const V1MinimalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),

        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),

        centerTitle: true,

        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: const _DemoBody(
        title: 'V1 — Minimal AppBar',
        desc:
            'Back button + center title only.\n'
            'Used in Settings, Help, About screens.\n\n'
            'Key properties:\n'
            '• leading → back button widget\n'
            '• centerTitle: true → centered title\n'
            '• elevation: 0 → no shadow\n'
            '• surfaceTintColor: transparent → M3 tint off',
      ),
    );
  }
}

class V2WithActionsAppBar extends StatefulWidget {
  const V2WithActionsAppBar({super.key});

  @override
  State<V2WithActionsAppBar> createState() => _V2WithActionsAppBarState();
}

class _V2WithActionsAppBarState extends State<V2WithActionsAppBar> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Product Detail',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,

        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),

              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(_isFavorite),
                color: _isFavorite ? Colors.red : Colors.black87,
                size: 22,
              ),
            ),
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
              _showSnack(
                context,
                _isFavorite ? 'Added to favorites' : 'Removed from favorites',
              );
            },
            tooltip: 'Favorite',
          ),

          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22),
            onPressed: () => _showSnack(context, 'Shared!'),
            tooltip: 'Share',
          ),

          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, size: 22),
              onPressed: () => _showSnack(context, 'Added to cart'),
              tooltip: 'Cart',
            ),
          ),
        ],
      ),
      body: _DemoBody(
        title: 'V2 — With Action Icons',
        desc:
            'Back + Title + Favorite + Share + Cart.\n'
            'Tap the Favorite button — it will animate.\n\n'
            'Key points:\n'
            '• actions: [] → add IconButtons to the list\n'
            '• AnimatedSwitcher → animates icon switch\n'
            '• ValueKey → Flutter detects widget replacement\n'
            '• Add right padding to the last icon',
      ),
    );
  }
}

class V3PopupMenuAppBar extends StatefulWidget {
  const V3PopupMenuAppBar({super.key});

  @override
  State<V3PopupMenuAppBar> createState() => _V3PopupMenuAppBarState();
}

class _V3PopupMenuAppBarState extends State<V3PopupMenuAppBar> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Post',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              size: 22,
              color: _isBookmarked ? Colors.red : null,
            ),
            onPressed: () {
              setState(() => _isBookmarked = !_isBookmarked);
              _showSnack(
                context,
                _isBookmarked ? 'Bookmarked' : 'Removed bookmark',
              );
            },
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 22),

            offset: const Offset(0, 40),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            elevation: 4,

            onSelected: (value) {
              _showSnack(context, 'Selected: $value');
            },

            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 18, color: Colors.black54),
                    SizedBox(width: 10),
                    Text('Edit post'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy_outlined, size: 18, color: Colors.black54),
                    SizedBox(width: 10),
                    Text('Copy link'),
                  ],
                ),
              ),

              const PopupMenuDivider(),

              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: const _DemoBody(
        title: 'V3 — With 3-dot Popup Menu',
        desc:
            'Tap the 3-dot menu.\n'
            'Edit / Copy link / Delete will appear.\n\n'
            'Key points:\n'
            '• PopupMenuButton → 3-dot menu\n'
            '• PopupMenuDivider → line separator\n'
            '• onSelected → receive selected value\n'
            '• offset → adjust menu position',
      ),
    );
  }
}

class V4ColoredAppBar extends StatelessWidget {
  const V4ColoredAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF5C6BC0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,

        backgroundColor: brandColor,

        foregroundColor: Colors.white,

        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.15),
          ),
        ),
      ),
      body: const _DemoBody(
        title: 'V4 — Colored AppBar',
        desc:
            'Brand color background, all icons white.\n\n'
            'Key points:\n'
            '• backgroundColor → brand color\n'
            '• foregroundColor: white → all icons/text white\n'
            '• bottom → subtle bottom separator line\n'
            '• elevation: 0 → flat look',
      ),
    );
  }
}

class V5SubtitleAppBar extends StatelessWidget {
  const V5SubtitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tanvir Ahmed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 1),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey[200]),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: const _DemoBody(
        title: 'V5 — With Subtitle',
        desc:
            'Shows online status below the title.\n'
            'Most commonly used in chat screens.\n\n'
            'Key points:\n'
            '• title: Column(...) → 2 lines\n'
            '• Green dot + "Online" text\n'
            '• crossAxisAlignment.center → center align\n'
            '• Call + Video action icons',
      ),
    );
  }
}

class V6DividerAppBar extends StatelessWidget {
  const V6DividerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Colors.black87,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Order Details',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,

        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        actions: [
          TextButton(
            onPressed: () => _showSnack(context, 'Help opened'),
            child: const Text(
              'Help',
              style: TextStyle(
                color: Color(0xFF546E7A),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        ),
      ),
      body: const _DemoBody(
        title: 'V6 — White + Bottom Divider',
        desc:
            'Clean white AppBar, separated by a border.\n\n'
            'Key points:\n'
            '• leading Container → boxed back button\n'
            '• actions TextButton → text action (Help/Done)\n'
            '• PreferredSize + Divider → clean bottom line\n'
            '• elevation: 0, surfaceTintColor: transparent',
      ),
    );
  }
}

class V7LeftTitleAppBar extends StatelessWidget {
  const V7LeftTitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        centerTitle: false,

        titleSpacing: 16,

        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF00ACC1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.waves, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 10),

            const Text(
              'FlowApp',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00ACC1),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),

        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        actions: [
          GestureDetector(
            onTap: () => _showSnack(context, 'Profile tapped'),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: const Color(
                  0xFF00ACC1,
                ).withValues(alpha: 0.15),
                child: const Text(
                  'T',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00ACC1),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              size: 22,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: const _DemoBody(
        title: 'V7 — Left-aligned Home AppBar',
        desc:
            'Logo + App name on the left. No back button.\n'
            'Used on the app home screen.\n\n'
            'Key points:\n'
            '• automaticallyImplyLeading: false → no back\n'
            '• centerTitle: false → left align\n'
            '• titleSpacing: 16 → left padding\n'
            '• actions CircleAvatar → profile button',
      ),
    );
  }
}

void _showSnack(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(12),
    ),
  );
}

class _DemoBody extends StatelessWidget {
  final String title;
  final String desc;

  const _DemoBody({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Page Content',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            5,
            (i) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
