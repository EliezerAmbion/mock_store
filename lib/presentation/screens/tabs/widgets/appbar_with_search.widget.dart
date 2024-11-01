import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/tabs/widgets/sort_dialog.widget.dart';

class AppBarWithSearchWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final bool? isMobile;

  const AppBarWithSearchWidget({this.isMobile = false, super.key});

  @override
  State<AppBarWithSearchWidget> createState() => _AppBarWithSearchWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWithSearchWidgetState extends State<AppBarWithSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        size: 30,
      ),
      centerTitle: true,
      title: SizedBox(
        width: (widget.isMobile ?? false)
            ? MediaQuery.sizeOf(context).width * .7
            : MediaQuery.sizeOf(context).width * .4,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: (value) {
            context.read<ProductsBloc>().add(SearchProducts(value));
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const SortDialogWidget();
                  });
            },
            child: const Icon(Icons.sort),
          ),
        ),
      ],
    );
  }
}
