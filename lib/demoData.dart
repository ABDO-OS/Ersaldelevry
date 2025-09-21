// It contains all our demo data that we used
final List<String> demoRestaurantNames = [
  "مطعم الدجاج المقلي الشهير",
  "مطعم الدجاج الكوري الأصيل",
  "مطعم الدجاج التقليدي",
  "مطعم الدجاج المميز",
  "مطعم الدجاج الشعبي",
  "مطعم الدجاج السريع"
  // Add more restaurant names here as needed
];

final Map<String, String> restaurantImages = {
  "مطعم الدجاج المقلي الشهير": "",
  "مطعم الدجاج الكوري الأصيل": "",
  "مطعم الدجاج التقليدي": "",
  "مطعم الدجاج المميز": "",
  "مطعم الدجاج الشعبي": ""
  // Add more restaurant names and images here as needed
};

List<String> demoBigImages = ["", "", "", "", "", "", "", "", ""];

List<Map<String, dynamic>> demoMediumCardData = [
  {
    "name": "مطعم الدجاج الكوري الأصيل",
    "image": "",
    "location": "الرياض، المملكة العربية السعودية",
    "rating": 8.6,
    "delivertTime": 20,
  },
  {
    "name": "مطعم الدجاج المقلي الشهير",
    "image": "",
    "location": "جدة، المملكة العربية السعودية",
    "rating": 9.1,
    "delivertTime": 35,
  },
  {
    "name": "مطعم الدجاج التقليدي",
    "image": "",
    "location": "الدمام، المملكة العربية السعودية",
    "rating": 7.3,
    "delivertTime": 25,
  },
  {
    "name": "مطعم الدجاج المميز",
    "image": "",
    "location": "الخبر، المملكة العربية السعودية",
    "rating": 8.4,
    "delivertTime": 30,
  },
  {
    "name": "مطعم الدجاج الشعبي",
    "image": "",
    "location": "الطائف، المملكة العربية السعودية",
    "rating": 9.5,
    "delivertTime": 15,
  }
];

final Map<String, List<Map<String, dynamic>>> restaurantMenu = {
  "مطعم الدجاج الكوري الأصيل": [
    {
      "name": "دجاج مقلي بالصلصة الكورية",
      "location": "الرياض، المملكة العربية السعودية",
      "image": "",
      "foodType": "دجاج مقلي",
      "price": 0,
      "priceRange": "ر.س ر.س",
    },
    {
      "name": "أرز بالدجاج",
      "location": "الرياض، المملكة العربية السعودية",
      "image": "",
      "foodType": "أرز بالدجاج",
      "price": 0,
      "priceRange": "ر.س ر.س",
    },
    // Add more menu items for "مطعم الدجاج الكوري الأصيل" here
  ],
  "مطعم الدجاج المقلي الشهير": [
    {
      "name": "دجاج مقلي شهير",
      "location": "جدة، المملكة العربية السعودية",
      "image": "",
      "foodType": "دجاج مقلي",
      "price": 0,
      "priceRange": "ر.س ر.س",
    },
    {
      "name": "أرز بالدجاج",
      "location": "جدة، المملكة العربية السعودية",
      "image": "",
      "foodType": "أرز بالدجاج",
      "price": 0,
      "priceRange": "ر.س ر.س",
    },
    // Add more menu items for "مطعم الدجاج المقلي الشهير" here
  ],
  // Add more restaurants and their menu items as needed
};
