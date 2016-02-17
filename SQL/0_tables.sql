-- Modelo de Datos de Kuntur (Base de Datos PostgreSQL)

----------------------------------------------------------------------------------------

-- TABLA: Person

DROP TABLE IF EXISTS kuntur.person CASCADE;

CREATE TABLE kuntur.person
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- givenName
	given_name VARCHAR NOT NULL, 

	-- middleName
	middle_name VARCHAR, 

	-- familyName
	family_name VARCHAR NOT NULL, 

	-- birthDate
	birth_date DATE NOT NULL, 

	-- male
	male BOOLEAN NOT NULL, 

	-- urlPhoto
	url_photo VARCHAR, 

	-- comment
	comment VARCHAR, 

	-- birthCountryCode
	birth_country_code VARCHAR NOT NULL, 

	-- birthAdminAreaLevel1Code
	birth_admin_area_level1_code VARCHAR, 

	-- birthAdminAreaLevel2
	birth_admin_area_level2 VARCHAR, 

	-- birthLocality
	birth_locality VARCHAR, 

	-- birthLat
	birth_lat DOUBLE PRECISION, 

	-- birthLng
	birth_lng DOUBLE PRECISION
);

----------------------------------------------------------------------------------------

-- TABLA: PersonEmail

DROP TABLE IF EXISTS kuntur.person_email CASCADE;

CREATE TABLE kuntur.person_email
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- email
	email VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- person
	person_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: PersonPhone

DROP TABLE IF EXISTS kuntur.person_phone CASCADE;

CREATE TABLE kuntur.person_phone
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- phoneNumber
	phone_number VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- person
	person_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: PersonIdentityType

DROP TABLE IF EXISTS kuntur.person_identity_type CASCADE;

CREATE TABLE kuntur.person_identity_type
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR NOT NULL, 

	-- countryCode
	country_code VARCHAR, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: PersonIdentity

DROP TABLE IF EXISTS kuntur.person_identity CASCADE;

CREATE TABLE kuntur.person_identity
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- identityNumber
	identity_number VARCHAR NOT NULL, 

	-- code
	code VARCHAR NOT NULL, 

	-- name
	name VARCHAR NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- person
	person_id VARCHAR  NOT NULL, 

	-- personIdentityType
	person_identity_type_id VARCHAR 
);

----------------------------------------------------------------------------------------

-- TABLA: PersonNationality

DROP TABLE IF EXISTS kuntur.person_nationality CASCADE;

CREATE TABLE kuntur.person_nationality
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- person
	person_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: PersonAddress

DROP TABLE IF EXISTS kuntur.person_address CASCADE;

CREATE TABLE kuntur.person_address
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- adminAreaLevel1Code
	admin_area_level1_code VARCHAR, 

	-- adminAreaLevel2
	admin_area_level2 VARCHAR, 

	-- locality
	locality VARCHAR NOT NULL, 

	-- neighbourhood
	neighbourhood VARCHAR, 

	-- street
	street VARCHAR, 

	-- streetNumber
	street_number VARCHAR, 

	-- buildingFloor
	building_floor VARCHAR, 

	-- buildingRoom
	building_room VARCHAR, 

	-- building
	building VARCHAR, 

	-- postalCode
	postal_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- lat
	lat DOUBLE PRECISION, 

	-- lng
	lng DOUBLE PRECISION, 

	-- person
	person_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: UserSystem

DROP TABLE IF EXISTS kuntur.user_system CASCADE;

CREATE TABLE kuntur.user_system
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- pass
	pass VARCHAR NOT NULL, 

	-- email
	email VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- checkedMail
	checked_mail BOOLEAN NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: GroupSystem

DROP TABLE IF EXISTS kuntur.group_system CASCADE;

CREATE TABLE kuntur.group_system
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: UserGroup

DROP TABLE IF EXISTS kuntur.user_group CASCADE;

CREATE TABLE kuntur.user_group
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- groupSystem
	group_system_id VARCHAR  NOT NULL, 

	-- userSystem
	user_system_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: OrgType

