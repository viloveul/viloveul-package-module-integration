---
-- TABLE
---

-- tbl_activity definition
CREATE TABLE IF NOT EXISTS tbl_activity (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	ip varchar(255) NULL,
	ua varchar(255) NULL,
	"action" varchar(20) NOT NULL,
	"reference" varchar(255) NULL,
	"url" varchar(255) NULL,
	status bool NULL,
	payload text NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_activity_pkey PRIMARY KEY (id)
);

-- tbl_setting definition
CREATE TABLE IF NOT EXISTS tbl_setting (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	"key" varchar(255) NOT NULL,
	visibility varchar(20) NOT NULL,
	value text NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_setting_pkey PRIMARY KEY (id)
);

-- tbl_media definition
CREATE TABLE IF NOT EXISTS tbl_media (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	name varchar(255) NOT NULL,
	source text NULL,
	"size" bigint NOT NULL,
	mime varchar(255) NOT NULL,
	visibility varchar(20) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_media_pkey PRIMARY KEY (id)
);

-- tbl_owner definition
CREATE TABLE IF NOT EXISTS tbl_owner (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_user varchar(50) NOT NULL,
	id_group varchar(50) NOT NULL,
	resource varchar(255) NOT NULL,
	object varchar(50) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_owner_pkey PRIMARY KEY (id)
);

-- tbl_permission definition
CREATE TABLE IF NOT EXISTS tbl_permission (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_user varchar(50) NOT NULL,
	resource varchar(255) NOT NULL,
	operation varchar(255) NOT NULL,
	object varchar(50) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_permission_pkey PRIMARY KEY (id)
);

---
-- CONSTRAINT
---

ALTER TABLE tbl_setting DROP CONSTRAINT IF EXISTS tbl_setting_key_unq;
ALTER TABLE tbl_setting ADD CONSTRAINT tbl_setting_key_unq UNIQUE ("key");

ALTER TABLE tbl_owner DROP CONSTRAINT IF EXISTS tbl_owner_unq;
ALTER TABLE tbl_owner ADD CONSTRAINT tbl_owner_unq UNIQUE (resource, object);

ALTER TABLE tbl_permission DROP CONSTRAINT IF EXISTS tbl_permission_unq;
ALTER TABLE tbl_permission ADD CONSTRAINT tbl_permission_unq UNIQUE (id_user, resource, operation, object);

---
-- INDEXING
---

CREATE INDEX IF NOT EXISTS tbl_activity_url_idx ON tbl_activity USING btree (url);
CREATE INDEX IF NOT EXISTS tbl_activity_created_at_idx ON tbl_activity USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_activity_created_by_idx ON tbl_activity USING btree (created_by);
CREATE INDEX IF NOT EXISTS tbl_activity_id_idx ON tbl_activity USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_activity_ip_idx ON tbl_activity USING btree (ip);
CREATE INDEX IF NOT EXISTS tbl_activity_status_idx ON tbl_activity USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_activity_ua_idx ON tbl_activity USING btree (ua);
CREATE INDEX IF NOT EXISTS tbl_activity_action_idx ON tbl_activity USING btree ("action");
CREATE INDEX IF NOT EXISTS tbl_activity_reference_idx ON tbl_activity USING btree ("reference");

CREATE INDEX IF NOT EXISTS tbl_setting_id_idx ON tbl_setting USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_setting_key_idx ON tbl_setting USING btree (key);
CREATE INDEX IF NOT EXISTS tbl_setting_visibility_idx ON tbl_setting USING btree (visibility);
CREATE INDEX IF NOT EXISTS tbl_setting_status_idx ON tbl_setting USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_setting_value_idx ON tbl_setting USING btree (value);

CREATE INDEX IF NOT EXISTS tbl_media_name_idx ON tbl_media USING btree (name);
CREATE INDEX IF NOT EXISTS tbl_media_mime_idx ON tbl_media USING btree (mime);
CREATE INDEX IF NOT EXISTS tbl_media_size_idx ON tbl_media USING btree ("size");
CREATE INDEX IF NOT EXISTS tbl_media_visibility_idx ON tbl_media USING btree (visibility);
CREATE INDEX IF NOT EXISTS tbl_media_status_idx ON tbl_media USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_owner_status_idx ON tbl_owner USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_owner_id_user_idx ON tbl_owner USING btree (id_user);
CREATE INDEX IF NOT EXISTS tbl_owner_id_group_idx ON tbl_owner USING btree (id_group);
CREATE INDEX IF NOT EXISTS tbl_owner_resource_idx ON tbl_owner USING btree (resource);
CREATE INDEX IF NOT EXISTS tbl_owner_object_idx ON tbl_owner USING btree (object);

CREATE INDEX IF NOT EXISTS tbl_permission_status_idx ON tbl_permission USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_permission_id_user_idx ON tbl_permission USING btree (id_user);
CREATE INDEX IF NOT EXISTS tbl_permission_resource_idx ON tbl_permission USING btree (resource);
CREATE INDEX IF NOT EXISTS tbl_permission_operation_idx ON tbl_permission USING btree (operation);
CREATE INDEX IF NOT EXISTS tbl_permission_object_idx ON tbl_permission USING btree (object);

---
-- TRIGGER ASSIGN
---

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_setting;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_setting FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_media;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_media FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');