import 'package:flutter/material.dart';
import 'package:fuse/Components/DashboardComponent/app_colors.dart';
import 'package:fuse/Components/DashboardComponent/recent_transactions_list.dart';
import 'package:fuse/Components/DashboardComponent/top_affiliates_list.dart';
import 'package:fuse/Components/DashboardComponent/wallet_summary_card.dart';
import 'package:fuse/Pages/signin.dart';
import '../Components/DashboardComponent/custom_app_bar.dart';
import '../Components/DashboardComponent/indicators_chart_card.dart';
import 'package:clerk_flutter/clerk_flutter.dart' as clerk;
import 'package:clerk_auth/clerk_auth.dart' as auth;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final clerk.ClerkAuthState _auth;
  auth.User? _user;
  bool _authInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_authInitialized) {
      _auth = clerk.ClerkAuth.of(context);
      _user = _auth.user;
      _auth.addListener(_updateUser);
      _authInitialized = true;
    }
  }

  void _updateUser() {
    if (!mounted) return;
    setState(() {
      _user = _auth.user;
    });
  }

  Future<void> _handleSignOut() async {
    try {
      await _auth.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Signed out successfully!"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      Future.delayed(Duration(seconds: 2), () {
        if (_user == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Signin()),
            (route) => false,
          );
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error signing out: $e"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;
    return user == null
        ? Scaffold(
            body: Center(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Signing Out..."),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: CustomAppBar(),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.divider),
                    child: Text(
                      user!.email!,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),

                    title: Text("Logout"),
                    onTap: () {
                      Navigator.pop(context);
                      _handleSignOut();
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  IndicatorsChartCard(),
                  SizedBox(height: 16),
                  WalletSummaryCard(),
                  SizedBox(height: 16),
                  RecentTransactionsList(),
                  SizedBox(height: 16),
                  TopAffiliatesList(),
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    if (_authInitialized) {
      _auth.removeListener(_updateUser);
      _authInitialized = false;
    }
    super.dispose();
  }
}