DROP TABLE IF EXISTS kuntur.org_type CASCADE;

CREATE TABLE kuntur.org_type
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: Org

DROP TABLE IF EXISTS kuntur.org CASCADE;

CREATE TABLE kuntur.org
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- shortName
	short_name VARCHAR NOT NULL, 

	-- name
	name VARCHAR NOT NULL, 

	-- originalName
	original_name VARCHAR NOT NULL, 

	-- urlPhoto
	url_photo VARCHAR, 

	-- webSite
	web_site VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- primaryOrg
	primary_org BOOLEAN NOT NULL, 

	-- codeOna
	code_ona INTEGER UNIQUE, 

	-- codeGuarani
	code_guarani VARCHAR UNIQUE, 

	-- orgType
	org_type_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR , 

	-- orgX
	org_x_id VARCHAR 
);

----------------------------------------------------------------------------------------

-- TABLA: OrgEmail

DROP TABLE IF EXISTS kuntur.org_email CASCADE;

CREATE TABLE kuntur.org_email
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- email
	email VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: OrgPhone

DROP TABLE IF EXISTS kuntur.org_phone CASCADE;

CREATE TABLE kuntur.org_phone
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- phoneNumber
	phone_number VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: OrgAddress

DROP TABLE IF EXISTS kuntur.org_address CASCADE;

CREATE TABLE kuntur.org_address
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- adminAreaLevel1Code
	admin_area_level1_code VARCHAR, 

	-- adminAreaLevel2
	admin_area_level2 VARCHAR, 

	-- locality
	locality VARCHAR NOT NULL, 

	-- neighbourhood
	neighbourhood VARCHAR, 

	-- street
	street VARCHAR NOT NULL, 

	-- streetNumber
	street_number VARCHAR, 

	-- buildingFloor
	building_floor VARCHAR, 

	-- buildingRoom
	building_room VARCHAR, 

	-- building
	building VARCHAR, 

	-- postalCode
	postal_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- lat
	lat DOUBLE PRECISION, 

	-- lng
	lng DOUBLE PRECISION, 

	-- org
	org_id VARCHAR 
);

----------------------------------------------------------------------------------------

-- TABLA: Contact

DROP TABLE IF EXISTS kuntur.contact CASCADE;

CREATE TABLE kuntur.contact
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL, 

	-- person
	person_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: Student

DROP TABLE IF EXISTS kuntur.student CASCADE;

CREATE TABLE kuntur.student
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- fileNumber
	file_number BIGINT NOT NULL, 

	-- institutionShortName
	institution_short_name VARCHAR, 

	-- institutionName
	institution_name VARCHAR, 

	-- institutionOriginalName
	institution_original_name VARCHAR, 

	-- institutionWebSite
	institution_web_site VARCHAR, 

	-- institutionCountryCode
	institution_country_code VARCHAR, 

	-- org
	org_id VARCHAR 
);

----------------------------------------------------------------------------------------

-- TABLA: AgreementContact

DROP TABLE IF EXISTS kuntur.agreement_contact CASCADE;

CREATE TABLE kuntur.agreement_contact
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- receptionStudent
	reception_student BOOLEAN NOT NULL, 

	-- sendingStudent
	sending_student BOOLEAN NOT NULL, 

	-- agreementItem
	agreement_item_id VARCHAR  NOT NULL, 

	-- contact
	contact_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AgreementType

DROP TABLE IF EXISTS kuntur.agreement_type CASCADE;

CREATE TABLE kuntur.agreement_type
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: AgreementStatus

DROP TABLE IF EXISTS kuntur.agreement_status CASCADE;

CREATE TABLE kuntur.agreement_status
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: Agreement

DROP TABLE IF EXISTS kuntur.agreement CASCADE;

