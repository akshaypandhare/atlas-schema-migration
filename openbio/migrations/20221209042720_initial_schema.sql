-- create "mobile_applications" table
CREATE TABLE "public"."mobile_applications" ("id" bigserial NOT NULL, "token" character varying NOT NULL, PRIMARY KEY ("id"));
-- create "api_keys" table
CREATE TABLE "public"."api_keys" ("id" serial NOT NULL, "resource_type" character varying NOT NULL, "resource_id" bigint NOT NULL, "key" character varying NOT NULL, "description" character varying NULL, PRIMARY KEY ("id"));
-- create "mobile_application_attributes" table
CREATE TABLE "public"."mobile_application_attributes" ("property" character varying NOT NULL, "value" character varying NOT NULL, PRIMARY KEY ("property"));
-- create "device_attributes" table
CREATE TABLE "public"."device_attributes" ("latest_version" character varying NULL, "latest_config" character varying NULL);
-- create "devices" table
CREATE TABLE "public"."devices" ("id" bigserial NOT NULL, "serial" character varying NOT NULL, "nickname" character varying NULL, "observed" timestamptz NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"));
-- create "device_functional_tests" table
CREATE TABLE "public"."device_functional_tests" ("device_id" bigint NOT NULL, "test_result_id" bigint NOT NULL, PRIMARY KEY ("device_id", "test_result_id"));
-- create "mac_addresses" table
CREATE TABLE "public"."mac_addresses" ("id" bigserial NOT NULL, "mac_addressable_type" character varying NOT NULL, "mac_addressable_id" bigint NOT NULL, "address" character varying NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"));
-- create index "mac_addresses_address_key" to table: "mac_addresses"
CREATE UNIQUE INDEX "mac_addresses_address_key" ON "public"."mac_addresses" ("address");
-- create "device_histories" table
CREATE TABLE "public"."device_histories" ("id" bigserial NOT NULL, "device_id" bigint NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "device_histories_device_id_fkey" FOREIGN KEY ("device_id") REFERENCES "public"."devices" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_standards" table
CREATE TABLE "public"."test_standards" ("id" smallserial NOT NULL, "barcode" character varying NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"));
-- create "test_classes" table
CREATE TABLE "public"."test_classes" ("id" smallserial NOT NULL, "test_standard_id" smallint NOT NULL, "barcode" character varying NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_classes_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_manufacturers" table
CREATE TABLE "public"."test_manufacturers" ("id" smallserial NOT NULL, "test_standard_id" smallint NOT NULL, "barcode" character varying NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_manufacturers_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_technologies" table
CREATE TABLE "public"."test_technologies" ("id" smallserial NOT NULL, "test_standard_id" smallint NOT NULL, "barcode" character varying NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_technologies_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_types" table
CREATE TABLE "public"."test_types" ("id" smallserial NOT NULL, "test_standard_id" smallint NOT NULL, "barcode" character varying NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_types_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_versions" table
CREATE TABLE "public"."test_versions" ("id" smallserial NOT NULL, "test_standard_id" smallint NOT NULL, "barcode" character varying NOT NULL, "name" character varying NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_versions_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_profiles" table
CREATE TABLE "public"."test_profiles" ("id" bigserial NOT NULL, "barcode" character varying NOT NULL, "test_standard_id" smallint NOT NULL, "test_technology_id" smallint NULL, "test_manufacturer_id" smallint NOT NULL, "test_type_id" smallint NOT NULL, "test_class_id" smallint NULL, "test_version_id" smallint NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_profiles_test_class_id_fkey" FOREIGN KEY ("test_class_id") REFERENCES "public"."test_classes" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_profiles_test_manufacturer_id_fkey" FOREIGN KEY ("test_manufacturer_id") REFERENCES "public"."test_manufacturers" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_profiles_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_profiles_test_technology_id_fkey" FOREIGN KEY ("test_technology_id") REFERENCES "public"."test_technologies" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_profiles_test_type_id_fkey" FOREIGN KEY ("test_type_id") REFERENCES "public"."test_types" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_profiles_test_version_id_fkey" FOREIGN KEY ("test_version_id") REFERENCES "public"."test_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_profile_versions" table
CREATE TABLE "public"."test_profile_versions" ("id" bigserial NOT NULL, "test_profile_id" bigint NOT NULL, "led" character varying NOT NULL, "max_right" integer NOT NULL, "status" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_profile_versions_test_profile_id_fkey" FOREIGN KEY ("test_profile_id") REFERENCES "public"."test_profiles" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_results" table
CREATE TABLE "public"."test_results" ("id" bigserial NOT NULL, "test_profile_version_id" bigint NOT NULL, "barcode" character varying NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "test_results_test_profile_version_id_fkey" FOREIGN KEY ("test_profile_version_id") REFERENCES "public"."test_profile_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_result_histories" table
CREATE TABLE "public"."test_result_histories" ("id" bigserial NOT NULL, "test_result_id" bigint NOT NULL, "device_history_id" bigint NOT NULL, "status" character varying NOT NULL, "visual_status" character varying NULL, "centerline_start_x" integer NOT NULL, "centerline_end_x" integer NOT NULL, "centerline_start_y" integer NOT NULL, "centerline_end_y" integer NOT NULL, "temperature" numeric NULL, "humidity" numeric NULL, "note" character varying NULL, "sampled" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_result_histories_device_history_id_fkey" FOREIGN KEY ("device_history_id") REFERENCES "public"."device_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_result_histories_test_result_id_fkey" FOREIGN KEY ("test_result_id") REFERENCES "public"."test_results" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organizations" table
CREATE TABLE "public"."organizations" ("id" bigserial NOT NULL, "name" character varying NOT NULL, "timezone" character varying NOT NULL DEFAULT 'Etc/UTC', "notification_images" boolean NOT NULL DEFAULT false, "parent_id" bigint NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"));
-- create "users" table
CREATE TABLE "public"."users" ("id" bigserial NOT NULL, "username" character varying NOT NULL, "email" character varying NOT NULL, "name" character varying NOT NULL, "timezone" character varying NOT NULL DEFAULT 'Etc/UTC', "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"));
-- create "organization_invitations" table
CREATE TABLE "public"."organization_invitations" ("id" bigserial NOT NULL, "organization_id" bigint NOT NULL, "sender_id" bigint NOT NULL, "email" character varying NOT NULL, "token" character varying NOT NULL, "roles" character varying NULL, "start" timestamptz NULL, "finish" timestamptz NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, "expires" timestamptz NOT NULL DEFAULT (CURRENT_TIMESTAMP + '1 day'::interval), "accepted" timestamptz NULL, PRIMARY KEY ("id"), CONSTRAINT "organization_invitations_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "organization_invitations_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "public"."users" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organization_notification_types" table
CREATE TABLE "public"."organization_notification_types" ("id" smallserial NOT NULL, "category" character varying NOT NULL, "type" character varying NOT NULL, "name" character varying NOT NULL, "description" character varying NOT NULL, "subject" character varying NOT NULL, "body" character varying NOT NULL, PRIMARY KEY ("id"));
-- create "organization_notification_emails" table
CREATE TABLE "public"."organization_notification_emails" ("id" bigserial NOT NULL, "organization_id" bigint NOT NULL, "notification_type_id" smallint NOT NULL, "notification_images" boolean NOT NULL DEFAULT false, "email" character varying NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "organization_notification_emails_notification_type_id_fkey" FOREIGN KEY ("notification_type_id") REFERENCES "public"."organization_notification_types" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "organization_notification_emails_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_profile_bars" table
CREATE TABLE "public"."test_profile_bars" ("id" bigserial NOT NULL, "test_profile_version_id" bigint NOT NULL, "name" character varying NOT NULL, "operator" character varying NULL, "h" integer NOT NULL, "threshold" integer NOT NULL, "w" integer NOT NULL, "x" integer NOT NULL, "y" integer NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "test_profile_bars_test_profile_version_id_fkey" FOREIGN KEY ("test_profile_version_id") REFERENCES "public"."test_profile_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_profile_bar_evs" table
CREATE TABLE "public"."test_profile_bar_evs" ("id" bigserial NOT NULL, "test_profile_bar_id" bigint NOT NULL, "name" character varying NOT NULL, "unit" character varying NOT NULL, "decimals" smallint NOT NULL, "args" json NULL, PRIMARY KEY ("id"), CONSTRAINT "test_profile_bar_evs_test_profile_bar_id_fkey" FOREIGN KEY ("test_profile_bar_id") REFERENCES "public"."test_profile_bars" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_result_bars" table
CREATE TABLE "public"."test_result_bars" ("id" bigserial NOT NULL, "test_result_history_id" bigint NOT NULL, "test_profile_bar_id" bigint NOT NULL, "image" character varying NOT NULL, "value" numeric NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "test_result_bars_test_profile_bar_id_fkey" FOREIGN KEY ("test_profile_bar_id") REFERENCES "public"."test_profile_bars" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "test_result_bars_test_result_history_id_fkey" FOREIGN KEY ("test_result_history_id") REFERENCES "public"."test_result_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "device_led_boards" table
CREATE TABLE "public"."device_led_boards" ("id" bigserial NOT NULL, "device_history_id" bigint NOT NULL, "firmware" character varying NOT NULL, "serial" character varying NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "device_led_boards_device_history_id_fkey" FOREIGN KEY ("device_history_id") REFERENCES "public"."device_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "device_things" table
CREATE TABLE "public"."device_things" ("id" bigserial NOT NULL, "device_history_id" bigint NOT NULL, "name" character varying NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "device_things_device_history_id_fkey" FOREIGN KEY ("device_history_id") REFERENCES "public"."device_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "countries" table
CREATE TABLE "public"."countries" ("id" smallserial NOT NULL, "alpha2" character varying NOT NULL, "alpha3" character varying NOT NULL, "name" character varying NOT NULL, PRIMARY KEY ("id"));
-- create index "countries_alpha2_key" to table: "countries"
CREATE UNIQUE INDEX "countries_alpha2_key" ON "public"."countries" ("alpha2");
-- create index "countries_alpha3_key" to table: "countries"
CREATE UNIQUE INDEX "countries_alpha3_key" ON "public"."countries" ("alpha3");
-- create "locations" table
CREATE TABLE "public"."locations" ("id" bigserial NOT NULL, "locatable_type" character varying NOT NULL, "locatable_id" bigint NOT NULL, "country_id" smallint NULL, "ip" character varying NULL, "latitude" numeric NULL, "longitude" numeric NULL, "timezone" character varying NULL, "city" character varying NULL, "region_name" character varying NULL, "region_code" character varying NULL, "post_code" character varying NULL, "area_code" character varying NULL, PRIMARY KEY ("id"), CONSTRAINT "locations_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "public"."countries" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "roles" table
CREATE TABLE "public"."roles" ("id" smallserial NOT NULL, "key" character varying NOT NULL, "name" character varying NOT NULL, "description" character varying NOT NULL, PRIMARY KEY ("id"));
-- create index "roles_key_key" to table: "roles"
CREATE UNIQUE INDEX "roles_key_key" ON "public"."roles" ("key");
-- create "resource_roles" table
CREATE TABLE "public"."resource_roles" ("id" bigserial NOT NULL, "resource_type" character varying NOT NULL, "resource_id" bigint NOT NULL, "role_id" smallint NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "resource_roles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."roles" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organization_user_roles" table
CREATE TABLE "public"."organization_user_roles" ("id" bigserial NOT NULL, "organization_id" bigint NOT NULL, "resource_role_id" bigint NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "organization_user_roles_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "organization_user_roles_resource_role_id_fkey" FOREIGN KEY ("resource_role_id") REFERENCES "public"."resource_roles" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_result_scans" table
CREATE TABLE "public"."test_result_scans" ("id" bigserial NOT NULL, "test_result_history_id" bigint NOT NULL, "type" character varying NOT NULL, "data" json NOT NULL, "scanned" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "test_result_scans_test_result_history_id_fkey" FOREIGN KEY ("test_result_history_id") REFERENCES "public"."test_result_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_standard_components" table
CREATE TABLE "public"."test_standard_components" ("id" smallserial NOT NULL, "test_standard_id" smallint NOT NULL, "name" character varying NOT NULL, "description" character varying NOT NULL, "length" smallint NOT NULL, "position" smallint NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "test_standard_components_test_standard_id_fkey" FOREIGN KEY ("test_standard_id") REFERENCES "public"."test_standards" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_result_bar_evs" table
CREATE TABLE "public"."test_result_bar_evs" ("id" bigserial NOT NULL, "test_result_bar_id" bigint NULL, "result" numeric NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "test_result_bar_evs_test_result_bar_id_fkey" FOREIGN KEY ("test_result_bar_id") REFERENCES "public"."test_result_bars" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "device_software" table
CREATE TABLE "public"."device_software" ("id" bigserial NOT NULL, "device_history_id" bigint NOT NULL, "version" character varying NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "device_software_device_history_id_fkey" FOREIGN KEY ("device_history_id") REFERENCES "public"."device_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organization_notification_templates" table
CREATE TABLE "public"."organization_notification_templates" ("id" bigserial NOT NULL, "organization_id" bigint NOT NULL, "notification_type_id" smallint NOT NULL, "subject" character varying NOT NULL, "body" text NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "organization_notification_templates_notification_type_id_fkey" FOREIGN KEY ("notification_type_id") REFERENCES "public"."organization_notification_types" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "organization_notification_templates_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organization_test_results" table
CREATE TABLE "public"."organization_test_results" ("organization_id" bigint NULL, "test_result_id" bigint NULL, CONSTRAINT "organization_test_results_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "organization_test_results_test_result_id_fkey" FOREIGN KEY ("test_result_id") REFERENCES "public"."test_results" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "access_schedules" table
CREATE TABLE "public"."access_schedules" ("id" bigserial NOT NULL, "organization_id" bigint NOT NULL, "resource_type" character varying NOT NULL, "resource_id" bigint NOT NULL, "start" timestamptz NULL, "finish" timestamptz NULL, PRIMARY KEY ("id"), CONSTRAINT "access_schedules_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "device_logs" table
CREATE TABLE "public"."device_logs" ("id" bigserial NOT NULL, "device_id" bigint NOT NULL, "software" character varying NOT NULL, "content" character varying NOT NULL, "created" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "device_logs_device_id_fkey" FOREIGN KEY ("device_id") REFERENCES "public"."devices" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organization_identity_providers" table
CREATE TABLE "public"."organization_identity_providers" ("id" smallserial NOT NULL, "organization_id" bigint NOT NULL, "provider_name" character varying NOT NULL, "metadata_file" character varying NOT NULL, "metadata_url" character varying NOT NULL, "attributes" json NOT NULL, "idp_identifier" json NULL, PRIMARY KEY ("id"), CONSTRAINT "organization_identity_providers_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "device_drives" table
CREATE TABLE "public"."device_drives" ("id" bigserial NOT NULL, "device_history_id" bigint NOT NULL, "serial" character varying NOT NULL, "registered" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "device_drives_device_history_id_fkey" FOREIGN KEY ("device_history_id") REFERENCES "public"."device_histories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "organization_devices" table
CREATE TABLE "public"."organization_devices" ("organization_id" bigint NOT NULL, "device_id" bigint NOT NULL, CONSTRAINT "organization_devices_device_id_fkey" FOREIGN KEY ("device_id") REFERENCES "public"."devices" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "organization_devices_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- create "test_result_bar_samples" table
CREATE TABLE "public"."test_result_bar_samples" ("id" bigserial NOT NULL, "test_result_bar_id" bigint NULL, "value" numeric NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "test_result_bar_samples_test_result_bar_id_fkey" FOREIGN KEY ("test_result_bar_id") REFERENCES "public"."test_result_bars" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);