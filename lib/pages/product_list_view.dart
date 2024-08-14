part of 'product_list_page.dart';

class ProductListView extends StatelessWidget {
  final ProductListPageState pageState;

  const ProductListView({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            switch (state) {
              case Initial():
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(const FetchProducts());
                      },
                      child: const Text('Get Items'),
                    ),
                  ),
                );
              case Loading():
                return const Center(child: CircularProgressIndicator());
              case Loaded():
                return ListView.builder(
                  itemCount: state.products.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = state.products[index];

                    return ListTile(
                      leading: Image.network(
                        product.thumbnail,
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title),
                      contentPadding: const EdgeInsets.all(8),
                      horizontalTitleGap: 16,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 8,),


                          Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 14),)
                        ],
                      ),
                    );
                  },
                );
              case Error():
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              default:
                return const Center(
                    child: Text('Press the button to fetch products'));
            }
          },
        ),
      ),
    );
  }
}