CREATE TABLE kuntur.agreement
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- numberAgreement
	number_agreement BIGINT NOT NULL, 

	-- title
	title VARCHAR UNIQUE NOT NULL, 

	-- fromDate
	from_date DATE NOT NULL, 

	-- toDate
	to_date DATE, 

	-- comment
	comment VARCHAR, 

	-- agreementType
	agreement_type_id VARCHAR  NOT NULL, 

	-- agreementStatus
	agreement_status_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AgreementItem

DROP TABLE IF EXISTS kuntur.agreement_item CASCADE;

CREATE TABLE kuntur.agreement_item
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- inUnits
	in_units INTEGER, 

	-- outUnits
	out_units INTEGER, 

	-- agreement
	agreement_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AgreementItemOu

DROP TABLE IF EXISTS kuntur.agreement_item_ou CASCADE;

CREATE TABLE kuntur.agreement_item_ou
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- inUnits
	in_units INTEGER, 

	-- outUnits
	out_units INTEGER, 

	-- agreementItem
	agreement_item_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AdmissionPeriodItemOu

DROP TABLE IF EXISTS kuntur.admission_period_item_ou CASCADE;

CREATE TABLE kuntur.admission_period_item_ou
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- inUnits
	in_units INTEGER, 

	-- outUnits
	out_units INTEGER, 

	-- admissionPeriodItem
	admission_period_item_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AdmissionPeriodStatus

DROP TABLE IF EXISTS kuntur.admission_period_status CASCADE;

CREATE TABLE kuntur.admission_period_status
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: AdmissionPeriod

DROP TABLE IF EXISTS kuntur.admission_period CASCADE;

CREATE TABLE kuntur.admission_period
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- numberAdmissionPeriod
	number_admission_period BIGINT NOT NULL, 

	-- inType
	in_type BOOLEAN NOT NULL, 

	-- year
	year INTEGER NOT NULL, 

	-- semester
	semester INTEGER NOT NULL, 

	-- title
	title VARCHAR UNIQUE NOT NULL, 

	-- fromDate
	from_date DATE NOT NULL, 

	-- toDate
	to_date DATE NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- admissionPeriodStatus
	admission_period_status_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AdmissionPeriodAgreement

DROP TABLE IF EXISTS kuntur.admission_period_agreement CASCADE;

CREATE TABLE kuntur.admission_period_agreement
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- agreement
	agreement_id VARCHAR  NOT NULL, 

	-- admissionPeriod
	admission_period_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AdmissionPeriodItem

DROP TABLE IF EXISTS kuntur.admission_period_item CASCADE;

CREATE TABLE kuntur.admission_period_item
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- inUnits
	in_units INTEGER, 

	-- outUnits
	out_units INTEGER, 

	-- admissionPeriod
	admission_period_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: AdmissionPeriodContact

DROP TABLE IF EXISTS kuntur.admission_period_contact CASCADE;

CREATE TABLE kuntur.admission_period_contact
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- admissionPeriodItem
	admission_period_item_id VARCHAR  NOT NULL, 

	-- contact
	contact_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentStatus

DROP TABLE IF EXISTS kuntur.enrrollment_status CASCADE;

CREATE TABLE kuntur.enrrollment_status
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: Enrrollment

DROP TABLE IF EXISTS kuntur.enrrollment CASCADE;

