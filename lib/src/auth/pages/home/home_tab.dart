import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/config/app_data.dart' as appData;
import 'package:thegreengrocer/src/auth/pages/common_widgets/custom_shimmer.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';
import '../common_widgets/app_name_widget.dart';
import 'components/category_tile.dart';
import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  //recebe a globalkey de uma imagem
  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //tira a sombra
        centerTitle: true,
        title: const AppNameWidget(),

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
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        //chave global
        previewDuration: const Duration(milliseconds: 100),
        //duracao da animacao
        previewCurve: Curves.decelerate,
        //animacao

        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },

        child: Column(
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
              child: !isLoading
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal, //direcao da lista
                      itemBuilder: (_, index) {
                        return CategoryTile(
                          onPressed: () {
                            setState(() {
                              selectedCategory = appData.categories[index];
                            });
                          },
                          category: appData.categories[index],
                          isSelected:
                              appData.categories[index] == selectedCategory,
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      // separatorBuilder: (_,index){
                      //   return const SizedBox(
                      //     width: 10,
                      //   );
                      // },
                      itemCount: appData.categories.length)
                  : ListView(
                      scrollDirection: Axis.horizontal, //direcao da lista
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 8, 12),
                          child: CustomShimmer(
                            height: 20,
                            width: 65,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
            ),
            //GRID
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      //espacamento de cada "card"
                      physics: const BouncingScrollPhysics(),
                      //animacao de arrastar
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5),
                      itemCount: appData.items.length,
                      //tamanho da minha lista
                      itemBuilder: (_, index) {
                        return ItemTile(
                            item: appData.items[index],
                            cartAnimationMethod: itemSelectedCartAnimations);
                      },
                    )
                  : GridView.count(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      //espacamento de cada "card"
                      physics: const BouncingScrollPhysics(),
                      //animacao de arrastar
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(
                        10,
                        (index) => CustomShimmer(
                          height: double.infinity,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
