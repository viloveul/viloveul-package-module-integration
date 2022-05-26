---
-- TABLE
---

-- tbl_resource definition
CREATE TABLE IF NOT EXISTS tbl_resource (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	"identity" varchar(255) NOT NULL,
	name varchar(255) NOT NULL,
	description text NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_resource_pkey PRIMARY KEY (id)
);

-- tbl_operation definition
CREATE TABLE IF NOT EXISTS tbl_operation (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	"identity" varchar(255) NOT NULL,
	name varchar(255) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_operation_pkey PRIMARY KEY (id)
);

-- tbl_group definition
CREATE TABLE IF NOT EXISTS tbl_group (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_parent varchar(50) NULL,
	"identity" varchar(255) NOT NULL,
	path text NOT NULL,
	name varchar(255) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	deleted_at timestamp NULL,
	deleted_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_group_pkey PRIMARY KEY (id)
);

-- tbl_privilege definition
CREATE TABLE IF NOT EXISTS tbl_privilege (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	"type" varchar(50) NOT NULL,
	"identity" varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	deleted_at timestamp NULL,
	deleted_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_privilege_pkey PRIMARY KEY (id)
);

-- tbl_user definition
CREATE TABLE IF NOT EXISTS tbl_user (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_group varchar(50) NOT NULL,
	email varchar(100) NULL,
	username varchar(100) NOT NULL,
	"type" varchar(10) NOT NULL,
	fullname varchar(255) NOT NULL,
	end_date timestamp NULL,
	start_date timestamp NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	deleted_at timestamp NULL,
	deleted_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_user_pkey PRIMARY KEY (id)
);

-- tbl_credential definition
CREATE TABLE IF NOT EXISTS tbl_credential (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_user varchar(50) NOT NULL,
	"value" varchar(255) NOT NULL,
	"type" varchar(10) NOT NULL,
	description text NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	deleted_at timestamp NULL,
	deleted_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_credential_pkey PRIMARY KEY (id)
);

-- tbl_assignment definition
CREATE TABLE IF NOT EXISTS tbl_assignment (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_group varchar(50) NOT NULL,
	id_privilege varchar(50) NOT NULL,
	id_delegator varchar(50) NOT NULL,
	id_user varchar(50) NOT NULL,
	start_date timestamp NULL,
	end_date timestamp NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	deleted_at timestamp NULL,
	deleted_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_assignment_pkey PRIMARY KEY (id)
);

-- tbl_scope definition
CREATE TABLE IF NOT EXISTS tbl_scope (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_privilege varchar(50) NOT NULL,
	id_resource varchar(50) NOT NULL,
	id_operation varchar(50) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_scope_pkey PRIMARY KEY (id)
);

-- tbl_notification definition
CREATE TABLE IF NOT EXISTS tbl_notification (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_sender varchar(50) NOT NULL,
	id_reader varchar(50) NULL,
	resource varchar(50) NOT NULL,
	operation varchar(50) NOT NULL,
	principal varchar(50) NOT NULL,
	type varchar(10) NOT NULL,
	object varchar(50) NOT NULL,
	subject varchar(255) NOT NULL,
	body text NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_notification_pkey PRIMARY KEY (id)
);

-- tbl_privilege_agregate definition
CREATE TABLE IF NOT EXISTS tbl_privilege_agregate (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_privilege varchar(50) NOT NULL,
	id_agregate varchar(50) NOT NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_privilege_agregate_pkey PRIMARY KEY (id)
);

-- tbl_user_privilege definition
CREATE TABLE IF NOT EXISTS tbl_user_privilege (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_user varchar(50) NOT NULL,
	id_privilege varchar(50) NOT NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_user_privilege_pkey PRIMARY KEY (id)
);

-- tbl_session definition
CREATE TABLE IF NOT EXISTS tbl_session (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_user varchar(50) NOT NULL,
	status bool NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	deleted_at timestamp NULL,
	deleted_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_session_pkey PRIMARY KEY (id)
);

---
-- CONSTRAINT
---