CREATE TABLE kuntur.enrrollment
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- givenName
	given_name VARCHAR NOT NULL, 

	-- middleName
	middle_name VARCHAR, 

	-- familyName
	family_name VARCHAR NOT NULL, 

	-- birthDate
	birth_date DATE NOT NULL, 

	-- male
	male BOOLEAN NOT NULL, 

	-- urlPhoto
	url_photo VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- birthCountryCode
	birth_country_code VARCHAR NOT NULL, 

	-- birthAdminAreaLevel1Code
	birth_admin_area_level1_code VARCHAR, 

	-- birthAdminAreaLevel2
	birth_admin_area_level2 VARCHAR, 

	-- birthLocality
	birth_locality VARCHAR, 

	-- birthLat
	birth_lat DOUBLE PRECISION, 

	-- birthLng
	birth_lng DOUBLE PRECISION, 

	-- institutionShortName
	institution_short_name VARCHAR NOT NULL, 

	-- institutionName
	institution_name VARCHAR NOT NULL, 

	-- institutionOriginalName
	institution_original_name VARCHAR NOT NULL, 

	-- institutionWebSite
	institution_web_site VARCHAR NOT NULL, 

	-- institutionCountryCode
	institution_country_code VARCHAR NOT NULL, 

	-- numberEnrrollment
	number_enrrollment BIGINT NOT NULL, 

	-- checkOutDate
	check_out_date TIMESTAMP, 

	-- org
	org_id VARCHAR , 

	-- userSystem
	user_system_id VARCHAR , 

	-- student
	student_id VARCHAR  NOT NULL, 

	-- admissionPeriod
	admission_period_id VARCHAR  NOT NULL, 

	-- enrrollmentStatus
	enrrollment_status_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentChat

DROP TABLE IF EXISTS kuntur.enrrollment_chat CASCADE;

CREATE TABLE kuntur.enrrollment_chat
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- chatTime
	chat_time TIMESTAMP NOT NULL, 

	-- chat
	chat VARCHAR NOT NULL, 

	-- userSystemA
	user_system_a_id VARCHAR  NOT NULL, 

	-- userSystemB
	user_system_b_id VARCHAR  NOT NULL, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentStakeholder

DROP TABLE IF EXISTS kuntur.enrrollment_stakeholder CASCADE;

CREATE TABLE kuntur.enrrollment_stakeholder
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code INTEGER NOT NULL, 

	-- userSystem
	user_system_id VARCHAR  NOT NULL, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentEmail

DROP TABLE IF EXISTS kuntur.enrrollment_email CASCADE;

CREATE TABLE kuntur.enrrollment_email
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- email
	email VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentPhone

DROP TABLE IF EXISTS kuntur.enrrollment_phone CASCADE;

CREATE TABLE kuntur.enrrollment_phone
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- phoneNumber
	phone_number VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentIdentity

DROP TABLE IF EXISTS kuntur.enrrollment_identity CASCADE;

CREATE TABLE kuntur.enrrollment_identity
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- identityNumber
	identity_number VARCHAR NOT NULL, 

	-- code
	code VARCHAR NOT NULL, 

	-- name
	name VARCHAR NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL, 

	-- personIdentityType
	person_identity_type_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentNationality

DROP TABLE IF EXISTS kuntur.enrrollment_nationality CASCADE;

CREATE TABLE kuntur.enrrollment_nationality
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentAddress

DROP TABLE IF EXISTS kuntur.enrrollment_address CASCADE;

CREATE TABLE kuntur.enrrollment_address
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- countryCode
	country_code VARCHAR NOT NULL, 

	-- adminAreaLevel1Code
	admin_area_level1_code VARCHAR, 

	-- adminAreaLevel2
	admin_area_level2 VARCHAR, 

	-- locality
	locality VARCHAR NOT NULL, 

	-- neighbourhood
	neighbourhood VARCHAR, 

	-- street
	street VARCHAR NOT NULL, 

	-- streetNumber
	street_number VARCHAR, 

	-- buildingFloor
	building_floor VARCHAR, 

	-- buildingRoom
	building_room VARCHAR, 

	-- building
	building VARCHAR, 

	-- postalCode
	postal_code VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR, 

	-- lat
	lat DOUBLE PRECISION, 

	-- lng
	lng DOUBLE PRECISION, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: EnrrollmentLog

DROP TABLE IF EXISTS kuntur.enrrollment_log CASCADE;

