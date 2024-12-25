package db

import (
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"

)

func ConnectDB() (*sqlx.DB, error) {

<<<<<<< Updated upstream
	dsn := "port=5432 user=postgres password=Pfobnf1982 dbname=shop sslmode=disable"
=======
	dsn := "host=localhost port=5432 user=postgres password=12345 dbname=shop sslmode=disable"
>>>>>>> Stashed changes

	db, err := sqlx.Connect("postgres", dsn)
	if err != nil {
		return nil, err
	}
	return db, nil

}