ALTER TABLE tbl_notification DROP CONSTRAINT IF EXISTS tbl_notification_id_sender_fk;
ALTER TABLE tbl_notification ADD CONSTRAINT tbl_notification_id_sender_fk FOREIGN KEY (id_sender) REFERENCES tbl_user(id);
ALTER TABLE tbl_notification DROP CONSTRAINT IF EXISTS tbl_notification_id_reader_fk;
ALTER TABLE tbl_notification ADD CONSTRAINT tbl_notification_id_reader_fk FOREIGN KEY (id_reader) REFERENCES tbl_user(id);

ALTER TABLE tbl_assignment DROP CONSTRAINT IF EXISTS tbl_assignment_id_group_fk;
ALTER TABLE tbl_assignment ADD CONSTRAINT tbl_assignment_id_group_fk FOREIGN KEY (id_group) REFERENCES tbl_group(id);
ALTER TABLE tbl_assignment DROP CONSTRAINT IF EXISTS tbl_assignment_id_delegator_fk;
ALTER TABLE tbl_assignment ADD CONSTRAINT tbl_assignment_id_delegator_fk FOREIGN KEY (id_delegator) REFERENCES tbl_user(id);
ALTER TABLE tbl_assignment DROP CONSTRAINT IF EXISTS tbl_assignment_id_privilege_fk;
ALTER TABLE tbl_assignment ADD CONSTRAINT tbl_assignment_id_privilege_fk FOREIGN KEY (id_privilege) REFERENCES tbl_privilege(id);
ALTER TABLE tbl_assignment DROP CONSTRAINT IF EXISTS tbl_assignment_id_user_fk;
ALTER TABLE tbl_assignment ADD CONSTRAINT tbl_assignment_id_user_fk FOREIGN KEY (id_user) REFERENCES tbl_user(id);
ALTER TABLE tbl_assignment DROP CONSTRAINT IF EXISTS tbl_assignment_scope_unq;
ALTER TABLE tbl_assignment ADD CONSTRAINT tbl_assignment_scope_unq UNIQUE (id_delegator, id_privilege, id_user, id_group);

ALTER TABLE tbl_credential DROP CONSTRAINT IF EXISTS tbl_credential_id_user_fk;
ALTER TABLE tbl_credential ADD CONSTRAINT tbl_credential_id_user_fk FOREIGN KEY (id_user) REFERENCES tbl_user(id);

ALTER TABLE tbl_user DROP CONSTRAINT IF EXISTS tbl_user_username_unq;
ALTER TABLE tbl_user ADD CONSTRAINT tbl_user_username_unq UNIQUE (username);
ALTER TABLE tbl_user DROP CONSTRAINT IF EXISTS tbl_user_id_group_fk;
ALTER TABLE tbl_user ADD CONSTRAINT tbl_user_id_group_fk FOREIGN KEY (id_group) REFERENCES tbl_group(id);

ALTER TABLE tbl_resource DROP CONSTRAINT IF EXISTS tbl_resource_identity_unq;
ALTER TABLE tbl_resource ADD CONSTRAINT tbl_resource_identity_unq UNIQUE ("identity");

ALTER TABLE tbl_operation DROP CONSTRAINT IF EXISTS tbl_operation_identity_unq;
ALTER TABLE tbl_operation ADD CONSTRAINT tbl_operation_identity_unq UNIQUE ("identity");

ALTER TABLE tbl_privilege DROP CONSTRAINT IF EXISTS tbl_privilege_authority_unq;
ALTER TABLE tbl_privilege ADD CONSTRAINT tbl_privilege_authority_unq UNIQUE ("identity");

ALTER TABLE tbl_group DROP CONSTRAINT IF EXISTS tbl_group_authority_unq;
ALTER TABLE tbl_group ADD CONSTRAINT tbl_group_authority_unq UNIQUE ("identity");
ALTER TABLE tbl_group DROP CONSTRAINT IF EXISTS tbl_group_id_parent;
ALTER TABLE tbl_group ADD CONSTRAINT tbl_group_id_parent FOREIGN KEY (id_parent) REFERENCES tbl_group(id);