CREATE TABLE kuntur.enrrollment_log
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- codeStart
	code_start VARCHAR NOT NULL, 

	-- nameStart
	name_start VARCHAR NOT NULL, 

	-- codeEnd
	code_end VARCHAR NOT NULL, 

	-- nameEnd
	name_end VARCHAR NOT NULL, 

	-- promotionDate
	promotion_date TIMESTAMP NOT NULL, 

	-- enrrollmentStatusA
	enrrollment_status_a_id VARCHAR  NOT NULL, 

	-- enrrollmentStatusB
	enrrollment_status_b_id VARCHAR  NOT NULL, 

	-- enrrollment
	enrrollment_id VARCHAR  NOT NULL, 

	-- userSystem
	user_system_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: UncInEnrrollment

DROP TABLE IF EXISTS kuntur.unc_in_enrrollment CASCADE;

CREATE TABLE kuntur.unc_in_enrrollment
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- agreement
	agreement BOOLEAN, 

	-- program
	program BOOLEAN, 

	-- amountPaid
	amount_paid DOUBLE PRECISION, 

	-- originalDoc
	original_doc BOOLEAN, 

	-- insurance
	insurance BOOLEAN, 

	-- languageCertificate
	language_certificate BOOLEAN, 

	-- visa
	visa VARCHAR, 

	-- emergencyContact
	emergency_contact VARCHAR, 

	-- credentialCode
	credential_code VARCHAR, 

	-- urlOrigininalTranscript
	url_origininal_transcript VARCHAR, 

	-- urlPassport
	url_passport VARCHAR, 

	-- urlLanguageCertificate
	url_language_certificate VARCHAR, 

	-- urlCv
	url_cv VARCHAR, 

	-- urlApplicationLetter
	url_application_letter VARCHAR, 

	-- urlCertificatePsychophysical
	url_certificate_psychophysical VARCHAR, 

	-- urlAdmissionAct
	url_admission_act VARCHAR, 

	-- urlAdmissionActTemplate
	url_admission_act_template VARCHAR, 

	-- urlTranscript
	url_transcript VARCHAR, 

	-- urlTranscriptTemplate
	url_transcript_template VARCHAR, 

	-- urlUniversityCredential
	url_university_credential VARCHAR, 

	-- urlStudentReport
	url_student_report VARCHAR, 

	-- urlExchangeForm
	url_exchange_form VARCHAR, 

	-- comment
	comment VARCHAR, 

	-- observation
	observation VARCHAR, 

	-- creation_date_postulation
	creation_date_postulation DATE, 

	-- agreementName
	agreement_name VARCHAR, 

	-- agreementComment
	agreement_comment VARCHAR, 

	-- agreementNumberStudents
	agreement_number_students INTEGER, 

	-- agreementOrg
	agreement_org VARCHAR, 

	-- agreementOrgComment
	agreement_org_comment VARCHAR, 

	-- agreementAcademicUnit
	agreement_academic_unit VARCHAR, 

	-- exchangeProgramName
	exchange_program_name VARCHAR, 

	-- exchangeProgramComment
	exchange_program_comment VARCHAR, 

	-- exchangeProgramNumberStudents
	exchange_program_number_students INTEGER, 

	-- exchangeProgramInitialNumberStudents
	exchange_program_initial_number_students INTEGER
);

----------------------------------------------------------------------------------------

-- TABLA: UncInStudyProgram

DROP TABLE IF EXISTS kuntur.unc_in_study_program CASCADE;

CREATE TABLE kuntur.unc_in_study_program
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- careerCode
	career_code VARCHAR NOT NULL, 

	-- subject
	subject VARCHAR NOT NULL, 

	-- approved
	approved BOOLEAN, 

	-- approvedBy
	approved_by VARCHAR, 

	-- fileNumber
	file_number VARCHAR, 

	-- comment
	comment VARCHAR, 

	-- uncInEnrrollment
	unc_in_enrrollment_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: UncInGradingScale

DROP TABLE IF EXISTS kuntur.unc_in_grading_scale CASCADE;

CREATE TABLE kuntur.unc_in_grading_scale
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- rateNumber
	rate_number INTEGER UNIQUE NOT NULL, 

	-- rateLetter
	rate_letter VARCHAR NOT NULL, 

	-- careerType
	career_type VARCHAR NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: UncInStudiedType

