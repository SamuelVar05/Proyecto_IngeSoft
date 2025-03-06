import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String userName;
  final Function(String query) onSearch;
  final Function() onScan;
  final Function() onFilterProducts;
  final Function() onFilterChazas;
  final Function(bool) onToggleSearch;

  const SearchBarWidget({
    Key? key,
    required this.userName,
    required this.onSearch,
    required this.onScan,
    required this.onFilterProducts,
    required this.onFilterChazas,
    required this.onToggleSearch,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isSearchingProducts = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: const BoxDecoration(
        color: UNChazaTheme.orange,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text("Bienvenido(a) a UN Chaza!",
                style: UNChazaTheme.textTheme.displayMedium
                    ?.copyWith(color: UNChazaTheme.white)),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: UNChazaTheme.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Ajusta al tamaño de los hijos
                  children: [
                    _segmentedControlButton("Chazas", !isSearchingProducts, () {
                      setState(() {
                        isSearchingProducts = false;
                      });
                      widget.onToggleSearch(false);
                    }),
                    _segmentedControlButton("Productos", isSearchingProducts,
                        () {
                      setState(() {
                        isSearchingProducts = true;
                      });
                      widget.onToggleSearch(true);
                    }),
                  ],
                ),
              ),
            ),
          ),

          // Search bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: UNChazaTheme.white,
                hintText:
                    isSearchingProducts ? "Buscar productos" : "Buscar chazas",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: UNChazaTheme.darkGrey),
                  onPressed: () {
                    widget.onSearch(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          // Secondary buttons
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Alineación ajustada
              children: [
                if (isSearchingProducts)
                  CustomButton(
                    text: "Escanear",
                    buttonColor: UNChazaTheme.white.withOpacity(0.3),
                    textColor: UNChazaTheme.white,
                    icon: Icons.qr_code_scanner,
                    onPressed: widget.onScan,
                  ),
                if (isSearchingProducts) const SizedBox(width: 10),
                CustomButton(
                  text: "Filtrar",
                  buttonColor: UNChazaTheme.white.withOpacity(0.3),
                  textColor: UNChazaTheme.white,
                  icon: Icons.filter_list,
                  onPressed: isSearchingProducts
                      ? widget.onFilterProducts
                      : widget.onFilterChazas,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _segmentedControlButton(
      String text, bool isActive, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: UNChazaTheme.textTheme.titleLarge
                ?.copyWith(color: isActive ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
