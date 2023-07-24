package services

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"

	"gorm.io/gorm/schema"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

const valName = "DB_CONNECTION"

type DbConnectionMiddleware struct {
	db *gorm.DB
}

func New() (*gorm.DB, error) {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	user := os.Getenv("POSTGRES_USER")
	password := os.Getenv("POSTGRES_PASSWORD")
	// host := os.Getenv("POSTGRES_HOST")
	host := "postgres"
	port := os.Getenv("POSTGRES_PORT")
	dbname := os.Getenv("POSTGRES_DB")
	sslmode := os.Getenv("POSTGRES_SSLMODE")

	dsn := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=%s", user, password, host, port, dbname, sslmode)
	fmt.Printf("Connecting to database : %v", dsn)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Warn),
		NowFunc: func() time.Time {
			utc, _ := time.LoadLocation("UTC")
			return time.Now().In(utc).Truncate(time.Microsecond)
		},
		NamingStrategy: schema.NamingStrategy{
			SingularTable: true, // use singular table name, table for `User` would be `user` with this option enabled
		},
	})

	if err != nil {
		panic(err.Error())
	}

	if err != nil {
		fmt.Printf("%v", err)
		fmt.Println("Retry database connection in 5 seconds... ")
		time.Sleep(time.Duration(5) * time.Second)
		return New()
	}
	fmt.Println("Database is connected")
	return db, nil
}

func (fam *DbConnectionMiddleware) MiddlewareFunc() gin.HandlerFunc {
	return func(c *gin.Context) {
		if fam.db == nil {
			c.JSON(http.StatusUnauthorized, gin.H{
				"status":  http.StatusInternalServerError,
				"message": http.StatusText(http.StatusInternalServerError),
			})
			c.Abort()
			return
		}
		c.Set(valName, fam.db)
		c.Next()
	}
}

func GetDB(c *gin.Context) *gorm.DB {
	dbConnection, ok := c.Get(valName)
	if !ok {
		panic(fmt.Errorf("Error connecting database"))
	}
	return dbConnection.(*gorm.DB)
}

func GinContextFromContext(ctx context.Context) (*gin.Context, error) {
	ginContext := ctx.Value(valName)
	if ginContext == nil {
		err := fmt.Errorf("could not retrieve gin.Context")
		return nil, err
	}

	gc, ok := ginContext.(*gin.Context)
	if !ok {
		err := fmt.Errorf("gin.Context has wrong type")
		return nil, err
	}
	return gc, nil
}
