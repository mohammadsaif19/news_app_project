// ignore_for_file: non_constant_identifier_names, constant_identifier_names

const String API_KEY = "f3f4e0ecf8ac4c9abbbc2735ed68f58f";

final Uri NEWS_API = Uri.parse(
    "https://newsapi.org/v2/everything?q=apple&from=2022-04-01&to=2022-04-05&sortBy=popularity&pageSize=100&apiKey=$API_KEY");
