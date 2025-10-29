postgres:
	docker run --name postgres-14 -p 5436:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	docker exec -it postgres-14 createdb --username=root --owner=root simple_bank

startpsql:
	docker start postgres-14

stoppsql:
	docker stop postgres-14

dropdb:
	docker exec -it postgres-14 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5436/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5436/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/yerlan/simplebank/db/sqlc Store

.PHONY: postgres startpsql stoppsql createdb dropdb migrateup migratedown sqlc test server mock