DROP TABLE IF EXISTS kuntur.unc_in_studied_type CASCADE;

CREATE TABLE kuntur.unc_in_studied_type
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- code
	code VARCHAR UNIQUE NOT NULL, 

	-- name
	name VARCHAR UNIQUE NOT NULL, 

	-- comment
	comment VARCHAR
);

----------------------------------------------------------------------------------------

-- TABLA: UncInAcademicPerformance

DROP TABLE IF EXISTS kuntur.unc_in_academic_performance CASCADE;

CREATE TABLE kuntur.unc_in_academic_performance
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- careerCode
	career_code VARCHAR NOT NULL, 

	-- subject
	subject VARCHAR NOT NULL, 

	-- approved
	approved BOOLEAN, 

	-- approvedBy
	approved_by VARCHAR, 

	-- fileNumber
	file_number VARCHAR NOT NULL, 

	-- hs
	hs DOUBLE PRECISION NOT NULL, 

	-- uncInEnrrollment
	unc_in_enrrollment_id VARCHAR  NOT NULL, 

	-- uncInGradingScale
	unc_in_grading_scale_id VARCHAR  NOT NULL, 

	-- uncInStudiedType
	unc_in_studied_type_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: UncInAcademicCoordinator

DROP TABLE IF EXISTS kuntur.unc_in_academic_coordinator CASCADE;

CREATE TABLE kuntur.unc_in_academic_coordinator
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- person
	person_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------

-- TABLA: UncInAcademicOffice

DROP TABLE IF EXISTS kuntur.unc_in_academic_office CASCADE;

