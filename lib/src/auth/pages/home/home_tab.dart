import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/config/app_data.dart' as appData;
import 'components/category_tile.dart';
import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //tira a sombra
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 30),
            children: [
              TextSpan(
                text: "Green",
                style: TextStyle(
                  color: CustomColors.customSwatchColor,
                ),
              ),
              TextSpan(
                text: "grocer",
                style: TextStyle(
                  color: CustomColors.customContrastColor,
                ),
              ),
            ],
          ),
        ),

        actions: [
          //botao do carrinho
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          //CAMPO DE PESQUISA
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: "Pesquise aqui...",
                hintStyle: const TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.customContrastColor,
                  size: 21,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),

          //CATEGORIAS
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
                scrollDirection: Axis.horizontal, //direcao da lista
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCategory = appData.categories[index];
                      });
                    },
                    category: appData.categories[index],
                    isSelected: appData.categories[index] == selectedCategory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                // separatorBuilder: (_,index){
                //   return const SizedBox(
                //     width: 10,
                //   );
                // },
                itemCount: appData.categories.length),
          ),

          //GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), //espacamento de cada "card"
              physics: const BouncingScrollPhysics(), //animacao de arrastar
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 11.5
              ),
              itemCount: appData.items.length, //tamanho da minha lista
              itemBuilder: (_,index){
                  return ItemTile(
                    item: appData.items[index],
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
