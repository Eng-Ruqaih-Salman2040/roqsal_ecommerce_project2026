class OrdersModel {
  String? ordersId;
  String? ordersUsersid;
  String? ordersAddress;
  String? ordersType;
  String? ordersPricedelivery;
  String? ordersPrice;
  String? ordersTotalprice;
  String? ordersCoupon;
  String? ordersNoterating;
  String? ordersRating;
  String? ordersPaymentmethod;
  String? ordersStatus;
  String? ordersDatetime;
  String? addressId;
  String? addressUsersid;
  String? addressName;
  String? addressCity;
  String? addressStreet;
  String? addressLat;
  String? addressLong;

  OrdersModel(
      {this.ordersId,
      this.ordersUsersid,
      this.ordersAddress,
      this.ordersType,
      this.ordersPricedelivery,
      this.ordersPrice,
      this.ordersTotalprice,
      this.ordersCoupon,
        this.ordersNoterating,
        this.ordersRating,
      this.ordersPaymentmethod,
      this.ordersStatus,
      this.ordersDatetime,
      this.addressId,
      this.addressUsersid,
      this.addressName,
      this.addressCity,
      this.addressStreet,
      this.addressLat,
      this.addressLong});
  OrdersModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id']?.toString();
    ordersUsersid = json['orders_usersid']?.toString();
    ordersAddress = json['orders_address']?.toString();
    ordersType = json['orders_type']?.toString();
    ordersPricedelivery = json['orders_pricedelivery']?.toString();
    ordersPrice = json['orders_price']?.toString();
    ordersTotalprice = json['orders_totalprice']?.toString();
    ordersCoupon = json['orders_coupon']?.toString();

    ordersNoterating = json['orders_noterating']?.toString();
    ordersRating = json['orders_rating']?.toString();

    ordersPaymentmethod = json['orders_paymentmethod']?.toString();
    ordersStatus = json['orders_status']?.toString();
    ordersDatetime = json['orders_datetime']?.toString();
    addressId = json['address_id']?.toString();
    addressUsersid = json['address_usersid']?.toString();
    addressName = json['address_name']?.toString();
    addressCity = json['address_city']?.toString();
    addressStreet = json['address_street']?.toString();
    addressLat = json['address_lat']?.toString();
    addressLong = json['address_long']?.toString();
  }

  // OrdersModel.fromJson(Map<String, dynamic> json) {
  //   ordersId = json['orders_id'];
  //   ordersUsersid = json['orders_usersid'];
  //   ordersAddress = json['orders_address'];
  //   ordersType = json['orders_type'];
  //   ordersPricedelivery = json['orders_pricedelivery'];
  //   ordersPrice = json['orders_price'];
  //   ordersTotalprice = json['orders_totalprice'];
  //   ordersCoupon = json['orders_coupon'];
  //   ordersPaymentmethod = json['orders_paymentmethod'];
  //   ordersStatus = json['orders_status'];
  //   ordersDatetime = json['orders_datetime'];
  //   addressId = json['address_id'];
  //   addressUsersid = json['address_usersid'];
  //   addressName = json['address_name'];
  //   addressCity = json['address_city'];
  //   addressStreet = json['address_street'];
  //   addressLat = json['address_lat'];
  //   addressLong = json['address_long'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.ordersId;
    data['orders_usersid'] = this.ordersUsersid;
    data['orders_address'] = this.ordersAddress;
    data['orders_type'] = this.ordersType;
    data['orders_pricedelivery'] = this.ordersPricedelivery;
    data['orders_price'] = this.ordersPrice;
    data['orders_totalprice'] = this.ordersTotalprice;
    data['orders_coupon'] = this.ordersCoupon;

    data['orders_noterating'] = this.ordersNoterating;
    data['orders_rating'] = this.ordersRating;

    data['orders_paymentmethod'] = this.ordersPaymentmethod;
    data['orders_status'] = this.ordersStatus;
    data['orders_datetime'] = this.ordersDatetime;
    data['address_id'] = this.addressId;
    data['address_usersid'] = this.addressUsersid;
    data['address_name'] = this.addressName;
    data['address_city'] = this.addressCity;
    data['address_street'] = this.addressStreet;
    data['address_lat'] = this.addressLat;
    data['address_long'] = this.addressLong;
    return data;
  }
}