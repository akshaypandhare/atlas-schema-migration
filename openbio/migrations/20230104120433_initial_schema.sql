-- create "comments" table
CREATE TABLE "public"."comments" ("id" bigserial NOT NULL, "post_id" bigint NOT NULL, "user_id" bigint NOT NULL, "body" character varying NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