CREATE TABLE kuntur.unc_in_academic_office
(

	-- id
	id VARCHAR PRIMARY KEY  NOT NULL, 

	-- erased
	erased BOOLEAN NOT NULL, 

	-- person
	person_id VARCHAR  NOT NULL, 

	-- org
	org_id VARCHAR  NOT NULL
);

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_email ADD CONSTRAINT person_email_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_phone ADD CONSTRAINT person_phone_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_identity ADD CONSTRAINT person_identity_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_identity ADD CONSTRAINT person_identity_person_identity_type_id_fkey FOREIGN KEY (person_identity_type_id) REFERENCES kuntur.person_identity_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_nationality ADD CONSTRAINT person_nationality_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_address ADD CONSTRAINT person_address_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.user_group ADD CONSTRAINT user_group_group_system_id_fkey FOREIGN KEY (group_system_id) REFERENCES kuntur.group_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.user_group ADD CONSTRAINT user_group_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org ADD CONSTRAINT org_org_type_id_fkey FOREIGN KEY (org_type_id) REFERENCES kuntur.org_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org ADD CONSTRAINT org_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org ADD CONSTRAINT org_org_x_id_fkey FOREIGN KEY (org_x_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org_email ADD CONSTRAINT org_email_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org_phone ADD CONSTRAINT org_phone_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org_address ADD CONSTRAINT org_address_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.contact ADD CONSTRAINT contact_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.contact ADD CONSTRAINT contact_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.student ADD CONSTRAINT student_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_contact ADD CONSTRAINT agreement_contact_agreement_item_id_fkey FOREIGN KEY (agreement_item_id) REFERENCES kuntur.agreement_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_contact ADD CONSTRAINT agreement_contact_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES kuntur.contact (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement ADD CONSTRAINT agreement_agreement_type_id_fkey FOREIGN KEY (agreement_type_id) REFERENCES kuntur.agreement_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement ADD CONSTRAINT agreement_agreement_status_id_fkey FOREIGN KEY (agreement_status_id) REFERENCES kuntur.agreement_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement ADD CONSTRAINT agreement_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item ADD CONSTRAINT agreement_item_agreement_id_fkey FOREIGN KEY (agreement_id) REFERENCES kuntur.agreement (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item ADD CONSTRAINT agreement_item_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item_ou ADD CONSTRAINT agreement_item_ou_agreement_item_id_fkey FOREIGN KEY (agreement_item_id) REFERENCES kuntur.agreement_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item_ou ADD CONSTRAINT agreement_item_ou_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item_ou ADD CONSTRAINT admission_period_item_ou_admission_period_item_id_fkey FOREIGN KEY (admission_period_item_id) REFERENCES kuntur.admission_period_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item_ou ADD CONSTRAINT admission_period_item_ou_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period ADD CONSTRAINT admission_period_admission_period_status_id_fkey FOREIGN KEY (admission_period_status_id) REFERENCES kuntur.admission_period_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_agreement ADD CONSTRAINT admission_period_agreement_agreement_id_fkey FOREIGN KEY (agreement_id) REFERENCES kuntur.agreement (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_agreement ADD CONSTRAINT admission_period_agreement_admission_period_id_fkey FOREIGN KEY (admission_period_id) REFERENCES kuntur.admission_period (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item ADD CONSTRAINT admission_period_item_admission_period_id_fkey FOREIGN KEY (admission_period_id) REFERENCES kuntur.admission_period (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item ADD CONSTRAINT admission_period_item_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_contact ADD CONSTRAINT admission_period_contact_admission_period_item_id_fkey FOREIGN KEY (admission_period_item_id) REFERENCES kuntur.admission_period_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_contact ADD CONSTRAINT admission_period_contact_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES kuntur.contact (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES kuntur.student (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_admission_period_id_fkey FOREIGN KEY (admission_period_id) REFERENCES kuntur.admission_period (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_enrrollment_status_id_fkey FOREIGN KEY (enrrollment_status_id) REFERENCES kuntur.enrrollment_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_chat ADD CONSTRAINT enrrollment_chat_user_system_a_id_fkey FOREIGN KEY (user_system_a_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_chat ADD CONSTRAINT enrrollment_chat_user_system_b_id_fkey FOREIGN KEY (user_system_b_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_chat ADD CONSTRAINT enrrollment_chat_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_stakeholder ADD CONSTRAINT enrrollment_stakeholder_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_stakeholder ADD CONSTRAINT enrrollment_stakeholder_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_email ADD CONSTRAINT enrrollment_email_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_phone ADD CONSTRAINT enrrollment_phone_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_identity ADD CONSTRAINT enrrollment_identity_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_identity ADD CONSTRAINT enrrollment_identity_person_identity_type_id_fkey FOREIGN KEY (person_identity_type_id) REFERENCES kuntur.person_identity_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_nationality ADD CONSTRAINT enrrollment_nationality_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_address ADD CONSTRAINT enrrollment_address_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_enrrollment_status_a_id_fkey FOREIGN KEY (enrrollment_status_a_id) REFERENCES kuntur.enrrollment_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_enrrollment_status_b_id_fkey FOREIGN KEY (enrrollment_status_b_id) REFERENCES kuntur.enrrollment_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_study_program ADD CONSTRAINT unc_in_study_program_unc_in_enrrollment_id_fkey FOREIGN KEY (unc_in_enrrollment_id) REFERENCES kuntur.unc_in_enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_study_program ADD CONSTRAINT unc_in_study_program_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_unc_in_enrrollment_id_fkey FOREIGN KEY (unc_in_enrrollment_id) REFERENCES kuntur.unc_in_enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_unc_in_grading_scale_id_fkey FOREIGN KEY (unc_in_grading_scale_id) REFERENCES kuntur.unc_in_grading_scale (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_unc_in_studied_type_id_fkey FOREIGN KEY (unc_in_studied_type_id) REFERENCES kuntur.unc_in_studied_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_coordinator ADD CONSTRAINT unc_in_academic_coordinator_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_coordinator ADD CONSTRAINT unc_in_academic_coordinator_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_office ADD CONSTRAINT unc_in_academic_office_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_office ADD CONSTRAINT unc_in_academic_office_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;