ALTER TABLE tbl_scope DROP CONSTRAINT IF EXISTS tbl_scope_authority_unq;
ALTER TABLE tbl_scope ADD CONSTRAINT tbl_scope_authority_unq UNIQUE (id_privilege, id_resource, id_operation);
ALTER TABLE tbl_scope DROP CONSTRAINT IF EXISTS tbl_scope_id_privilege_fk;
ALTER TABLE tbl_scope ADD CONSTRAINT tbl_scope_id_privilege_fk FOREIGN KEY (id_privilege) REFERENCES tbl_privilege(id);
ALTER TABLE tbl_scope DROP CONSTRAINT IF EXISTS tbl_scope_id_resource_fk;
ALTER TABLE tbl_scope ADD CONSTRAINT tbl_scope_id_resource_fk FOREIGN KEY (id_resource) REFERENCES tbl_resource(id);
ALTER TABLE tbl_scope DROP CONSTRAINT IF EXISTS tbl_scope_id_operation_fk;
ALTER TABLE tbl_scope ADD CONSTRAINT tbl_scope_id_operation_fk FOREIGN KEY (id_operation) REFERENCES tbl_operation(id);

ALTER TABLE tbl_privilege_agregate DROP CONSTRAINT IF EXISTS tbl_privilege_agregate_id_agregate_fk;
ALTER TABLE tbl_privilege_agregate ADD CONSTRAINT tbl_privilege_agregate_id_agregate_fk FOREIGN KEY (id_agregate) REFERENCES tbl_privilege(id);
ALTER TABLE tbl_privilege_agregate DROP CONSTRAINT IF EXISTS tbl_privilege_agregate_id_privilege_fk;
ALTER TABLE tbl_privilege_agregate ADD CONSTRAINT tbl_privilege_agregate_id_privilege_fk FOREIGN KEY (id_privilege) REFERENCES tbl_privilege(id);
ALTER TABLE tbl_privilege_agregate DROP CONSTRAINT IF EXISTS tbl_privilege_agregate_unq;
ALTER TABLE tbl_privilege_agregate ADD CONSTRAINT tbl_privilege_agregate_unq UNIQUE (id_privilege, id_agregate);

ALTER TABLE tbl_user_privilege DROP CONSTRAINT IF EXISTS tbl_user_privilege_id_user_fk;
ALTER TABLE tbl_user_privilege ADD CONSTRAINT tbl_user_privilege_id_user_fk FOREIGN KEY (id_user) REFERENCES tbl_user(id);
ALTER TABLE tbl_user_privilege DROP CONSTRAINT IF EXISTS tbl_user_privilege_id_privilege_fk;
ALTER TABLE tbl_user_privilege ADD CONSTRAINT tbl_user_privilege_id_privilege_fk FOREIGN KEY (id_privilege) REFERENCES tbl_privilege(id);
ALTER TABLE tbl_user_privilege DROP CONSTRAINT IF EXISTS tbl_user_privilege_unq;
ALTER TABLE tbl_user_privilege ADD CONSTRAINT tbl_user_privilege_unq UNIQUE (id_privilege, id_user);

ALTER TABLE tbl_session DROP CONSTRAINT IF EXISTS tbl_session_id_user_fk;
ALTER TABLE tbl_session ADD CONSTRAINT tbl_session_id_user_fk FOREIGN KEY (id_user) REFERENCES tbl_user(id);

---
-- INDEXING
---

CREATE INDEX IF NOT EXISTS tbl_scope_id_privilege_idx ON tbl_scope USING btree (id_privilege);
CREATE INDEX IF NOT EXISTS tbl_scope_id_resource_idx ON tbl_scope USING btree (id_resource);
CREATE INDEX IF NOT EXISTS tbl_scope_id_operation_idx ON tbl_scope USING btree (id_operation);
CREATE INDEX IF NOT EXISTS tbl_scope_status_idx ON tbl_scope USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_scope_created_at_idx ON tbl_scope USING btree (created_at);

