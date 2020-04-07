CREATE TABLE "supermarkets" (
	"id" serial NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"longitude" serial NOT NULL,
	"latitude" serial NOT NULL,
	CONSTRAINT "supermarkets_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "has_product" (
	"fk_supermarket" integer NOT NULL,
	"fk_product" integer NOT NULL,
	"department" VARCHAR(50) NOT NULL,
	CONSTRAINT "has_product_pk" PRIMARY KEY ("fk_supermarket","fk_product")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "products" (
	"id" serial NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"price" DECIMAL NOT NULL,
	"barcode" VARCHAR(75) NOT NULL,
	"available" serial NOT NULL,
	"category" VARCHAR(50) NOT NULL,
	"discount" integer NOT NULL DEFAULT '0',
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "users" (
	"id" serial NOT NULL,
	"name" VARCHAR(25) NOT NULL,
	"last_name" VARCHAR(25) NOT NULL,
	"address" VARCHAR(100) NOT NULL,
	"birth_date" DATE NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "orders" (
	"fk_user" serial NOT NULL,
	"fk_order" integer NOT NULL,
	CONSTRAINT "orders_pk" PRIMARY KEY ("fk_user","fk_order")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "order" (
	"id" serial NOT NULL,
	"creation_date" TIMESTAMP NOT NULL,
	"pickup_time" TIMESTAMP NOT NULL,
	"amount" DECIMAL NOT NULL,
	"fk_supermarket" integer NOT NULL,
	CONSTRAINT "order_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "shopping_cart" (
	"fk_product" integer NOT NULL,
	"fk_order" integer NOT NULL,
	"quantity" integer NOT NULL,
	CONSTRAINT "shopping_cart_pk" PRIMARY KEY ("fk_product","fk_order","quantity")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "credentials" (
	"fk_user" integer NOT NULL,
	"hashed_password" VARCHAR(60) NOT NULL,
	"mail" VARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT "credentials_pk" PRIMARY KEY ("fk_user")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "has_product" ADD CONSTRAINT "has_product_fk0" FOREIGN KEY ("fk_supermarket") REFERENCES "supermarkets"("id");
ALTER TABLE "has_product" ADD CONSTRAINT "has_product_fk1" FOREIGN KEY ("fk_product") REFERENCES "products"("id");



ALTER TABLE "orders" ADD CONSTRAINT "orders_fk0" FOREIGN KEY ("fk_user") REFERENCES "users"("id");
ALTER TABLE "orders" ADD CONSTRAINT "orders_fk1" FOREIGN KEY ("fk_order") REFERENCES "order"("id");

ALTER TABLE "order" ADD CONSTRAINT "order_fk0" FOREIGN KEY ("fk_supermarket") REFERENCES "supermarkets"("id");

ALTER TABLE "shopping_cart" ADD CONSTRAINT "shopping_cart_fk0" FOREIGN KEY ("fk_product") REFERENCES "products"("id");
ALTER TABLE "shopping_cart" ADD CONSTRAINT "shopping_cart_fk1" FOREIGN KEY ("fk_order") REFERENCES "order"("id");

ALTER TABLE "credentials" ADD CONSTRAINT "credentials_fk0" FOREIGN KEY ("fk_user") REFERENCES "users"("id");
