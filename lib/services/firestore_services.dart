import 'package:emart_app/consts/consts.dart';

class FirestoreServices{
  //get users data according to users id
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

  //get vendor profile
  // static getProfile(uid){
  //   return firestore.collection(vendorsCollection).where('id', isEqualTo: uid).get();
  // }

  //get products according to category
  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
  }

  //get subcategory products according to title
  static getSubCategoryProducts(title){
    return firestore.collection(productsCollection).where('p_subcategory', isEqualTo: title).snapshots();
  }

  //get cart data according to users id
static getCart(uid){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
}

//delete cart data according to document id
static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
}

//get chat and messages data according to document id
static getChatMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
}

//get all orders in orders section
static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
}

//get orders for vendor
//   static getOrders(uid){
//     return firestore.collection(ordersCollection).where('vendors', arrayContains: currentUser!.uid).snapshots();
//   }

//get wishlist data in the wishlist section
static getWishlists(){
  return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
}

//get all messages in the messages section
static getAllMessages(){
  return firestore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
}
//get all messages for vendor
//   static getMessages(){
//     return firestore.collection(chatsCollection).where('toId', isEqualTo: uid).snapshots();
//   }

//get all counts in the profile screen
static getCounts()async{
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
       return value.docs.length;
    }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  //get all products for homepage
static getAllProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  // get featured products on home screen according to true and false
// static getFeaturedProducts(){
//     return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).snapshots();
// }

//to get search results on homepage
static searchProducts(title){
    return firestore.collection(productsCollection).get();
}


}