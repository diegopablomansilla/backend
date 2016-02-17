

CREATE TABLE kuntur.mail_config
(
   id character varying NOT NULL, 
   status_id character varying NOT NULL, 
   group_id character varying NOT NULL, 
   subject character varying, 
   body character varying, 
   active boolean NOT NULL, 
   CONSTRAINT pk PRIMARY KEY (id), 
   CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES kuntur.enrrollment_status (id) ON UPDATE NO ACTION ON DELETE NO ACTION, 
   CONSTRAINT fk_group_system FOREIGN KEY (group_id) REFERENCES kuntur.group_system (id) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;

