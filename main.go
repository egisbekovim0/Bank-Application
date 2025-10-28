package main

import (
	"context"
	"log"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/yerlan/simplebank/api"
	db "github.com/yerlan/simplebank/db/sqlc"
)

const (
	dbSource = "postgresql://root:secret@localhost:5436/simple_bank?sslmode=disable"
	serverAddress = "0.0.0.0:8080"
)

var conn *pgxpool.Pool

func main() {
	ctx := context.Background()
	var err error 

	conn, err = pgxpool.New(ctx, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}