CREATE INDEX IF NOT EXISTS tbl_group_created_at_idx ON tbl_group USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_group_id_idx ON tbl_group USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_group_id_parent_idx ON tbl_group USING btree (id_parent);
CREATE INDEX IF NOT EXISTS tbl_group_identity_idx ON tbl_group USING btree ("identity");
CREATE INDEX IF NOT EXISTS tbl_group_path_idx ON tbl_group USING btree (path);
CREATE INDEX IF NOT EXISTS tbl_group_name_idx ON tbl_group USING btree (name);
CREATE INDEX IF NOT EXISTS tbl_group_status_idx ON tbl_group USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_privilege_created_at_idx ON tbl_privilege USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_privilege_id_idx ON tbl_privilege USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_privilege_identity_idx ON tbl_privilege USING btree ("identity");
CREATE INDEX IF NOT EXISTS tbl_privilege_type_idx ON tbl_privilege USING btree ("type");
CREATE INDEX IF NOT EXISTS tbl_privilege_name_idx ON tbl_privilege USING btree (name);
CREATE INDEX IF NOT EXISTS tbl_privilege_status_idx ON tbl_privilege USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_user_created_at_idx ON tbl_user USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_user_email_idx ON tbl_user USING btree (email);
CREATE INDEX IF NOT EXISTS tbl_user_end_date_idx ON tbl_user USING btree (end_date);
CREATE INDEX IF NOT EXISTS tbl_user_id_group_idx ON tbl_user USING btree (id_group);
CREATE INDEX IF NOT EXISTS tbl_user_id_idx ON tbl_user USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_user_start_date_idx ON tbl_user USING btree (start_date);
CREATE INDEX IF NOT EXISTS tbl_user_status_idx ON tbl_user USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_user_username_idx ON tbl_user USING btree (username);

CREATE INDEX IF NOT EXISTS tbl_credential_created_at_idx ON tbl_credential USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_credential_deleted_at_idx ON tbl_credential USING btree (deleted_at);
CREATE INDEX IF NOT EXISTS tbl_credential_id_user_idx ON tbl_credential USING btree (id_user);
CREATE INDEX IF NOT EXISTS tbl_credential_id_idx ON tbl_credential USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_credential_type_idx ON tbl_credential USING btree (type);
CREATE INDEX IF NOT EXISTS tbl_credential_start_date_idx ON tbl_credential USING btree (start_date);
CREATE INDEX IF NOT EXISTS tbl_credential_status_idx ON tbl_credential USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_credential_end_date_idx ON tbl_credential USING btree (end_date);

CREATE INDEX IF NOT EXISTS tbl_assignment_created_at_idx ON tbl_assignment USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_assignment_deleted_at_idx ON tbl_assignment USING btree (deleted_at);
CREATE INDEX IF NOT EXISTS tbl_assignment_end_date_idx ON tbl_assignment USING btree (end_date);
CREATE INDEX IF NOT EXISTS tbl_assignment_id_idx ON tbl_assignment USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_assignment_id_privilege_idx ON tbl_assignment USING btree (id_privilege);
CREATE INDEX IF NOT EXISTS tbl_assignment_id_group_idx ON tbl_assignment USING btree (id_group);
CREATE INDEX IF NOT EXISTS tbl_assignment_id_delegator_idx ON tbl_assignment USING btree (id_delegator);
CREATE INDEX IF NOT EXISTS tbl_assignment_id_user_idx ON tbl_assignment USING btree (id_user);
CREATE INDEX IF NOT EXISTS tbl_assignment_start_date_idx ON tbl_assignment USING btree (start_date);
CREATE INDEX IF NOT EXISTS tbl_assignment_status_idx ON tbl_assignment USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_notification_operation_idx ON tbl_notification USING btree (operation);
CREATE INDEX IF NOT EXISTS tbl_notification_resource_idx ON tbl_notification USING btree (resource);
CREATE INDEX IF NOT EXISTS tbl_notification_principal_idx ON tbl_notification USING btree (principal);
CREATE INDEX IF NOT EXISTS tbl_notification_id_reader_idx ON tbl_notification USING btree (id_reader);
CREATE INDEX IF NOT EXISTS tbl_notification_id_idx ON tbl_notification USING btree (id);
CREATE INDEX IF NOT EXISTS tbl_notification_id_sender_idx ON tbl_notification USING btree (id_sender);
CREATE INDEX IF NOT EXISTS tbl_notification_type_idx ON tbl_notification USING btree (type);
CREATE INDEX IF NOT EXISTS tbl_notification_status_idx ON tbl_notification USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_notification_subject_idx ON tbl_notification USING btree (subject);
CREATE INDEX IF NOT EXISTS tbl_notification_object_idx ON tbl_notification USING btree (object);

---
-- TRIGGER SETUP
---

