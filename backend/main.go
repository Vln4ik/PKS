package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

type Product struct {
	ID          int
	ImageURL    string
	Name        string
	Description string
	Price       float64
	Features    string
	IsFavourite bool
	IsInCart    bool
	Quantity    int
}

type User struct {
	ID    int
	Image string
	Name  string
	Phone string
	Mail  string
}

// Список продуктов
var products = []Product{{
	ID:          0,
	ImageURL:    "https://avatars.mds.yandex.net/get-autoru-vos/11396317/fe2caa240a0eed8a0a9654f8d62e1c5b/832x624",
	Name:        "BMW X5 30d, 2024",
	Description: "Автосалон премиальных автомобилей IMPERIUM MOTORS – это место, где встречаются элегантность, мощь и инновации. ",
	Features:    "Черный полный привод",
	Price:       2000000,
	IsFavourite: false,
	IsInCart:    false,
	Quantity:    0,
},
	{
		ID:          1,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X5",
		Description: "Белый кроссовер",
		Features:    "Белый, полныцй привод",
		Price:       4000000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          2,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X5",
		Description: "Белый кроссовер",
		Features:    "Белый, полныцй привод",
		Price:       5000000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          3,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X5",
		Description: "Белый кроссовер",
		Features:    "Белый, полныцй привод",
		Price:       6000000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          4,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X5",
		Description: "Белый кроссовер",
		Features:    "Белый, полныцй привод",
		Price:       7000000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          5,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X5",
		Description: "Белый кроссовер",
		Features:    "Белый, полныцй привод",
		Price:       8000000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          6,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X5",
		Description: "Белый кроссовер",
		Features:    "Белый, полныцй привод",
		Price:       9000000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          7,
		ImageURL:    "https://i.pinimg.com/736x/a3/17/e9/a317e9d9503b8382b3c68c1ca8fc1e77.jpg",
		Name:        "BMW X7",
		Description: "Белый кроссовер",
		Features:    "Белый кроссовер",
		Price:       100000,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	}}

var users = []User{{
	ID:    1,
	Image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAd5avdba8EiOZH8lmV3XshrXx7dKRZvhx-A&s",
	Name:  "Харабрин Кирилл",
	Mail:  "example@mail.ru",
	Phone: "777777777",
}}

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)
	var lastID int = len(products)

	for _, productItem := range products {
		if productItem.ID > lastID {
			lastID = productItem.ID
		}
	}
	newProduct.ID = lastID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

//Добавление маршрута для получения одного продукта

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {
			products[i].Name = updatedProduct.Name
			products[i].ImageURL = updatedProduct.ImageURL
			products[i].Price = updatedProduct.Price
			products[i].Features = updatedProduct.Features
			products[i].Description = updatedProduct.Description
			products[i].IsFavourite = updatedProduct.IsFavourite
			products[i].IsInCart = updatedProduct.IsInCart
			products[i].Quantity = updatedProduct.Quantity

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func getCartHandler(w http.ResponseWriter, r *http.Request) {

	if r.Method != http.MethodGet {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	var cartProducts = []Product{}

	for _, Product := range products {
		if Product.IsInCart == true {
			w.Header().Set("Content-Type", "application/json")
			cartProducts = append(cartProducts, Product)
		}
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(cartProducts)
}
func getFavoritesHandler(w http.ResponseWriter, r *http.Request) {

	// Преобразуем список заметок в JSON
	var favoriteProducts = []Product{}

	for _, Product := range products {
		if Product.IsFavourite == true {
			w.Header().Set("Content-Type", "application/json")
			favoriteProducts = append(favoriteProducts, Product)
		}
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(favoriteProducts)
}

func getUserByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Users/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, user := range users {
		if user.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(user)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func updateUserHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/users/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedUser User
	err = json.NewDecoder(r.Body).Decode(&updatedUser)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем пользователя для обновления
	for i, user := range users {
		if user.ID == id {
			users[i].Name = updatedUser.Name
			users[i].Image = updatedUser.Image
			users[i].Phone = updatedUser.Phone
			users[i].Mail = updatedUser.Mail

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)           // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)  // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)       // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler) // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler) // Удалить продукт

	http.HandleFunc("/cart", getCartHandler)             // Получить все продукты в корзине
	http.HandleFunc("/favourites", getFavoritesHandler)  // Получить избранные продукты
	http.HandleFunc("/users/", getUserByIDHandler)       // получить данные пользователя
	http.HandleFunc("/users/update/", updateUserHandler) // обновить данные пользователя

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}
