table "access_schedules" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "organization_id" {
    null = false
    type = bigint
  }
  column "resource_type" {
    null = false
    type = character_varying
  }
  column "resource_id" {
    null = false
    type = bigint
  }
  column "start" {
    null = true
    type = timestamptz
  }
  column "finish" {
    null = true
    type = timestamptz
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "access_schedules_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "api_keys" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "resource_type" {
    null = false
    type = character_varying
  }
  column "resource_id" {
    null = false
    type = bigint
  }
  column "key" {
    null = false
    type = character_varying
  }
  column "description" {
    null = true
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
}
table "countries" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "alpha2" {
    null = false
    type = character_varying
  }
  column "alpha3" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
  index "countries_alpha2_key" {
    unique  = true
    columns = [column.alpha2]
  }
  index "countries_alpha3_key" {
    unique  = true
    columns = [column.alpha3]
  }
}
table "device_attributes" {
  schema = schema.public
  column "latest_version" {
    null = true
    type = character_varying
  }
  column "latest_config" {
    null = true
    type = character_varying
  }
}
table "device_drives" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "device_history_id" {
    null = false
    type = bigint
  }
  column "serial" {
    null = false
    type = character_varying
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "device_drives_device_history_id_fkey" {
    columns     = [column.device_history_id]
    ref_columns = [table.device_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "device_functional_tests" {
  schema = schema.public
  column "device_id" {
    null = false
    type = bigint
  }
  column "test_result_id" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.device_id, column.test_result_id]
  }
}
table "device_histories" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "device_id" {
    null = false
    type = bigint
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "device_histories_device_id_fkey" {
    columns     = [column.device_id]
    ref_columns = [table.devices.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "device_led_boards" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "device_history_id" {
    null = false
    type = bigint
  }
  column "firmware" {
    null = false
    type = character_varying
  }
  column "serial" {
    null = false
    type = character_varying
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "device_led_boards_device_history_id_fkey" {
    columns     = [column.device_history_id]
    ref_columns = [table.device_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "device_logs" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "device_id" {
    null = false
    type = bigint
  }
  column "software" {
    null = false
    type = character_varying
  }
  column "content" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "device_logs_device_id_fkey" {
    columns     = [column.device_id]
    ref_columns = [table.devices.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "device_software" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "device_history_id" {
    null = false
    type = bigint
  }
  column "version" {
    null = false
    type = character_varying
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "device_software_device_history_id_fkey" {
    columns     = [column.device_history_id]
    ref_columns = [table.device_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "device_things" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "device_history_id" {
    null = false
    type = bigint
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "device_things_device_history_id_fkey" {
    columns     = [column.device_history_id]
    ref_columns = [table.device_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "devices" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "serial" {
    null = false
    type = character_varying
  }
  column "nickname" {
    null = true
    type = character_varying
  }
  column "observed" {
    null = false
    type = timestamptz
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "locations" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "locatable_type" {
    null = false
    type = character_varying
  }
  column "locatable_id" {
    null = false
    type = bigint
  }
  column "country_id" {
    null = true
    type = smallint
  }
  column "ip" {
    null = true
    type = character_varying
  }
  column "latitude" {
    null = true
    type = numeric
  }
  column "longitude" {
    null = true
    type = numeric
  }
  column "timezone" {
    null = true
    type = character_varying
  }
  column "city" {
    null = true
    type = character_varying
  }
  column "region_name" {
    null = true
    type = character_varying
  }
  column "region_code" {
    null = true
    type = character_varying
  }
  column "post_code" {
    null = true
    type = character_varying
  }
  column "area_code" {
    null = true
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "locations_country_id_fkey" {
    columns     = [column.country_id]
    ref_columns = [table.countries.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "mac_addresses" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "mac_addressable_type" {
    null = false
    type = character_varying
  }
  column "mac_addressable_id" {
    null = false
    type = bigint
  }
  column "address" {
    null = false
    type = character_varying
  }
  column "registered" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  index "mac_addresses_address_key" {
    unique  = true
    columns = [column.address]
  }
}
table "mobile_application_attributes" {
  schema = schema.public
  column "property" {
    null = false
    type = character_varying
  }
  column "value" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.property]
  }
}
table "mobile_applications" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "token" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
}
table "organization_devices" {
  schema = schema.public
  column "organization_id" {
    null = false
    type = bigint
  }
  column "device_id" {
    null = false
    type = bigint
  }
  foreign_key "organization_devices_device_id_fkey" {
    columns     = [column.device_id]
    ref_columns = [table.devices.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "organization_devices_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organization_identity_providers" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "organization_id" {
    null = false
    type = bigint
  }
  column "provider_name" {
    null = false
    type = character_varying
  }
  column "metadata_file" {
    null = false
    type = character_varying
  }
  column "metadata_url" {
    null = false
    type = character_varying
  }
  column "attributes" {
    null = false
    type = json
  }
  column "idp_identifier" {
    null = true
    type = json
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "organization_identity_providers_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organization_invitations" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "organization_id" {
    null = false
    type = bigint
  }
  column "sender_id" {
    null = false
    type = bigint
  }
  column "email" {
    null = false
    type = character_varying
  }
  column "token" {
    null = false
    type = character_varying
  }
  column "roles" {
    null = true
    type = character_varying
  }
  column "start" {
    null = true
    type = timestamptz
  }
  column "finish" {
    null = true
    type = timestamptz
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  column "expires" {
    null    = false
    type    = timestamptz
    default = sql("(CURRENT_TIMESTAMP + '1 day'::interval)")
  }
  column "accepted" {
    null = true
    type = timestamptz
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "organization_invitations_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "organization_invitations_sender_id_fkey" {
    columns     = [column.sender_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organization_notification_emails" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "organization_id" {
    null = false
    type = bigint
  }
  column "notification_type_id" {
    null = false
    type = smallint
  }
  column "notification_images" {
    null    = false
    type    = boolean
    default = false
  }
  column "email" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "organization_notification_emails_notification_type_id_fkey" {
    columns     = [column.notification_type_id]
    ref_columns = [table.organization_notification_types.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "organization_notification_emails_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organization_notification_templates" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "organization_id" {
    null = false
    type = bigint
  }
  column "notification_type_id" {
    null = false
    type = smallint
  }
  column "subject" {
    null = false
    type = character_varying
  }
  column "body" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "organization_notification_templates_notification_type_id_fkey" {
    columns     = [column.notification_type_id]
    ref_columns = [table.organization_notification_types.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "organization_notification_templates_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organization_notification_types" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "category" {
    null = false
    type = character_varying
  }
  column "type" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "description" {
    null = false
    type = character_varying
  }
  column "subject" {
    null = false
    type = character_varying
  }
  column "body" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
}
table "organization_test_results" {
  schema = schema.public
  column "organization_id" {
    null = true
    type = bigint
  }
  column "test_result_id" {
    null = true
    type = bigint
  }
  foreign_key "organization_test_results_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "organization_test_results_test_result_id_fkey" {
    columns     = [column.test_result_id]
    ref_columns = [table.test_results.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organization_user_roles" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "organization_id" {
    null = false
    type = bigint
  }
  column "resource_role_id" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "organization_user_roles_organization_id_fkey" {
    columns     = [column.organization_id]
    ref_columns = [table.organizations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "organization_user_roles_resource_role_id_fkey" {
    columns     = [column.resource_role_id]
    ref_columns = [table.resource_roles.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "organizations" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "timezone" {
    null    = false
    type    = character_varying
    default = "Etc/UTC"
  }
  column "notification_images" {
    null    = false
    type    = boolean
    default = false
  }
  column "parent_id" {
    null = true
    type = bigint
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "resource_roles" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "resource_type" {
    null = false
    type = character_varying
  }
  column "resource_id" {
    null = false
    type = bigint
  }
  column "role_id" {
    null = false
    type = smallint
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "resource_roles_role_id_fkey" {
    columns     = [column.role_id]
    ref_columns = [table.roles.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "roles" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "key" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "description" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
  index "roles_key_key" {
    unique  = true
    columns = [column.key]
  }
}
table "test_classes" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_classes_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_manufacturers" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_manufacturers_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_profile_bar_evs" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_profile_bar_id" {
    null = false
    type = bigint
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "unit" {
    null = false
    type = character_varying
  }
  column "decimals" {
    null = false
    type = smallint
  }
  column "args" {
    null = true
    type = json
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_profile_bar_evs_test_profile_bar_id_fkey" {
    columns     = [column.test_profile_bar_id]
    ref_columns = [table.test_profile_bars.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_profile_bars" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_profile_version_id" {
    null = false
    type = bigint
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "operator" {
    null = true
    type = character_varying
  }
  column "h" {
    null = false
    type = integer
  }
  column "threshold" {
    null = false
    type = integer
  }
  column "w" {
    null = false
    type = integer
  }
  column "x" {
    null = false
    type = integer
  }
  column "y" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_profile_bars_test_profile_version_id_fkey" {
    columns     = [column.test_profile_version_id]
    ref_columns = [table.test_profile_versions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_profile_versions" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_profile_id" {
    null = false
    type = bigint
  }
  column "led" {
    null = false
    type = character_varying
  }
  column "max_right" {
    null = false
    type = integer
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_profile_versions_test_profile_id_fkey" {
    columns     = [column.test_profile_id]
    ref_columns = [table.test_profiles.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_profiles" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "test_technology_id" {
    null = true
    type = smallint
  }
  column "test_manufacturer_id" {
    null = false
    type = smallint
  }
  column "test_type_id" {
    null = false
    type = smallint
  }
  column "test_class_id" {
    null = true
    type = smallint
  }
  column "test_version_id" {
    null = true
    type = smallint
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_profiles_test_class_id_fkey" {
    columns     = [column.test_class_id]
    ref_columns = [table.test_classes.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_profiles_test_manufacturer_id_fkey" {
    columns     = [column.test_manufacturer_id]
    ref_columns = [table.test_manufacturers.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_profiles_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_profiles_test_technology_id_fkey" {
    columns     = [column.test_technology_id]
    ref_columns = [table.test_technologies.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_profiles_test_type_id_fkey" {
    columns     = [column.test_type_id]
    ref_columns = [table.test_types.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_profiles_test_version_id_fkey" {
    columns     = [column.test_version_id]
    ref_columns = [table.test_versions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_result_bar_evs" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_result_bar_id" {
    null = true
    type = bigint
  }
  column "result" {
    null = false
    type = numeric
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_result_bar_evs_test_result_bar_id_fkey" {
    columns     = [column.test_result_bar_id]
    ref_columns = [table.test_result_bars.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_result_bar_samples" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_result_bar_id" {
    null = true
    type = bigint
  }
  column "value" {
    null = false
    type = numeric
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_result_bar_samples_test_result_bar_id_fkey" {
    columns     = [column.test_result_bar_id]
    ref_columns = [table.test_result_bars.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_result_bars" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_result_history_id" {
    null = false
    type = bigint
  }
  column "test_profile_bar_id" {
    null = false
    type = bigint
  }
  column "image" {
    null = false
    type = character_varying
  }
  column "value" {
    null = false
    type = numeric
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_result_bars_test_profile_bar_id_fkey" {
    columns     = [column.test_profile_bar_id]
    ref_columns = [table.test_profile_bars.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_result_bars_test_result_history_id_fkey" {
    columns     = [column.test_result_history_id]
    ref_columns = [table.test_result_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_result_histories" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_result_id" {
    null = false
    type = bigint
  }
  column "device_history_id" {
    null = false
    type = bigint
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "visual_status" {
    null = true
    type = character_varying
  }
  column "centerline_start_x" {
    null = false
    type = integer
  }
  column "centerline_end_x" {
    null = false
    type = integer
  }
  column "centerline_start_y" {
    null = false
    type = integer
  }
  column "centerline_end_y" {
    null = false
    type = integer
  }
  column "temperature" {
    null = true
    type = numeric
  }
  column "humidity" {
    null = true
    type = numeric
  }
  column "note" {
    null = true
    type = character_varying
  }
  column "sampled" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_result_histories_device_history_id_fkey" {
    columns     = [column.device_history_id]
    ref_columns = [table.device_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "test_result_histories_test_result_id_fkey" {
    columns     = [column.test_result_id]
    ref_columns = [table.test_results.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_result_scans" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_result_history_id" {
    null = false
    type = bigint
  }
  column "type" {
    null = false
    type = character_varying
  }
  column "data" {
    null = false
    type = json
  }
  column "scanned" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_result_scans_test_result_history_id_fkey" {
    columns     = [column.test_result_history_id]
    ref_columns = [table.test_result_histories.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_results" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_profile_version_id" {
    null = false
    type = bigint
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_results_test_profile_version_id_fkey" {
    columns     = [column.test_profile_version_id]
    ref_columns = [table.test_profile_versions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_standard_components" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "description" {
    null = false
    type = character_varying
  }
  column "length" {
    null = false
    type = smallint
  }
  column "position" {
    null = false
    type = smallint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_standard_components_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_standards" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "test_technologies" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_technologies_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_types" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_types_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_versions" {
  schema = schema.public
  column "id" {
    null = false
    type = smallserial
  }
  column "test_standard_id" {
    null = false
    type = smallint
  }
  column "barcode" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "status" {
    null = false
    type = character_varying
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "test_versions_test_standard_id_fkey" {
    columns     = [column.test_standard_id]
    ref_columns = [table.test_standards.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "users" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "username" {
    null = false
    type = character_varying
  }
  column "email" {
    null = false
    type = character_varying
  }
  column "name" {
    null = false
    type = character_varying
  }
  column "timezone" {
    null    = false
    type    = character_varying
    default = "Etc/UTC"
  }
  column "created" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
schema "public" {
}