CREATE OR REPLACE FUNCTION user_grbac(uid character varying)
 RETURNS TABLE(id_scope character varying, id_group character varying, id_privilege character varying, id_resource character varying, id_operation character varying, group_name character varying, privilege_name character varying, resource_name character varying, operation_name character varying)
 LANGUAGE sql
AS '
WITH recursive tprivilege AS (
	SELECT
		a.id AS id_privilege,
		a."name" AS privilege_name,
		b.id AS id_group,
		b.name AS group_name
	FROM tbl_privilege a
	JOIN (
		WITH recursive tgroup AS (
		    SELECT
		    	a.id,
		    	a."name",
		    	b.id_privilege
		    FROM tbl_group AS a
		    JOIN tbl_assignment AS b ON b.id_group = a.id AND
		    	b.status = true AND
		    	(b.start_date IS NULL OR b.start_date < NOW()) AND
		    	(b.end_date IS NULL OR b.end_date > NOW())
		    WHERE b.id_user = uid AND a.status = true
			UNION ALL
		    SELECT
		    	a.id,
		    	a."name",
		    	p.id_privilege
			FROM tbl_group AS a
			JOIN tgroup AS p ON p.id = a.id_parent
			WHERE a.status = true
		)
		SELECT * FROM tgroup
	) b ON b.id_privilege = a.id AND a.status = true
	UNION ALL
	SELECT
		a.id AS id_privilege,
		a."name" AS privilege_name,
		c.id_group,
		c.group_name
	FROM tbl_privilege a
	JOIN tbl_privilege_agregate b ON b.id_agregate = a.id AND a.status = true
	JOIN tprivilege c ON c.id_privilege = b.id_privilege
)
SELECT
	tscope.id AS id_scope,
	tprivilege.id_group,
	tprivilege.id_privilege,
	tresource.id AS id_resource,
	toperation.id AS id_operation,
	tprivilege.group_name,
	tprivilege.privilege_name,
	tresource."name" AS resource_name,
	toperation."name" AS operation_name
FROM tprivilege
JOIN tbl_scope AS tscope ON tscope.id_privilege = tprivilege.id_privilege AND
	tscope.status = true
JOIN tbl_resource AS tresource ON tresource.id = tscope.id_resource AND
	tresource.status = true
JOIN tbl_operation AS toperation ON toperation.id = tscope.id_operation AND
	toperation.status = true
;
'
;

CREATE OR REPLACE FUNCTION user_rbac(uid character varying)
 RETURNS TABLE(id_scope character varying, id_privilege character varying, id_resource character varying, id_operation character varying, privilege_name character varying, resource_name character varying, operation_name character varying)
 LANGUAGE sql
AS '
WITH recursive tprivilege AS (
	SELECT
		a.id AS id_privilege,
		a."name" AS privilege_name
	FROM tbl_privilege a
	JOIN tbl_user_privilege b ON b.id_privilege = a.id
	JOIN tbl_user c ON c.id = b.id_user
	where c.id = uid AND c.status = true AND a.status = true
	UNION ALL
	SELECT
		a.id AS id_privilege,
		a."name" AS privilege_name
	FROM tbl_privilege a
	JOIN tbl_privilege_agregate b ON b.id_agregate = a.id AND a.status = true
	JOIN tprivilege c ON c.id_privilege = b.id_privilege
)
SELECT
	tscope.id AS id_scope,
	tprivilege.id_privilege,
	tresource.id AS id_resource,
	toperation.id AS id_operation,
	tprivilege.privilege_name,
	tresource."name" AS resource_name,
	toperation."name" AS operation_name
FROM tprivilege
JOIN tbl_scope AS tscope ON tscope.id_privilege = tprivilege.id_privilege AND
	tscope.status = true
JOIN tbl_resource AS tresource ON tresource.id = tscope.id_resource AND
	tresource.status = true
JOIN tbl_operation AS toperation ON toperation.id = tscope.id_operation AND
	toperation.status = true
;
'
;


---
-- TRIGGER ASSIGN
---

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_resource;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_resource FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_operation;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_operation FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_group;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_group FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_privilege;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_privilege FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_user;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_user FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_credential;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_credential FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id', '{value}');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_assignment;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_assignment FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_permission;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_permission FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_scope;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_scope FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_owner;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_owner FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_privilege_agregate;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_privilege_agregate FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_user_privilege;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_user_privilege FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');