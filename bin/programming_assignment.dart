import 'dart:io';

class Food {
  String name;
  double price;
  String ingredients;
  String description;

  Food(this.name, this.price, this.ingredients, this.description);
}

class Restaurant {
  String name = "Eleven Madison Park Restaurant";
  String brand = "Make It Nice";
  String location = "New York City, New York, USA";
  String website = "www.eleven-madison-park-restaurant.com";
}

class User {
  String name = '';
  String family = '';
  String email = '';
}

class ReservationSystem {
  Restaurant restaurant = Restaurant();
  User user = User();


  List<Food> menu = [
    Food("🍔 Burger", 10.99, "Beef patty, lettuce, tomato, cheese", "Delicious burger"),
    Food("🧇 Pizza", 12.99, "Tomato sauce, cheese, pepperoni", "Classic pizza"),
    Food("🍝 Pasta", 8.99, "Spaghetti, marinara sauce, meatballs", "Italian pasta"),
    Food("🥗 Salad", 6.99, "Mixed greens, cherry tomatoes, dressing", "Fresh salad"),
    Food("🧆 Steak", 16.99, "Grilled sirloin steak, mashed potatoes", "Juicy steak"),
    Food("🍱 Sushi", 14.99, "Rice, fish, seaweed", "Japanese sushi"),
    Food("🍗 Chicken Curry", 11.99, "Chicken, curry sauce, rice", "Spicy curry"),
    Food("🍰 Dessert", 5.99, "Chocolate cake, vanilla ice cream", "Sweet treat"),
  ];

  List<String> orders = [];
  String staffPassword = "password123"; // Change this to a secure password

  void displayWelcomeSpeech() {
    print("\x1B[32m\x1B[1m \t\t\t\t\t\tWelcome ${restaurant.name} to - ${restaurant.brand}!\x1B[0m");
  }

  void enterUserInfo() {
    stdout.write("Enter your name: ");
    user.name = stdin.readLineSync()!;

    stdout.write("Enter your family name: ");
    user.family = stdin.readLineSync()!;

    while (true) {
      stdout.write("Enter your email: ");
      user.email = stdin.readLineSync()!;

      if (user.email.contains("@gmail.com")) {
        break;
      } else {
        print("Please enter a valid Gmail address.");
      }
    }
  }

  void displayMenu() {
    print("\x1B[34m\n----- Menu 📃-----\x1B[0m");
    for (var i = 0; i < menu.length; i++) {
      print("${i + 1}. ${menu[i].name} - \$${menu[i].price}");
    }
  }

  void displayRestaurantInfo() {
    print("\x1B[33m\n----- Restaurant Info -----\x1B[0m");
    print("Name: ${restaurant.name}");
    print("Brand: ${restaurant.brand}");
    print("Location: ${restaurant.location}");
    print("Website: ${restaurant.website}");
  }

  void displayStaffMenu() {
    print("\x1B[38;5;208m\n----- Staff Menu -----\x1B[0m");
    print("1.👀 View Restaurant Menu");
    print("2.👁 View Ordered Orders");
    print("3.📝 Add Item to Menu");
    print("4.⚙️ Change Price of Item");
    print("5.🎼 Edit Item in Menu");
    print("6.🗑 Delete Item from Menu");
    print("7.🔕 Cancel Order");
    print("8.↖️ Exit Staff Section");
  }

