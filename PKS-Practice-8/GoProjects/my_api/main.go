package main

import (
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

// Product представляет модель машины
type Product struct {
	ID          int     `json:"id"`
	Name        string  `json:"name"`
	Description string  `json:"description"`
	ImageURL    string  `json:"image_url"`
	Price       float64 `json:"price"`
}

// products - хранилище данных
var products = []Product{
	{ID: 1, Name: "Toyota Camry", Description: "Седан, 2023 года выпуска", ImageURL: "https://example.com/toyota.jpg", Price: 30000},
	{ID: 2, Name: "Honda Accord", Description: "Седан, 2022 года выпуска", ImageURL: "https://example.com/honda.jpg", Price: 28000},
}

// Middleware для обработки CORS
func enableCORS(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}
		next.ServeHTTP(w, r)
	})
}

// Получить список всех продуктов
func getProducts(w http.ResponseWriter, r *http.Request) {
    log.Println("Получен запрос на получение всех продуктов")
    w.Header().Set("Content-Type", "application/json")
    log.Printf("Отправляем данные: %+v", products)
    json.NewEncoder(w).Encode(products)
}


// Получить продукт по ID
func getProductByID(w http.ResponseWriter, r *http.Request) {
	log.Println("Получен запрос на получение продукта по ID")
	w.Header().Set("Content-Type", "application/json")
	params := mux.Vars(r)
	id, err := strconv.Atoi(params["id"])
	if err != nil {
		log.Printf("Ошибка преобразования ID: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Invalid ID")
		return
	}

	for _, item := range products {
		if item.ID == id {
			w.WriteHeader(http.StatusOK)
			json.NewEncoder(w).Encode(item)
			return
		}
	}
	log.Println("Продукт не найден")
	w.WriteHeader(http.StatusNotFound)
	json.NewEncoder(w).Encode("Product not found")
}

// Добавить новый продукт
func addProduct(w http.ResponseWriter, r *http.Request) {
	log.Println("Получен запрос на добавление нового продукта")
	w.Header().Set("Content-Type", "application/json")

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		log.Printf("Ошибка декодирования JSON: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Invalid request body")
		return
	}

	log.Printf("Добавляемый продукт: %+v", newProduct)

	newID := 1
	if len(products) > 0 {
		newID = products[len(products)-1].ID + 1
	}
	newProduct.ID = newID

	products = append(products, newProduct)
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(newProduct)
}

// Удалить продукт по ID
func deleteProduct(w http.ResponseWriter, r *http.Request) {
	log.Println("Получен запрос на удаление продукта")
	w.Header().Set("Content-Type", "application/json")
	params := mux.Vars(r)
	id, err := strconv.Atoi(params["id"])
	if err != nil {
		log.Printf("Ошибка преобразования ID: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Invalid ID")
		return
	}

	log.Printf("ID для удаления: %d", id)

	for i, item := range products {
		if item.ID == id {
			products = append(products[:i], products[i+1:]...)
			log.Println("Продукт успешно удалён")
			w.WriteHeader(http.StatusOK)
			json.NewEncoder(w).Encode("Product deleted")
			return
		}
	}
	log.Println("Продукт не найден")
	w.WriteHeader(http.StatusNotFound)
	json.NewEncoder(w).Encode("Product not found")
}

// Обновить продукт по ID
func updateProduct(w http.ResponseWriter, r *http.Request) {
	log.Println("Получен запрос на обновление продукта")
	w.Header().Set("Content-Type", "application/json")
	params := mux.Vars(r)
	id, err := strconv.Atoi(params["id"])
	if err != nil {
		log.Printf("Ошибка преобразования ID: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Invalid ID")
		return
	}

	for i, item := range products {
		if item.ID == id {
			var updatedProduct Product
			err := json.NewDecoder(r.Body).Decode(&updatedProduct)
			if err != nil {
				log.Printf("Ошибка декодирования JSON: %v", err)
				w.WriteHeader(http.StatusBadRequest)
				json.NewEncoder(w).Encode("Invalid request body")
				return
			}

			products[i] = updatedProduct
			products[i].ID = id // Сохраняем ID неизменным
			log.Printf("Продукт обновлён: %+v", products[i])
			w.WriteHeader(http.StatusOK)
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}
	log.Println("Продукт не найден")
	w.WriteHeader(http.StatusNotFound)
	json.NewEncoder(w).Encode("Product not found")
}

func main() {
	router := mux.NewRouter()

	// Регистрация маршрутов
	router.Use(enableCORS)
	router.HandleFunc("/products", getProducts).Methods("GET")
	router.HandleFunc("/products/{id}", getProductByID).Methods("GET")
	router.HandleFunc("/products", addProduct).Methods("POST")
	router.HandleFunc("/products/{id}", deleteProduct).Methods("DELETE")
	router.HandleFunc("/products/{id}", updateProduct).Methods("PUT")

	log.Println("Server running on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", router))
}
