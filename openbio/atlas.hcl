env "local" {  
  src = "schema.hcl"  
  url = "postgresql://assaya:assaya@18.230.122.5:5432/openbio_dev?sslmode=disable"  
  dev = "postgresql://assaya:assaya@18.230.122.5:5432/migrate?sslmode=disable"  
  schemas = ["public"]
  
	migration {  
	  dir = "file://migrations"  
	  format = atlas  
          revisions_schema = "public"
	}
}  
  
env "qa" {  
  src = "schema.hcl"  
  url = "postgresql://assaya:assaya@18.230.122.5:5432/openbio_qa?sslmode=disable"  
  dev = "postgresql://assaya:assaya@18.230.122.5:5432/migrate?sslmode=disable"  
  schemas = ["public"]  
  
      migration {
          revisions_schema = "public"
        }
} 