  void run() {
    displayWelcomeSpeech();

    while (true) {
      print("\x1B[31m\n----- Main Menu -----\x1B[0m");
      print("1.📜Menu");
      print("2.📃Restaurant Info");
      print("3.👩‍🍳Staff");
      print("4.⬅️Exit");

      stdout.write("Enter your choice: ");
      var choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          enterUserInfo();
          handleMenu();
          break;
        case 2:
          displayRestaurantInfo();
          break;
        case 3:
          handleStaff();
          break;
        case 4:
          print("\x1B[33m\t\t\t\t\t\t👋Exiting the program. Goodbye!👋\x1B[0m");
          exit(0);
          break;
        default:
          print("Invalid choice. Please try again.");
      }
    }
  }


  void handleMenu() {
    while (true) {
      displayMenu();

      print("\n----- Menu Options -----");
      print("1. Order Food");
      print("2. Exit to Main Menu");

      stdout.write("Enter your choice: ");
      var choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          handleOrderFood();
          break;
        case 2:
          return;
        default:
          print("Invalid choice. Please try again.");
      }
    }
  }

  void handleOrderFood() {
    stdout.write("Enter the item numbers you want to order ");
    var itemNumbers = stdin.readLineSync()!
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();

    var totalCost = 0.0;

    for (var itemNumber in itemNumbers) {
      if (itemNumber >= 1 && itemNumber <= menu.length) {
        var food = menu[itemNumber - 1];
        stdout.write("Enter the quantity of ${food.name}: ");
        var quantity = int.parse(stdin.readLineSync()!);

        var itemCost = food.price * quantity;
        totalCost += itemCost;

        orders.add("${food.name} x$quantity - \$${itemCost.toStringAsFixed(2)}");
      } else {
        print("Invalid item number. Please try again.");
        return;
      }
    }

    print("Order placed successfully!");
    print("Total Cost: \$${totalCost.toStringAsFixed(2)}");

    stdout.write("Enter the number of people for the reservation: ");
    var numberOfPeople = int.parse(stdin.readLineSync()!);

    print("Reservation confirmed for $numberOfPeople people.");
  }

  void handleStaff() {
    stdout.write("Enter staff password 🔐:");
    var enteredPassword = stdin.readLineSync()!;

    if (enteredPassword == staffPassword) {
      while (true) {
        displayStaffMenu();

        stdout.write("Enter your choice: ");
        var staffChoice = int.parse(stdin.readLineSync()!);

        switch (staffChoice) {
          case 1:
            displayMenu();
            break;
          case 2:
            displayOrderedOrders();
            break;
          case 3:
            addItemToMenu();
            break;
          case 4:
            changePriceOfItem();
            break;
          case 5:
            editItemInMenu();
            break;
          case 6:
            deleteItemFromMenu();
            break;
          case 7:
            cancelOrder();
            break;
          case 8:
            print("Exiting Staff Section.");
            return;
          default:
            print("Invalid choice. Please try again.");
        }
      }
    } else {
      print("Incorrect password. Access denied.");
    }
  }

  void displayOrderedOrders() {
    print("\n----- Ordered Orders -----");
    print("Ordered by : ${user.name}");
    for (var order in orders) {
      print(order);
    }
  }

  void addItemToMenu() {
    stdout.write("Enter the name of the new item: ");
    var itemName = stdin.readLineSync()!;

    stdout.write("Enter the price of $itemName: ");
    var itemPrice = double.parse(stdin.readLineSync()!);

    stdout.write("Enter the ingredients of $itemName: ");
    var itemIngredients = stdin.readLineSync()!;

    stdout.write("Enter the description of $itemName: ");
    var itemDescription = stdin.readLineSync()!;

    menu.add(Food(itemName, itemPrice, itemIngredients, itemDescription));

    print("$itemName added to the menu successfully!");
  }

  void changePriceOfItem() {
    displayMenu();
    stdout.write("Enter the item number you want to change the price for: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu[itemNumber];
      stdout.write("Enter the new price for ${food.name}: ");
      var newPrice = double.parse(stdin.readLineSync()!);

      food.price = newPrice;

      print("Price for ${food.name} updated successfully!");
    } else {
      print("Invalid item number. Please try again.");
    }
  }

  void editItemInMenu() {
    displayMenu();
    stdout.write("Enter the item number you want to edit: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu[itemNumber];

      stdout.write("Enter the new name for ${food.name}: ");
      var newName = stdin.readLineSync()!;
      food.name = newName;

      stdout.write("Enter the new price for $newName: ");
      var newPrice = double.parse(stdin.readLineSync()!);
      food.price = newPrice;

      stdout.write("Enter the new ingredients for $newName: ");
      var newIngredients = stdin.readLineSync()!;
      food.ingredients = newIngredients;

      stdout.write("Enter the new description for $newName: ");
      var newDescription = stdin.readLineSync()!;
      food.description = newDescription;

      print("$newName updated in the menu successfully!");
    } else {
      print("Invalid item number. Please try again.");
    }
  }

  void deleteItemFromMenu() {
    displayMenu();
    stdout.write("Enter the item number you want to delete: ");
    var itemNumber = int.parse(stdin.readLineSync()!) - 1;

    if (itemNumber >= 0 && itemNumber < menu.length) {
      var food = menu.removeAt(itemNumber);

      print("${food.name} deleted from the menu successfully!");
    } else {
      print("Invalid item number. Please try again.");
    }
  }

  void cancelOrder() {
    displayOrderedOrders();
    stdout.write("Enter the order number you want to cancel: ");
    var orderNumber = int.parse(stdin.readLineSync()!) - 1;

    if (orderNumber >= 0 && orderNumber < orders.length) {
      var cancelledOrder = orders.removeAt(orderNumber);

      print("$cancelledOrder cancelled successfully!");
    } else {
      print("Invalid order number. Please try again.");
    }
  }
}

void main() {
  var reservationSystem = ReservationSystem();
  reservationSystem.run();
}
