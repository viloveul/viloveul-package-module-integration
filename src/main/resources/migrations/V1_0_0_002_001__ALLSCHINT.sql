-- tbl_job definition
CREATE TABLE IF NOT EXISTS tbl_job (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_origin varchar(50) NULL,
	exchange varchar(255) NOT NULL,
	route varchar(100) NOT NULL,
	content text NOT NULL,
	status bool NOT NULL DEFAULT true,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_job_pkey PRIMARY KEY (id)
);

-- tbl_mail definition
CREATE TABLE IF NOT EXISTS tbl_mail (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_origin varchar(50) NULL,
	subject varchar(255) NOT NULL,
	body text NOT NULL,
	email varchar(100) NOT NULL,
	status bool NOT NULL DEFAULT true,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_mail_pkey PRIMARY KEY (id)
);

-- tbl_recipient definition
CREATE TABLE IF NOT EXISTS tbl_recipient (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_mail varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	type varchar(5) NOT NULL,
	status bool NOT NULL DEFAULT true,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_recipient_pkey PRIMARY KEY (id)
);

-- tbl_api definition
CREATE TABLE IF NOT EXISTS tbl_api (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_origin varchar(50) NULL,
	type varchar(20) NOT NULL,
	method varchar(10) NOT NULL,
	protocol varchar(10) NOT NULL,
	info varchar(255) NULL,
	host varchar(50) NOT NULL,
	port int4 NOT NULL,
	path varchar(50) NULL,
	qs varchar(50) NULL,
	request_header text NULL,
	request_body text NULL,
	response_header text NULL,
	response_body text NULL,
	process varchar(10) NOT NULL,
	duration double precision NULL,
	populator varchar(255) NULL,
	status bool NOT NULL DEFAULT true,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	updated_at timestamp NULL,
	updated_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_api_pkey PRIMARY KEY (id)
);

-- tbl_attachment definition
CREATE TABLE IF NOT EXISTS tbl_attachment (
	id varchar(50) NOT NULL DEFAULT uuid_generate_v4(),
	id_mail varchar(50) NOT NULL,
	name varchar(50) NOT NULL,
	source varchar(255) NOT NULL,
	status bool NOT NULL DEFAULT true,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(100) NULL,
	vorder bigserial NOT NULL,
	CONSTRAINT tbl_attachment_pkey PRIMARY KEY (id)
);



ALTER TABLE tbl_api DROP CONSTRAINT IF EXISTS tbl_api_id_origin;
ALTER TABLE tbl_api ADD CONSTRAINT tbl_api_id_origin FOREIGN KEY (id_origin) REFERENCES tbl_api(id);

ALTER TABLE tbl_recipient DROP CONSTRAINT IF EXISTS tbl_recipient_id_mail_fk;
ALTER TABLE tbl_recipient ADD CONSTRAINT tbl_recipient_id_mail_fk FOREIGN KEY (id_mail) REFERENCES tbl_mail(id);

ALTER TABLE tbl_mail DROP CONSTRAINT IF EXISTS tbl_mail_id_origin_fk;
ALTER TABLE tbl_mail ADD CONSTRAINT tbl_mail_id_origin_fk FOREIGN KEY (id_origin) REFERENCES tbl_mail(id);

ALTER TABLE tbl_job DROP CONSTRAINT IF EXISTS tbl_job_id_origin_fk;
ALTER TABLE tbl_job ADD CONSTRAINT tbl_job_id_origin_fk FOREIGN KEY (id_origin) REFERENCES tbl_job(id);

ALTER TABLE tbl_attachment DROP CONSTRAINT IF EXISTS tbl_attachment_id_mail_fk;
ALTER TABLE tbl_attachment ADD CONSTRAINT tbl_attachment_id_mail_fk FOREIGN KEY (id_mail) REFERENCES tbl_mail(id);

CREATE INDEX IF NOT EXISTS tbl_job_id_origin_idx ON tbl_job USING btree (id_origin);
CREATE INDEX IF NOT EXISTS tbl_job_exchange_idx ON tbl_job USING btree (exchange);
CREATE INDEX IF NOT EXISTS tbl_job_status_idx ON tbl_job USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_mail_id_origin_idx ON tbl_mail USING btree (id_origin);
CREATE INDEX IF NOT EXISTS tbl_mail_email_idx ON tbl_mail USING btree (email);
CREATE INDEX IF NOT EXISTS tbl_mail_subject_idx ON tbl_mail USING btree (subject);
CREATE INDEX IF NOT EXISTS tbl_mail_status_idx ON tbl_mail USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_recipient_id_mail_idx ON tbl_recipient USING btree (id_mail);
CREATE INDEX IF NOT EXISTS tbl_recipient_type_idx ON tbl_recipient USING btree (type);
CREATE INDEX IF NOT EXISTS tbl_recipient_email_idx ON tbl_recipient USING btree (email);
CREATE INDEX IF NOT EXISTS tbl_recipient_status_idx ON tbl_recipient USING btree (status);

CREATE INDEX IF NOT EXISTS tbl_api_id_origin_idx ON tbl_api USING btree (id_origin);
CREATE INDEX IF NOT EXISTS tbl_api_type_idx ON tbl_api USING btree (type);
CREATE INDEX IF NOT EXISTS tbl_api_method_idx ON tbl_api USING btree (method);
CREATE INDEX IF NOT EXISTS tbl_api_protocol_idx ON tbl_api USING btree (protocol);
CREATE INDEX IF NOT EXISTS tbl_api_info_idx ON tbl_api USING btree (info);
CREATE INDEX IF NOT EXISTS tbl_api_host_idx ON tbl_api USING btree (host);
CREATE INDEX IF NOT EXISTS tbl_api_port_idx ON tbl_api USING btree (port);
CREATE INDEX IF NOT EXISTS tbl_api_path_idx ON tbl_api USING btree (path);
CREATE INDEX IF NOT EXISTS tbl_api_qs_idx ON tbl_api USING btree (qs);
CREATE INDEX IF NOT EXISTS tbl_api_process_idx ON tbl_api USING btree (process);
CREATE INDEX IF NOT EXISTS tbl_api_duration_idx ON tbl_api USING btree (duration);
CREATE INDEX IF NOT EXISTS tbl_api_status_idx ON tbl_api USING btree (status);
CREATE INDEX IF NOT EXISTS tbl_api_created_at_idx ON tbl_api USING btree (created_at);
CREATE INDEX IF NOT EXISTS tbl_api_created_by_idx ON tbl_api USING btree (created_by);


DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_job;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_job FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_mail;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_mail FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_recipient;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_recipient FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_api;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_api FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

DROP TRIGGER IF EXISTS audit_trail_trigger ON tbl_attachment;
CREATE TRIGGER audit_trail_trigger AFTER INSERT OR UPDATE OR DELETE ON tbl_attachment FOR EACH ROW EXECUTE PROCEDURE audit_trail_setup('id');

