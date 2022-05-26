INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy01','USER','USER',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy02','SCOPE','SCOPE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy03','CREDENTIAL','CREDENTIAL',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy04','ASSIGNMENT','ASSIGNMENT',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy05','GROUP','GROUP',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy06','NOTIFICATION','NOTIFICATION',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy07','OPERATION','OPERATION',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy08','PERMISSION','PERMISSION',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy09','PRIVILEGE','PRIVILEGE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy10','RESOURCE','RESOURCE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy11','SETTING','SETTING',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy12','MAIL','MAIL',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy13','AUDIT','AUDIT',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_resource (id,"identity",name,status,created_at,created_by) VALUES ('res00000-0000-0000-000-d90b3dummy14','MESSAGE','MESSAGE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy01','DELETE','DELETE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy02','DETAIL','DETAIL',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy03','CREATE','CREATE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy04','UPDATE','UPDATE',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy05','SEARCH','SEARCH',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy06','IMPORT','IMPORT',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy07','EXPORT','EXPORT',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy08','ACTIVATION','ACTIVATION',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy09','VERIFICATION','VERIFICATION',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy10','SEND','SEND',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_operation (id,"identity",name,status,created_at,created_by) VALUES ('opr00000-0000-0000-000-d90b3dummy11','RESEND','RESEND',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('role0000-0000-0000-adm-d90b3dummy01','ROLE','ADMINISTRATOR','Administrator',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('role0000-0000-0000-adm-d90b3dummy02','ROLE','DEFAULT','Default',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy01','TASK','USER-ADMINISTRATING','User Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy02','TASK','SCOPE-ADMINISTRATING','Scope Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy03','TASK','CREDENTIAL-ADMINISTRATING','Credential Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy04','TASK','ASSIGNMENT-ADMINISTRATING','Assignment Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy05','TASK','GROUP-ADMINISTRATING','Group Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy06','TASK','NOTIFICATION-ADMINISTRATING','Notification Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy07','TASK','OPERATION-ADMINISTRATING','Operation Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy08','TASK','PERMISSION-ADMINISTRATING','Permission Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy09','TASK','PRIVILEGE-ADMINISTRATING','Privilege Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy10','TASK','RESOURCE-ADMINISTRATING','Resource Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy11','TASK','SETTING-ADMINISTRATING','Setting Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy12','TASK','MAIL-ADMINISTRATING','Mail Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy13','TASK','AUDIT-ADMINISTRATING','Audit Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_privilege (id,type,"identity",name,status,created_at,created_by) VALUES ('task0000-0000-0000-adm-d90b3dummy14','TASK','MESSAGE-ADMINISTRATING','Message Administrating',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

INSERT INTO tbl_group (id,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy0a','A','A','/A',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy0b','B','B','/B',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy0c','C','C','/C',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy0d','D','D','/D',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy01','DEFAULT','DEFAULT','/DEFAULT',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy02','SAMPLE-LVL-1','SAMPLE LVL 1','/SAMPLE-LVL-1',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,id_parent,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy03','group000-0000-0000-adm-d90b3dummy02','SAMPLE-LVL-2','SAMPLE LVL 2','/SAMPLE-LVL-1/SAMPLE-LVL-2',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_group (id,id_parent,"identity",name,path,status,created_at,created_by) VALUES ('group000-0000-0000-adm-d90b3dummy04','group000-0000-0000-adm-d90b3dummy03','SAMPLE-LVL-3','SAMPLE LVL 3','/SAMPLE-LVL-1/SAMPLE-LVL-2/SAMPLE-LVL-3',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

INSERT INTO tbl_user (id,id_group,type,email,fullname,username,status,created_at,created_by) VALUES ('fajrulaz-0000-0000-adm-d90b3dummy01','group000-0000-0000-adm-d90b3dummy01','ADMIN','fajrulaz@gmail.com','Administrator','admin',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_user (id,id_group,type,email,fullname,username,status,created_at,created_by) VALUES ('fajrulaz-0000-0000-adm-d90b3dummy02','group000-0000-0000-adm-d90b3dummy01','USER','fajrulaz@gmail.com','User','user',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

--value = ADMIN123P4SSW0RD
INSERT INTO tbl_credential (id,id_user,"value",type,description,status,created_at,created_by) VALUES ('pass0000-0000-0000-adm-d90b3dummy01','fajrulaz-0000-0000-adm-d90b3dummy01','$2a$10$ks7rGJ8NX.xxHWTkfYs/q.IFRDlbh97rSbkT8bZuHXPrEFrMPPvmK','PASSWORD','PASSWORD FROM DUMMY',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_credential (id,id_user,"value",type,description,status,created_at,created_by) VALUES ('pass0000-0000-0000-adm-d90b3dummy02','fajrulaz-0000-0000-adm-d90b3dummy02','$2a$10$ks7rGJ8NX.xxHWTkfYs/q.IFRDlbh97rSbkT8bZuHXPrEFrMPPvmK','PASSWORD','PASSWORD FROM DUMMY',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

INSERT INTO tbl_owner (id,id_user,id_group,resource,object,status,created_at,created_by) VALUES ('owner000-0000-0000-adm-d90b3dummy01','fajrulaz-0000-0000-adm-d90b3dummy01','group000-0000-0000-adm-d90b3dummy01','CREDENTIAL','pass0000-0000-0000-adm-d90b3dummy01',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_owner (id,id_user,id_group,resource,object,status,created_at,created_by) VALUES ('owner000-0000-0000-adm-d90b3dummy02','fajrulaz-0000-0000-adm-d90b3dummy02','group000-0000-0000-adm-d90b3dummy01','CREDENTIAL','pass0000-0000-0000-adm-d90b3dummy02',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

-- default user operation
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy01','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy01','opr00000-0000-0000-000-d90b3dummy02',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy02','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy01','opr00000-0000-0000-000-d90b3dummy05',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

-- default group operation
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy11','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy05','opr00000-0000-0000-000-d90b3dummy02',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy12','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy05','opr00000-0000-0000-000-d90b3dummy05',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

-- default credential operation
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy21','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy03','opr00000-0000-0000-000-d90b3dummy01',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy22','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy03','opr00000-0000-0000-000-d90b3dummy03',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy23','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy03','opr00000-0000-0000-000-d90b3dummy05',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy24','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy03','opr00000-0000-0000-000-d90b3dummy08',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy25','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy03','opr00000-0000-0000-000-d90b3dummy02',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;

-- default notification operation
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy31','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy06','opr00000-0000-0000-000-d90b3dummy02',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy32','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy06','opr00000-0000-0000-000-d90b3dummy03',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;
INSERT INTO tbl_scope (id,id_privilege,id_resource,id_operation,status,created_at,created_by) VALUES ('scope000-0000-0000-adm-d90b3dummy33','role0000-0000-0000-adm-d90b3dummy02','res00000-0000-0000-000-d90b3dummy06','opr00000-0000-0000-000-d90b3dummy05',true,CURRENT_DATE,'system:dummy') ON CONFLICT(id) DO NOTHING;


-- PIVOT RELATIONSHIP

INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy01') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy02') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy03') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy04') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy05') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy06') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy07') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy08') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy09') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy10') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy11') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy12') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy13') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
INSERT INTO tbl_privilege_agregate (id_privilege,id_agregate) VALUES ('role0000-0000-0000-adm-d90b3dummy01','task0000-0000-0000-adm-d90b3dummy14') ON CONFLICT(id_privilege,id_agregate) DO NOTHING;
