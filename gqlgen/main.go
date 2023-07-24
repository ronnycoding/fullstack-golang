package main

import (
	"fmt"
	"go/types"
	"os"

	"gorm.io/gen"

	dbService "github.com/ronnycoding/shipeasecommerce/services/db/connection"
	"github.com/ronnycoding/shipeasecommerce/utils"

	"github.com/99designs/gqlgen/api"
	"github.com/99designs/gqlgen/codegen/config"

	"github.com/99designs/gqlgen/plugin/modelgen"
	"github.com/joho/godotenv"
)

// Defining mutation function
func mutateHook(b *modelgen.ModelBuild) *modelgen.ModelBuild {
	primaryKeys := []string{"Post", "Role", "User", "Model", "Brand"}
	
	for _, model := range b.Models {		
		// for _, field := range model.Fields {
		// 	if utils.Contains(primaryKeys, model.Name) && field.Name == "id" {
		// 		field.Tag += ` gorm:"primaryKey" `
		// 		field.GoName = "ID"
		// 		field.Type = types.Typ[types.Int]
		// 	}

		// 	// gorm:"foreignKey:UserRefer"
			
		// 	if model.Name == "User" && field.Name == "roles" {
		// 		field.Tag += ` gorm:"many2many:user_role;" `
		// 	}
		// 	if model.Name == "User" && field.Name == "posts" || model.Name == "Post" && field.Name == "users" {
		// 		field.Tag += ` gorm:"many2many:user_post;" `
		// 	}
		// 	if model.Name == "Role" && field.Name == "name" || model.Name == "User" && field.Name == "uid" || model.Name == "User" && field.Name == "email" || model.Name == "Media" && field.Name == "source_url" {
		// 		field.Tag += ` gorm:"index,unique" `
		// 	}
		// 	if model.Name == "Brand" && field.Name == "models" {
		// 		field.Tag += ` gorm:"foreignKey:BrandID" `
		// 	}

		// 	if model.Name == "Post" && field.Name == "author" {
		// 		field.Tag += ` gorm:"foreignKey:ModelID" `
		// 	}
		// 	if model.Name == "Post" && field.Name == "media" {
		// 		field.Tag += ` gorm:"foreignKey:PostID" `
		// 	}
		// }

		// if model.Name == "Post" {
		// 	model.Fields = append(model.Fields, &modelgen.Field{
		// 		Name: "modelID",
		// 		Type: types.Typ[types.Int],
		// 		GoName: "ModelID",
		// 		Tag: `json:"modelID" gorm:"column:model_id"`,
		// 	})

		// 	model.Fields = append(model.Fields, &modelgen.Field{
		// 		Name: "brandID",
		// 		Type: types.Typ[types.Int],
		// 		GoName: "BrandID",
		// 		Tag: `json:"brandID" gorm:"column:brand_id"`,
		// 	})

		// 	model.Fields = append(model.Fields, &modelgen.Field{
		// 		Name: "authorID",
		// 		Type: types.Typ[types.Int],
		// 		GoName: "AuthorID",
		// 		Tag: `json:"authorID" gorm:"column:author_id"`,
		// 	})
		// }

		// if model.Name == "Model" {
		// 	model.Fields = append(model.Fields, &modelgen.Field{
		// 		Name: "brandID",
		// 		Type: types.Typ[types.Int],
		// 		GoName: "BrandID",
		// 		Tag: `json:"brandID" gorm:"column:brand_id"`,
		// 	})
		// }
	}

	return b
}

func main() {
	godotenv.Load()
	db, err := dbService.New()
	if err != nil {
		panic(err)
	}
	// NOTE: migration is being handle by goose
	// db.Migrator().CreateTable(&model.User{}, &model.Role{})
	p := modelgen.Plugin{
		MutateHook: mutateHook,
	}
	cfg, err := config.LoadConfigFromDefaultLocations()
	if err != nil {
		fmt.Fprintln(os.Stderr, "failed to load config", err.Error())
		os.Exit(2)
	}
	err = api.Generate(cfg, api.ReplacePlugin(&p))
	if err != nil {
		fmt.Fprintln(os.Stderr, err.Error())
		os.Exit(3)
	}
	g := gen.NewGenerator(gen.Config{
		OutPath: "./query",
		Mode: gen.WithoutContext|gen.WithDefaultQuery|gen.WithQueryInterface, // generate mode
	})
	// gen.WithDefaultQuery|gen.WithQueryInterface
	g.UseDB(db)
	// g.ApplyBasic(&model.User{}, &model.Role{})
	g.Execute()
}
