--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.14
-- Dumped by pg_dump version 9.1.14
-- Started on 2015-07-30 00:55:23 ART

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 1259987)
-- Name: model; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA model;


ALTER SCHEMA model OWNER TO postgres;

SET search_path = model, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 1259988)
-- Dependencies: 6
-- Name: academic_unit; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE academic_unit (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    code_b character varying,
    short_name character varying,
    name character varying,
    comment character varying,
    url_logo character varying,
    au_type_id character varying,
    edu_institution_id character varying,
    academic_unit_parent_id character varying
);


ALTER TABLE model.academic_unit OWNER TO postgres;

--
-- TOC entry 2127 (class 0 OID 0)
-- Dependencies: 162
-- Name: TABLE academic_unit; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE academic_unit IS 'Unidad Académica [Map Class: org.nahuel.model.edu.au.AcademicUnit]';


--
-- TOC entry 2128 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.id IS 'ID [Map Class: org.nahuel.model.edu.au.AcademicUnit.id]';


--
-- TOC entry 2129 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.au.AcademicUnit.stateEnable]';


--
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.code IS 'Código [Map Class: org.nahuel.model.edu.au.AcademicUnit.code]';


--
-- TOC entry 2131 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.code_b; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.code_b IS 'Código [Map Class: org.nahuel.model.edu.au.AcademicUnit.codeB]';


--
-- TOC entry 2132 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.short_name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.short_name IS 'Nombre Corto [Map Class: org.nahuel.model.edu.au.AcademicUnit.shortName]';


--
-- TOC entry 2133 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.name IS 'Nombre [Map Class: org.nahuel.model.edu.au.AcademicUnit.name]';


--
-- TOC entry 2134 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.comment IS 'Comentario [Map Class: org.nahuel.model.edu.au.AcademicUnit.comment]';


--
-- TOC entry 2135 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.url_logo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.url_logo IS 'Logo [Map Class: org.nahuel.model.edu.au.AcademicUnit.urlLogo]';


--
-- TOC entry 2136 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.au_type_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.au_type_id IS ' [Map Class: org.nahuel.model.edu.au.AcademicUnit.auType]';


--
-- TOC entry 2137 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.edu_institution_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.edu_institution_id IS ' [Map Class: org.nahuel.model.edu.au.AcademicUnit.eduInstitution]';


--
-- TOC entry 2138 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN academic_unit.academic_unit_parent_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN academic_unit.academic_unit_parent_id IS ' [Map Class: org.nahuel.model.edu.au.AcademicUnit.academicUnitParent]';


--
-- TOC entry 163 (class 1259 OID 1259994)
-- Dependencies: 6
-- Name: agreement_title; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE agreement_title (
    id character varying NOT NULL,
    state_enable boolean,
    agreement character varying,
    comment character varying,
    title_id character varying,
    edu_institution_id character varying,
    academic_unit_id character varying
);


ALTER TABLE model.agreement_title OWNER TO postgres;

--
-- TOC entry 2139 (class 0 OID 0)
-- Dependencies: 163
-- Name: TABLE agreement_title; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE agreement_title IS 'Convenio de Título [Map Class: org.nahuel.model.edu.career.title.AgreementTitle]';


--
-- TOC entry 2140 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.id IS 'ID [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.id]';


--
-- TOC entry 2141 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.stateEnable]';


--
-- TOC entry 2142 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.agreement; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.agreement IS 'Convenio [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.agreement]';


--
-- TOC entry 2143 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.comment]';


--
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.title_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.title_id IS ' [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.title]';


--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.edu_institution_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.edu_institution_id IS ' [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.eduInstitution]';


--
-- TOC entry 2146 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN agreement_title.academic_unit_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN agreement_title.academic_unit_id IS ' [Map Class: org.nahuel.model.edu.career.title.AgreementTitle.academicUnit]';


--
-- TOC entry 164 (class 1259 OID 1260000)
-- Dependencies: 6
-- Name: au_type; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE au_type (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying
);


ALTER TABLE model.au_type OWNER TO postgres;

--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE au_type; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE au_type IS 'Tipo de Unidad Académica [Map Class: org.nahuel.model.edu.au.AuType]';


--
-- TOC entry 2148 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN au_type.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN au_type.id IS 'ID [Map Class: org.nahuel.model.edu.au.AuType.id]';


--
-- TOC entry 2149 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN au_type.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN au_type.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.au.AuType.stateEnable]';


--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN au_type.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN au_type.code IS 'Código [Map Class: org.nahuel.model.edu.au.AuType.code]';


--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN au_type.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN au_type.name IS 'Nombre [Map Class: org.nahuel.model.edu.au.AuType.name]';


--
-- TOC entry 2152 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN au_type.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN au_type.comment IS 'Comentario [Map Class: org.nahuel.model.edu.au.AuType.comment]';


--
-- TOC entry 165 (class 1259 OID 1260006)
-- Dependencies: 6
-- Name: career; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE career (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying,
    career_type_id character varying,
    edu_institution_id character varying,
    academic_unit_id character varying,
    career_state_id character varying
);


ALTER TABLE model.career OWNER TO postgres;

--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE career; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE career IS 'Carrera [Map Class: org.nahuel.model.edu.career.Career]';


--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.id IS 'ID [Map Class: org.nahuel.model.edu.career.Career.id]';


--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.Career.stateEnable]';


--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.code IS 'Código [Map Class: org.nahuel.model.edu.career.Career.code]';


--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.name IS 'Nombre [Map Class: org.nahuel.model.edu.career.Career.name]';


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.Career.comment]';


--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.career_type_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.career_type_id IS ' [Map Class: org.nahuel.model.edu.career.Career.careerType]';


--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.edu_institution_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.edu_institution_id IS ' [Map Class: org.nahuel.model.edu.career.Career.eduInstitution]';


--
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.academic_unit_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.academic_unit_id IS ' [Map Class: org.nahuel.model.edu.career.Career.academicUnit]';


--
-- TOC entry 2162 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN career.career_state_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career.career_state_id IS ' [Map Class: org.nahuel.model.edu.career.Career.careerState]';


--
-- TOC entry 166 (class 1259 OID 1260012)
-- Dependencies: 6
-- Name: career_state; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE career_state (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying
);


ALTER TABLE model.career_state OWNER TO postgres;

--
-- TOC entry 2163 (class 0 OID 0)
-- Dependencies: 166
-- Name: TABLE career_state; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE career_state IS 'Estado de Carrera [Map Class: org.nahuel.model.edu.career.CareerState]';


--
-- TOC entry 2164 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN career_state.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_state.id IS 'ID [Map Class: org.nahuel.model.edu.career.CareerState.id]';


--
-- TOC entry 2165 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN career_state.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_state.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.CareerState.stateEnable]';


--
-- TOC entry 2166 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN career_state.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_state.code IS 'Código [Map Class: org.nahuel.model.edu.career.CareerState.code]';


--
-- TOC entry 2167 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN career_state.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_state.name IS 'Nombre [Map Class: org.nahuel.model.edu.career.CareerState.name]';


--
-- TOC entry 2168 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN career_state.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_state.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.CareerState.comment]';


--
-- TOC entry 167 (class 1259 OID 1260018)
-- Dependencies: 6
-- Name: career_type; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE career_type (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying
);


ALTER TABLE model.career_type OWNER TO postgres;

--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE career_type; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE career_type IS 'Tipo de Carrera [Map Class: org.nahuel.model.edu.career.CareerType]';


--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN career_type.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_type.id IS 'ID [Map Class: org.nahuel.model.edu.career.CareerType.id]';


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN career_type.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_type.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.CareerType.stateEnable]';


--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN career_type.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_type.code IS 'Código [Map Class: org.nahuel.model.edu.career.CareerType.code]';


--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN career_type.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_type.name IS 'Nombre [Map Class: org.nahuel.model.edu.career.CareerType.name]';


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN career_type.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN career_type.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.CareerType.comment]';


--
-- TOC entry 168 (class 1259 OID 1260024)
-- Dependencies: 6
-- Name: edu_institution; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE edu_institution (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    short_name character varying,
    name character varying,
    comment character varying,
    url_logo character varying,
    primary_institution boolean
);


ALTER TABLE model.edu_institution OWNER TO postgres;

--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 168
-- Name: TABLE edu_institution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE edu_institution IS 'Institución Educativa [Map Class: org.nahuel.model.edu.EduInstitution]';


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.id IS 'ID [Map Class: org.nahuel.model.edu.EduInstitution.id]';


--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.EduInstitution.stateEnable]';


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.code IS 'Código [Map Class: org.nahuel.model.edu.EduInstitution.code]';


--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.short_name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.short_name IS 'Nombre Corto [Map Class: org.nahuel.model.edu.EduInstitution.shortName]';


--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.name IS 'Nombre [Map Class: org.nahuel.model.edu.EduInstitution.name]';


--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.comment IS 'Comentario [Map Class: org.nahuel.model.edu.EduInstitution.comment]';


--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.url_logo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.url_logo IS 'Logo [Map Class: org.nahuel.model.edu.EduInstitution.urlLogo]';


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN edu_institution.primary_institution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN edu_institution.primary_institution IS 'Primario [Map Class: org.nahuel.model.edu.EduInstitution.primaryInstitution]';


--
-- TOC entry 169 (class 1259 OID 1260030)
-- Dependencies: 6
-- Name: mig_codigos_internos_peu; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE mig_codigos_internos_peu (
    codigo_interno character varying,
    codigo_ona integer,
    titulo character varying,
    carrera character varying,
    tipo_titulo character varying,
    modalidad character varying,
    nro_norma character varying,
    fecha_norma character varying,
    lote character varying
);


ALTER TABLE model.mig_codigos_internos_peu OWNER TO postgres;

--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE mig_codigos_internos_peu; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE mig_codigos_internos_peu IS 'Codigos Internos PEU - PROVISORIO_LISTADO DE CARRERAS_TITULOS_CON CODIGO INTERNO Y ONA.xls [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu]';


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.codigo_interno; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.codigo_interno IS ' [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.codigoInterno]';


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.codigo_ona; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.codigo_ona IS 'title.code [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.codigoOna]';


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.titulo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.titulo IS ' [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.titulo]';


--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.carrera; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.carrera IS ' [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.carrera]';


--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.tipo_titulo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.tipo_titulo IS 'title.title_type [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.tipoTitulo]';


--
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.modalidad; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.modalidad IS 'title.title_mode [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.modalidad]';


--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.nro_norma; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.nro_norma IS 'title.title_resolution.resolution [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.nroNorma]';


--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.fecha_norma; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.fecha_norma IS 'title.title_resolution.resolution [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.fechaNorma]';


--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN mig_codigos_internos_peu.lote; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_codigos_internos_peu.lote IS ' [Map Class: org.nahuel.model.mig.MigCodigosInternosPeu.lote]';


--
-- TOC entry 170 (class 1259 OID 1260036)
-- Dependencies: 6
-- Name: mig_ofertas_araucano; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE mig_ofertas_araucano (
    id_unidad_academica_araucano character varying,
    unidad_academica character varying,
    id_oferta_oficial character varying,
    id_titulo_oficial character varying,
    codigo_titulo_ona integer,
    denominacion character varying,
    modalidad character varying,
    tipo_titulo character varying,
    activa character varying,
    oficial character varying,
    lote character varying
);


ALTER TABLE model.mig_ofertas_araucano OWNER TO postgres;

--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 170
-- Name: TABLE mig_ofertas_araucano; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE mig_ofertas_araucano IS 'Ofertas Araucano - Ofertas Cordoba.xls [Map Class: org.nahuel.model.mig.MigOfertasAraucano]';


--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.id_unidad_academica_araucano; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.id_unidad_academica_araucano IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.idUnidadAcademicaAraucano]';


--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.unidad_academica; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.unidad_academica IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.unidadAcademica]';


--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.id_oferta_oficial; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.id_oferta_oficial IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.idOfertaOficial]';


--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.id_titulo_oficial; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.id_titulo_oficial IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.idTituloOficial]';


--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.codigo_titulo_ona; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.codigo_titulo_ona IS 'title.code [Map Class: org.nahuel.model.mig.MigOfertasAraucano.codigoTituloOna]';


--
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.denominacion; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.denominacion IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.denominacion]';


--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.modalidad; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.modalidad IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.modalidad]';


--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.tipo_titulo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.tipo_titulo IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.tipoTitulo]';


--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.activa; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.activa IS 'title.title_state [Map Class: org.nahuel.model.mig.MigOfertasAraucano.activa]';


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.oficial; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.oficial IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.oficial]';


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN mig_ofertas_araucano.lote; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_araucano.lote IS ' [Map Class: org.nahuel.model.mig.MigOfertasAraucano.lote]';


--
-- TOC entry 171 (class 1259 OID 1260042)
-- Dependencies: 6
-- Name: mig_ofertas_guarani; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE mig_ofertas_guarani (
    unidad_academica character varying,
    nombre character varying,
    valor character varying,
    instituc_araucano character varying,
    titulo character varying,
    nombre_titulo character varying,
    nombre_titulo_femenino character varying,
    nivel character varying,
    tipo_de_titulo character varying,
    tipo_diploma character varying,
    tipo_diploma_codigo character varying,
    nro_resolucion character varying,
    fecha_resolucion character varying,
    nro_res_minist character varying,
    fecha_res_minist character varying,
    titulo_araucano integer,
    carrera character varying,
    nombre_carrera character varying,
    lote character varying
);


ALTER TABLE model.mig_ofertas_guarani OWNER TO postgres;

--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE mig_ofertas_guarani; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE mig_ofertas_guarani IS 'Ofertas Guarani - oferta UNC ampliado Guarani.xls [Map Class: org.nahuel.model.mig.MigOfertasGuarani]';


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.unidad_academica; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.unidad_academica IS 'career.acdemic_unit [Map Class: org.nahuel.model.mig.MigOfertasGuarani.unidadAcademica]';


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nombre; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nombre IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nombre]';


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.valor; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.valor IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.valor]';


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.instituc_araucano; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.instituc_araucano IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.institucAraucano]';


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.titulo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.titulo IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.titulo]';


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nombre_titulo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nombre_titulo IS 'title.title [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nombreTitulo]';


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nombre_titulo_femenino; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nombre_titulo_femenino IS 'title.female_title [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nombreTituloFemenino]';


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nivel; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nivel IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nivel]';


--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.tipo_de_titulo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.tipo_de_titulo IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.tipoDeTitulo]';


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.tipo_diploma; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.tipo_diploma IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.tipoDiploma]';


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.tipo_diploma_codigo; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.tipo_diploma_codigo IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.tipoDiplomaCodigo]';


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nro_resolucion; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nro_resolucion IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nroResolucion]';


--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.fecha_resolucion; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.fecha_resolucion IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.fechaResolucion]';


--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nro_res_minist; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nro_res_minist IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nroResMinist]';


--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.fecha_res_minist; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.fecha_res_minist IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.fechaResMinist]';


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.titulo_araucano; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.titulo_araucano IS 'title.code [Map Class: org.nahuel.model.mig.MigOfertasGuarani.tituloAraucano]';


--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.carrera; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.carrera IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.carrera]';


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.nombre_carrera; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.nombre_carrera IS 'career.name [Map Class: org.nahuel.model.mig.MigOfertasGuarani.nombreCarrera]';


--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN mig_ofertas_guarani.lote; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN mig_ofertas_guarani.lote IS ' [Map Class: org.nahuel.model.mig.MigOfertasGuarani.lote]';


--
-- TOC entry 172 (class 1259 OID 1260048)
-- Dependencies: 6
-- Name: mig_ofertas_guarani_2014; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE mig_ofertas_guarani_2014 (
    codigo_ua character varying(80),
    nombre_ua character varying(100),
    ua character varying(100),
    instituc_araucano character varying(80),
    titulo character varying(80),
    titulo_nombre character varying(250),
    titulo_nombre_femenino character varying(250),
    nivel character varying(80),
    tipo_de_titulo character varying(80),
    tipo_diploma character varying(80),
    tipo_diploma_codigo integer,
    nro_resolucion character varying(80),
    fecha_resolucion date,
    nro_res_minist character varying(80),
    fecha_res_minist character varying(80),
    titulo_araucano integer,
    carrera character varying(80),
    nombre_carrera character varying(250),
    lote character varying(80)
);


ALTER TABLE model.mig_ofertas_guarani_2014 OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 1260054)
-- Dependencies: 6
-- Name: resolution; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE resolution (
    id character varying NOT NULL,
    state_enable boolean,
    type_resolution_id character varying,
    number_resolution character varying,
    year_resolution integer,
    date_resolution date
);


ALTER TABLE model.resolution OWNER TO postgres;

--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE resolution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE resolution IS 'Resolución de Carrera y/o Título [Map Class: org.nahuel.model.edu.resolution.Resolution]';


--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN resolution.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution.id IS 'ID [Map Class: org.nahuel.model.edu.resolution.Resolution.id]';


--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN resolution.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.resolution.Resolution.stateEnable]';


--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN resolution.type_resolution_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution.type_resolution_id IS ' [Map Class: org.nahuel.model.edu.resolution.Resolution.typeResolution]';


--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN resolution.number_resolution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution.number_resolution IS 'N° de Resolución [Map Class: org.nahuel.model.edu.resolution.Resolution.numberResolution]';


--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN resolution.year_resolution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution.year_resolution IS 'Año de Resolución [Map Class: org.nahuel.model.edu.resolution.Resolution.yearResolution]';


--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN resolution.date_resolution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution.date_resolution IS 'Fecha de Resolución [Map Class: org.nahuel.model.edu.resolution.Resolution.dateResolution]';


--
-- TOC entry 174 (class 1259 OID 1260060)
-- Dependencies: 6
-- Name: resolution_type; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE resolution_type (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying
);


ALTER TABLE model.resolution_type OWNER TO postgres;

--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE resolution_type; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE resolution_type IS 'Tipo de Resolución [Map Class: org.nahuel.model.edu.resolution.ResolutionType]';


--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN resolution_type.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution_type.id IS 'ID [Map Class: org.nahuel.model.edu.resolution.ResolutionType.id]';


--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN resolution_type.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution_type.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.resolution.ResolutionType.stateEnable]';


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN resolution_type.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution_type.code IS 'Código [Map Class: org.nahuel.model.edu.resolution.ResolutionType.code]';


--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN resolution_type.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution_type.name IS 'Nombre [Map Class: org.nahuel.model.edu.resolution.ResolutionType.name]';


--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN resolution_type.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN resolution_type.comment IS 'Comentario [Map Class: org.nahuel.model.edu.resolution.ResolutionType.comment]';


--
-- TOC entry 175 (class 1259 OID 1260066)
-- Dependencies: 6
-- Name: title; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE title (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    title character varying,
    female_title character varying,
    title_type_id character varying,
    title_mode_id character varying,
    comment character varying,
    cg boolean,
    career_id character varying,
    title_state_id character varying
);


ALTER TABLE model.title OWNER TO postgres;

--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE title; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE title IS 'Título [Map Class: org.nahuel.model.edu.career.title.Title]';


--
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.id IS 'ID [Map Class: org.nahuel.model.edu.career.title.Title.id]';


--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.title.Title.stateEnable]';


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.code IS 'Código [Map Class: org.nahuel.model.edu.career.title.Title.code]';


--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.title; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.title IS 'Título [Map Class: org.nahuel.model.edu.career.title.Title.title]';


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.female_title; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.female_title IS 'Título Femenino [Map Class: org.nahuel.model.edu.career.title.Title.femaleTitle]';


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.title_type_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.title_type_id IS ' [Map Class: org.nahuel.model.edu.career.title.Title.titleType]';


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.title_mode_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.title_mode_id IS ' [Map Class: org.nahuel.model.edu.career.title.Title.titleMode]';


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.title.Title.comment]';


--
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.cg; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.cg IS 'Co-Gestión [Map Class: org.nahuel.model.edu.career.title.Title.cg]';


--
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.career_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.career_id IS ' [Map Class: org.nahuel.model.edu.career.title.Title.career]';


--
-- TOC entry 2250 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN title.title_state_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title.title_state_id IS ' [Map Class: org.nahuel.model.edu.career.title.Title.titleState]';


--
-- TOC entry 176 (class 1259 OID 1260072)
-- Dependencies: 6
-- Name: title_mode; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE title_mode (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying
);


ALTER TABLE model.title_mode OWNER TO postgres;

--
-- TOC entry 2251 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE title_mode; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE title_mode IS 'Modalidad de Título [Map Class: org.nahuel.model.edu.career.title.TitleMode]';


--
-- TOC entry 2252 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN title_mode.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_mode.id IS 'ID [Map Class: org.nahuel.model.edu.career.title.TitleMode.id]';


--
-- TOC entry 2253 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN title_mode.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_mode.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.title.TitleMode.stateEnable]';


--
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN title_mode.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_mode.code IS 'Código [Map Class: org.nahuel.model.edu.career.title.TitleMode.code]';


--
-- TOC entry 2255 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN title_mode.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_mode.name IS 'Nombre [Map Class: org.nahuel.model.edu.career.title.TitleMode.name]';


--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN title_mode.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_mode.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.title.TitleMode.comment]';


--
-- TOC entry 177 (class 1259 OID 1260078)
-- Dependencies: 6
-- Name: title_resolution; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE title_resolution (
    id character varying NOT NULL,
    state_enable boolean,
    title_id character varying,
    resolution_id character varying
);


ALTER TABLE model.title_resolution OWNER TO postgres;

--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE title_resolution; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE title_resolution IS 'Resolución de Carrera y/o Título [Map Class: org.nahuel.model.edu.career.title.TitleResolution]';


--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN title_resolution.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_resolution.id IS 'ID [Map Class: org.nahuel.model.edu.career.title.TitleResolution.id]';


--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN title_resolution.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_resolution.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.title.TitleResolution.stateEnable]';


--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN title_resolution.title_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_resolution.title_id IS ' [Map Class: org.nahuel.model.edu.career.title.TitleResolution.title]';


--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN title_resolution.resolution_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_resolution.resolution_id IS ' [Map Class: org.nahuel.model.edu.career.title.TitleResolution.resolution]';


--
-- TOC entry 178 (class 1259 OID 1260084)
-- Dependencies: 6
-- Name: title_state; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE title_state (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    comment character varying
);


ALTER TABLE model.title_state OWNER TO postgres;

--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE title_state; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE title_state IS 'Estado de Título [Map Class: org.nahuel.model.edu.career.title.TitleState]';


--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN title_state.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_state.id IS 'ID [Map Class: org.nahuel.model.edu.career.title.TitleState.id]';


--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN title_state.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_state.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.title.TitleState.stateEnable]';


--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN title_state.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_state.code IS 'Código [Map Class: org.nahuel.model.edu.career.title.TitleState.code]';


--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN title_state.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_state.name IS 'Nombre [Map Class: org.nahuel.model.edu.career.title.TitleState.name]';


--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN title_state.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_state.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.title.TitleState.comment]';


--
-- TOC entry 179 (class 1259 OID 1260090)
-- Dependencies: 6
-- Name: title_type; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE title_type (
    id character varying NOT NULL,
    state_enable boolean,
    code character varying,
    name character varying,
    career_type_id character varying,
    comment character varying
);


ALTER TABLE model.title_type OWNER TO postgres;

--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE title_type; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE title_type IS 'Tipo de Título [Map Class: org.nahuel.model.edu.career.title.TitleType]';


--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN title_type.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_type.id IS 'ID [Map Class: org.nahuel.model.edu.career.title.TitleType.id]';


--
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN title_type.state_enable; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_type.state_enable IS 'Vigente [Map Class: org.nahuel.model.edu.career.title.TitleType.stateEnable]';


--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN title_type.code; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_type.code IS 'Código [Map Class: org.nahuel.model.edu.career.title.TitleType.code]';


--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN title_type.name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_type.name IS 'Nombre [Map Class: org.nahuel.model.edu.career.title.TitleType.name]';


--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN title_type.career_type_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_type.career_type_id IS ' [Map Class: org.nahuel.model.edu.career.title.TitleType.careerType]';


--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN title_type.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN title_type.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.title.TitleType.comment]';


--
-- TOC entry 187 (class 1259 OID 1290383)
-- Dependencies: 2102 6
-- Name: v_career_title; Type: VIEW; Schema: model; Owner: postgres
--

CREATE VIEW v_career_title AS
    SELECT ei.id AS edu_institution_id, ei.code AS edu_institution_code, ei.short_name AS edu_institution_name, ei.primary_institution AS edu_institution_primary_institution, ei.state_enable AS edu_institution_state_enable, ("substring"((public.au_path_code(''::character varying, c.academic_unit_id))::text, 4, length((public.au_path_code(''::character varying, c.academic_unit_id))::text)))::character varying AS path_code_guarani_ua, ("substring"((public.au_path(''::character varying, c.academic_unit_id))::text, 4, length((public.au_path(''::character varying, c.academic_unit_id))::text)))::character varying AS path_ua, au.id AS academic_unit_id, au.code AS academic_unit_code, au.code_b AS academic_unit_code_b, au.short_name AS academic_unit_short_name, au.name AS academic_unit_name, au.academic_unit_parent_id, au.state_enable AS academic_unit_state_enable, aut.id AS au_type_id, aut.code AS au_type_code, aut.name AS au_type_name, aut.state_enable AS au_type_state_enable, c.id AS career_id, c.code AS career_code, c.name AS career_name, c.state_enable AS career_state_enable, ct.id AS career_type_id, ct.code AS career_type_code, ct.name AS career_type_name, ct.state_enable AS career_type_state_enable, cs.id AS career_state_id, cs.code AS career_state_code, cs.name AS career_state_name, cs.state_enable AS career_state_state_enable, t.id AS title_id, t.code AS title_code, t.title, t.female_title AS title_female_title, t.cg AS title_cg, t.state_enable AS title_state_enable, tt.id AS title_type_id, tt.code AS title_type_code, tt.name AS title_type_name, tt.state_enable AS title_type_state_enable, tm.id AS title_mode_id, tm.code AS title_mode_code, tm.name AS title_mode_name, tm.state_enable AS title_mode_state_enable, ts.id AS title_state_id, ts.code AS title_state_code, ts.name AS title_state_name, ts.state_enable AS title_state_state_enable, tr.id AS title_resolution_id, tr.state_enable AS title_resolution_state_enable, r.id AS resolution_id, r.number_resolution AS titulo_resol_num, r.year_resolution AS titulo_resol_anio, r.date_resolution AS titulo_resol_fecha, r.state_enable AS resolution_state_enable, rt.id AS resolution_type_id, rt.code AS resolution_type_code, rt.name AS resolution_type_name, rt.state_enable AS resolution_type_state_enable FROM ((((((((((((title t LEFT JOIN title_type tt ON (((tt.id)::text = (t.title_type_id)::text))) LEFT JOIN title_mode tm ON (((tm.id)::text = (t.title_mode_id)::text))) LEFT JOIN title_state ts ON (((ts.id)::text = (t.title_state_id)::text))) LEFT JOIN title_resolution tr ON (((tr.title_id)::text = (t.id)::text))) LEFT JOIN resolution r ON (((r.id)::text = (tr.resolution_id)::text))) LEFT JOIN resolution_type rt ON (((rt.id)::text = (r.type_resolution_id)::text))) LEFT JOIN career c ON (((c.id)::text = (t.career_id)::text))) LEFT JOIN career_type ct ON (((ct.id)::text = (c.career_type_id)::text))) LEFT JOIN career_state cs ON (((cs.id)::text = (c.career_state_id)::text))) LEFT JOIN academic_unit au ON (((au.id)::text = (c.academic_unit_id)::text))) LEFT JOIN au_type aut ON (((aut.id)::text = (au.au_type_id)::text))) LEFT JOIN edu_institution ei ON (((ei.id)::text = (au.edu_institution_id)::text))) ORDER BY ei.short_name, ("substring"((public.au_path(''::character varying, c.academic_unit_id))::text, 4, length((public.au_path(''::character varying, c.academic_unit_id))::text)))::character varying, ct.code, cs.name, tt.code, ts.name;


ALTER TABLE model.v_career_title OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 1260096)
-- Dependencies: 6
-- Name: version_career; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE version_career (
    id character varying NOT NULL,
    comment character varying,
    career_id character varying,
    url_serialized_object character varying,
    user_id character varying,
    user_name character varying,
    name_physical_person character varying,
    last_name_physical_person character varying,
    code_identification_type_person character varying,
    identification_type_person character varying,
    identification_person character varying,
    type_event_version character varying,
    event_type character varying,
    date_event timestamp without time zone,
    version_label character varying,
    version bigint
);


ALTER TABLE model.version_career OWNER TO postgres;

--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 180
-- Name: TABLE version_career; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE version_career IS 'Historial de Versiones [Map Class: org.nahuel.model.edu.career.version.VersionCareer]';


--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.id IS 'ID [Map Class: org.nahuel.model.edu.career.version.VersionCareer.id]';


--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.version.VersionCareer.comment]';


--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.career_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.career_id IS ' [Map Class: org.nahuel.model.edu.career.version.VersionCareer.career]';


--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.url_serialized_object; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.url_serialized_object IS 'URL Objeto Serializado [Map Class: org.nahuel.model.edu.career.version.VersionCareer.urlSerializedObject]';


--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.user_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.user_id IS 'Usuario [Map Class: org.nahuel.model.edu.career.version.VersionCareer.userId]';


--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.user_name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.user_name IS 'Usuario [Map Class: org.nahuel.model.edu.career.version.VersionCareer.userName]';


--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.name_physical_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.name_physical_person IS 'Nombre Persona [Map Class: org.nahuel.model.edu.career.version.VersionCareer.namePhysicalPerson]';


--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.last_name_physical_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.last_name_physical_person IS 'Apellido Persona [Map Class: org.nahuel.model.edu.career.version.VersionCareer.lastNamePhysicalPerson]';


--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.code_identification_type_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.code_identification_type_person IS 'Tipo de Documento de Identificación Personal [Map Class: org.nahuel.model.edu.career.version.VersionCareer.codeIdentificationTypePerson]';


--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.identification_type_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.identification_type_person IS 'Tipo de Documento de Identificación Personal [Map Class: org.nahuel.model.edu.career.version.VersionCareer.identificationTypePerson]';


--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.identification_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.identification_person IS 'Número Documento Persona [Map Class: org.nahuel.model.edu.career.version.VersionCareer.identificationPerson]';


--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.type_event_version; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.type_event_version IS ' [Map Class: org.nahuel.model.edu.career.version.VersionCareer.typeEventVersion]';


--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.event_type; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.event_type IS 'Tipo de Evento [Map Class: org.nahuel.model.edu.career.version.VersionCareer.eventType]';


--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.date_event; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.date_event IS 'Fecha hora del Evento [Map Class: org.nahuel.model.edu.career.version.VersionCareer.dateEvent]';


--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.version_label; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.version_label IS 'Etiqueta de Version [Map Class: org.nahuel.model.edu.career.version.VersionCareer.versionLabel]';


--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN version_career.version; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_career.version IS 'Version [Map Class: org.nahuel.model.edu.career.version.VersionCareer.version]';


--
-- TOC entry 181 (class 1259 OID 1260102)
-- Dependencies: 6
-- Name: version_title; Type: TABLE; Schema: model; Owner: postgres; Tablespace: 
--

CREATE TABLE version_title (
    id character varying NOT NULL,
    comment character varying,
    title_id character varying,
    url_serialized_object character varying,
    user_id character varying,
    user_name character varying,
    name_physical_person character varying,
    last_name_physical_person character varying,
    code_identification_type_person character varying,
    identification_type_person character varying,
    identification_person character varying,
    type_event_version character varying,
    event_type character varying,
    date_event timestamp without time zone,
    version_label character varying,
    version bigint
);


ALTER TABLE model.version_title OWNER TO postgres;

--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE version_title; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON TABLE version_title IS 'Historial de Versiones [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle]';


--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.id IS 'ID [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.id]';


--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.comment; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.comment IS 'Comentario [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.comment]';


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.title_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.title_id IS ' [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.title]';


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.url_serialized_object; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.url_serialized_object IS 'URL Objeto Serializado [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.urlSerializedObject]';


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.user_id; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.user_id IS 'Usuario [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.userId]';


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.user_name; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.user_name IS 'Usuario [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.userName]';


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.name_physical_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.name_physical_person IS 'Nombre Persona [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.namePhysicalPerson]';


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.last_name_physical_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.last_name_physical_person IS 'Apellido Persona [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.lastNamePhysicalPerson]';


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.code_identification_type_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.code_identification_type_person IS 'Tipo de Documento de Identificación Personal [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.codeIdentificationTypePerson]';


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.identification_type_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.identification_type_person IS 'Tipo de Documento de Identificación Personal [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.identificationTypePerson]';


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.identification_person; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.identification_person IS 'Número Documento Persona [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.identificationPerson]';


--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.type_event_version; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.type_event_version IS ' [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.typeEventVersion]';


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.event_type; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.event_type IS 'Tipo de Evento [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.eventType]';


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.date_event; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.date_event IS 'Fecha hora del Evento [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.dateEvent]';


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.version_label; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.version_label IS 'Etiqueta de Version [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.versionLabel]';


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN version_title.version; Type: COMMENT; Schema: model; Owner: postgres
--

COMMENT ON COLUMN version_title.version IS 'Version [Map Class: org.nahuel.model.edu.career.titile.version.VersionTitle.version]';


--
-- TOC entry 2103 (class 0 OID 1259988)
-- Dependencies: 162 2123
-- Data for Name: academic_unit; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY academic_unit (id, state_enable, code, code_b, short_name, name, comment, url_logo, au_type_id, edu_institution_id, academic_unit_parent_id) FROM stdin;
b3635f78-11ee-41a0-a7cb-c6d29d517e75	t	164	13	FAUD	Facultad de Arquitectura, Urbanismo y Diseño	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
c6135604-895e-4a7c-b502-1c310ad119be	t	\N	P13	EG	Escuela de Graduados	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	b3635f78-11ee-41a0-a7cb-c6d29d517e75
5fc20193-5115-4bde-8b15-6de9a9502422	t	2741	95	FA	Facultad de Artes	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
10c53c4c-ee77-4e81-ad65-dcc27782efa1	t	163	19	FCA	Facultad de Ciencias Agropecuarias	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
1f408782-6b71-4277-b7e4-2ee217729ced	t	\N	P19	EP	Escuela de Posgrado	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	10c53c4c-ee77-4e81-ad65-dcc27782efa1
7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	t	168	11	FCE	Facultad de Ciencias Económicas	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
f1327376-a732-431a-977a-2d3647c2882b	t	\N	11P	EG	Escuela de Graduados	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d
f6176f00-5018-4c33-b698-e474d85d0062	t	165	10	FCEFyN	Facultad de Ciencias Exactas, Físicas y Naturales	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
fd840048-a07e-410d-9669-afa8845c9533	t	\N	P10	SP	Secretaría de Posgrado	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062
ab204374-4bbb-4e15-93ca-3ad7ea8833b0	t	175	06	FCM	Facultad de Ciencias Médicas	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
78ed1e55-1f54-48a3-b505-54748ad44716	t	178	06027	EE	Escuela de Enfermería	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0
493d663d-fe6d-489b-9745-347c0bcaea80	t	179	06-1	EF	Escuela de Fonoaudiología	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0
0290cf5a-de09-4c8f-8a1b-948dfb2c3e1c	t	180	06025	EKyF	Escuela de Kinesiología y Fisioterapia	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0
eb50f50a-9064-407b-bb39-f5f1b19aadf9	t	176	06031	EN	Escuela de Nutrición	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0
a204a01d-41d2-4d0d-b046-f7944dae9ccf	t	177	06026	ETM	Escuela de Tecnología Médica	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0
15eca57a-fdbd-4588-8d74-b8fc47db14e4	t	\N	06029	SG	Secretaría de Graduados	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0
f20eb6a4-ccd7-4e17-84c9-03430ccbc1fa	t	167	15	FCQ	Facultad de Ciencias Químicas	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
2b49eaa3-eaba-4603-adeb-012a37ba4f4f	t	\N	P15	EP	Escuela de Posgrado	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	f20eb6a4-ccd7-4e17-84c9-03430ccbc1fa
b7f875c8-fa6c-4f4d-aed3-fee20560c872	t	169	05	FDyCS	Facultad de Derecho y Ciencias Sociales	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
b17fe67c-6247-4f64-858a-f80e38f29372	t	897	42	ECI	Escuela de Ciencias de Información	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	b7f875c8-fa6c-4f4d-aed3-fee20560c872
be0f0322-10ac-4cb7-83ea-e36ab1ae04c0	t	170	20	ETS	Escuela de Trabajo Social	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	b7f875c8-fa6c-4f4d-aed3-fee20560c872
5e1960f1-f9f4-414e-bcfb-b2f13b625798	t	\N	P20	SG	Secretaría de Graduados	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	be0f0322-10ac-4cb7-83ea-e36ab1ae04c0
67b2ca47-2a44-4f64-abde-af8772d718e0	t	\N	P05	SP	Secretaría de Posgrado	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	b7f875c8-fa6c-4f4d-aed3-fee20560c872
a5a8c3c6-485f-428a-a483-3521f6af3f34	t	172	12	FFyH	Facultad de Filosofía y Humanidades	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
e2f96853-bb69-47a0-b8f4-8eae495674a8	t	\N	12-P	SP	Secretaría de Posgrado	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34
6703de2d-9c21-4ceb-982c-a40b6fe42d88	t	2146	16	FL	Facultad de Lenguas	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
49cb3c52-35c7-482e-9740-12c9096746bd	t	\N	P16	SP	Secretaría de Posgrado	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88
8aab66e4-81b5-4c72-9b2b-fce7acaf4883	t	1793	03	FAMAF	Facultad de Matemática, Astronomía y Física	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
5e7e0189-2b66-417c-b5c7-8c721743a820	t	\N	P03	EP	Escuela de Posgrado	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883
27866984-a0b4-4c38-bb80-e8902638b7b2	t	\N	49-10	IMG	Instituto de Altos Estudios Espaciales Mario Gulich	\N	\N	5f131f00-090a-4e4d-ac37-dde4711949f9	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883
c385482d-0684-4384-9aa9-b50f23dca887	t	181	14	FO	Facultad de Odontología	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
952601b3-4b5b-44ec-a42f-38e907f4546e	t	\N	P14	EP	Escuela de Posgrado	\N	\N	a0c285c3-adce-491d-a239-d09548834bc1	da1d76fc-77f2-41a4-97e5-9926d481a536	c385482d-0684-4384-9aa9-b50f23dca887
228b2744-90f7-4f25-a82a-5b21745c7fa3	t	1786	75	FP	Facultad de Psicología	\N	\N	f53150fc-55cc-4305-978d-4e7a9d61f063	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	t	\N	P75	SP	Secretaría de Posgrado	\N	\N	ad4feaca-687b-40ba-a5e7-db288857c827	da1d76fc-77f2-41a4-97e5-9926d481a536	228b2744-90f7-4f25-a82a-5b21745c7fa3
e5489224-e216-4bf6-8df8-387387df5b2d	t	2723	02	CNM	Colegio Nacional de Monserrat	\N	\N	f2393fd8-17bd-4f46-a79a-570f05d5ec69	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
8c688851-f8b1-48ab-a0f8-140088e4bb0b	t	2724	01	ESCMB	Escuela Superior de Comercio Manuel Belgrano	\N	\N	f2393fd8-17bd-4f46-a79a-570f05d5ec69	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
e2bdbef7-f3b8-45c2-a5a1-c87d59484652	t	1819	64	IIFAP	Instituto de Investigación y Formación en Administración Pública	\N	\N	5f131f00-090a-4e4d-ac37-dde4711949f9	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
1343f841-1373-4261-ad8c-4d4fe5b6de4e	t	1818	69	CEA	Centro de Estudios Avanzados	\N	\N	a9677c7d-16c1-4398-9d26-aae72284c454	da1d76fc-77f2-41a4-97e5-9926d481a536	\N
\.


--
-- TOC entry 2104 (class 0 OID 1259994)
-- Dependencies: 163 2123
-- Data for Name: agreement_title; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY agreement_title (id, state_enable, agreement, comment, title_id, edu_institution_id, academic_unit_id) FROM stdin;
\.


--
-- TOC entry 2105 (class 0 OID 1260000)
-- Dependencies: 164 2123
-- Data for Name: au_type; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY au_type (id, state_enable, code, name, comment) FROM stdin;
f53150fc-55cc-4305-978d-4e7a9d61f063	t	1	Facultad	\N
a0c285c3-adce-491d-a239-d09548834bc1	t	2	Escuela	\N
f2393fd8-17bd-4f46-a79a-570f05d5ec69	t	3	Colegio	\N
5f131f00-090a-4e4d-ac37-dde4711949f9	t	4	Instituto	\N
a9677c7d-16c1-4398-9d26-aae72284c454	t	5	Centro	\N
ad4feaca-687b-40ba-a5e7-db288857c827	t	6	Secretaría	\N
\.


--
-- TOC entry 2106 (class 0 OID 1260006)
-- Dependencies: 165 2123
-- Data for Name: career; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY career (id, state_enable, code, name, comment, career_type_id, edu_institution_id, academic_unit_id, career_state_id) FROM stdin;
f381c419-6a90-11e4-bc76-f314bf0101e2	t	4	Maestría en Salud Mental	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f381c41e-6a90-11e4-bc76-f314bf0101e2	t	9	Tecnicatura de Radiología	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	a204a01d-41d2-4d0d-b046-f7944dae9ccf	\N
f381eb32-6a90-11e4-bc76-f314bf0101e2	t	13	Licenciatura en Ciencias de la Educación -Ciclo-	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	\N
f3821249-6a90-11e4-bc76-f314bf0101e2	t	20	Especialización en Gestión y Producción de Medios Audiovisuales	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	\N
f382124c-6a90-11e4-bc76-f314bf0101e2	t	23	Especialización en Enseñanza de la Lengua y la Literatura	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3821251-6a90-11e4-bc76-f314bf0101e2	t	28	Tecnicatura Superior Universitaria en Comercialización	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8c688851-f8b1-48ab-a0f8-140088e4bb0b	\N
f3801666-6a90-11e4-bc76-f314bf0101e2	t	1	Especialización en Otorrinolaringología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f381c41f-6a90-11e4-bc76-f314bf0101e2	t	10	Licenciatura en Administración	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	e510decc-e55a-4de1-877a-b62090c355e8
f381eb31-6a90-11e4-bc76-f314bf0101e2	t	12	Licenciatura en Cine y Televisión	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f381c418-6a90-11e4-bc76-f314bf0101e2	t	3	Licenciatura en Fonoaudiología	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	493d663d-fe6d-489b-9745-347c0bcaea80	e510decc-e55a-4de1-877a-b62090c355e8
f3821255-6a90-11e4-bc76-f314bf0101e2	t	32	Licenciatura en Grabado	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3821256-6a90-11e4-bc76-f314bf0101e2	t	33	Licenciatura en Lengua y Literatura Italianas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3821257-6a90-11e4-bc76-f314bf0101e2	t	34	Maestría en Análisis y Procesamiento de Imágenes	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f3821254-6a90-11e4-bc76-f314bf0101e2	t	31	Maestria en Derecho y Argumentación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f381c417-6a90-11e4-bc76-f314bf0101e2	t	2	Maestría en Drogadependencia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	073dd124-0cf1-40b1-a828-935a2129fb09
f381c420-6a90-11e4-bc76-f314bf0101e2	t	11	Maestría en Gestión y Desarrollo Habitacional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f3821248-6a90-11e4-bc76-f314bf0101e2	t	19	Maestría en Políticas y Gestión del Desarrollo Local	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	073dd124-0cf1-40b1-a828-935a2129fb09
f382124a-6a90-11e4-bc76-f314bf0101e2	t	21	Maestría en Salud Pública	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382124b-6a90-11e4-bc76-f314bf0101e2	t	22	Profesorado de Enseñanza Media y Superior en Ciencias Económicas -Ciclo de Complementación Curricular-	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	073dd124-0cf1-40b1-a828-935a2129fb09
f382124f-6a90-11e4-bc76-f314bf0101e2	t	26	Profesorado de Lengua Italiana	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3821247-6a90-11e4-bc76-f314bf0101e2	t	18	Tecnicatura en Comunicación y Turismo a Distancia	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f381eb33-6a90-11e4-bc76-f314bf0101e2	t	14	Tecnicatura en Economía y Administración de Pequeñas y Medianas Empresas	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	e510decc-e55a-4de1-877a-b62090c355e8
f382125e-6a90-11e4-bc76-f314bf0101e2	t	41	Especialización en Procesos y Prácticas de la Lectura y la Escritura	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	\N
f3821263-6a90-11e4-bc76-f314bf0101e2	t	46	Ciclo Básico Común Modificado	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f382126a-6a90-11e4-bc76-f314bf0101e2	t	53	Analista Universitario en Sistemas Informáticos	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8c688851-f8b1-48ab-a0f8-140088e4bb0b	\N
f382126c-6a90-11e4-bc76-f314bf0101e2	t	55	Especialización en Alimentación de Bovinos	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f3821276-6a90-11e4-bc76-f314bf0101e2	t	65	Especialización en Epidemiología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f382125f-6a90-11e4-bc76-f314bf0101e2	t	42	Especialización en Oncología Clínica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825f9a-6a90-11e4-bc76-f314bf0101e2	t	69	Especialización en Prótesis Fija, Removible e Implantología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	952601b3-4b5b-44ec-a42f-38e907f4546e	e510decc-e55a-4de1-877a-b62090c355e8
f382125c-6a90-11e4-bc76-f314bf0101e2	t	39	Farmacia	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3825f9b-6a90-11e4-bc76-f314bf0101e2	t	70	Geología Vocacional	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3821260-6a90-11e4-bc76-f314bf0101e2	t	43	Ingeniería en Computación	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3821271-6a90-11e4-bc76-f314bf0101e2	t	60	Ingeniería Mecánica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3821268-6a90-11e4-bc76-f314bf0101e2	t	51	Licenciatura en Filosofía	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f3821275-6a90-11e4-bc76-f314bf0101e2	t	64	Licenciatura en Lengua y Literatura Alemanas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3832352-6a90-11e4-bc76-f314bf0101e2	t	173	Maestría en Dirección de Negocios	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3821273-6a90-11e4-bc76-f314bf0101e2	t	62	Maestría en Manejo de Vida Silvestre	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3821274-6a90-11e4-bc76-f314bf0101e2	t	63	Maestría en Sociología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f382126e-6a90-11e4-bc76-f314bf0101e2	t	57	Profesorado de Lengua Francesa	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3821272-6a90-11e4-bc76-f314bf0101e2	t	61	Profesorado en Composición Musical	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3821265-6a90-11e4-bc76-f314bf0101e2	t	48	Profesorado en Educación Musical	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f382126b-6a90-11e4-bc76-f314bf0101e2	t	54	Profesorado en Física	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f3821261-6a90-11e4-bc76-f314bf0101e2	t	44	Traductorado Público Nacional de Francés	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3825f9d-6a90-11e4-bc76-f314bf0101e2	t	72	Especialización en Reproducción Bovina	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f3825f9f-6a90-11e4-bc76-f314bf0101e2	t	74	Maestría en Formulación de Estrategias  Públicas y Privadas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	\N
f3825fa3-6a90-11e4-bc76-f314bf0101e2	t	78	Especialización en Tecnologías Multimedia para Desarrollos Educativos - Semi Presencial	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f3825fa4-6a90-11e4-bc76-f314bf0101e2	t	79	Especialización en Psicología Sanitaria	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	\N
f3825fa6-6a90-11e4-bc76-f314bf0101e2	t	81	Licenciatura en Perfeccionamiento Instrumental (Violin)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f3825fac-6a90-11e4-bc76-f314bf0101e2	t	87	Maestría en Intervención e Investigación Psicosocial	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	\N
f3825faf-6a90-11e4-bc76-f314bf0101e2	t	90	Especialización en Productividad Organizacional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	\N
f3825fb1-6a90-11e4-bc76-f314bf0101e2	t	92	Maestría en Ciencias Sociales con mención en Políticas Sociales	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e1960f1-f9f4-414e-bcfb-b2f13b625798	\N
f3825fb2-6a90-11e4-bc76-f314bf0101e2	t	93	POSTIT. DOC.  EN LENGUAJE Y COMUNICACION ESPECIAL. SUPERIOR	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f3825fb4-6a90-11e4-bc76-f314bf0101e2	t	95	Especialización en Psicología Educacional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	\N
f3825fb5-6a90-11e4-bc76-f314bf0101e2	t	96	Especialización en Ortodoncia y Ortopedia Dento-Máxilo-Facial	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	952601b3-4b5b-44ec-a42f-38e907f4546e	\N
f3825fba-6a90-11e4-bc76-f314bf0101e2	t	101	Especialización en Pedagogía de la Formación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3825fa9-6a90-11e4-bc76-f314bf0101e2	t	84	Especialización en Química Clínica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f3825fae-6a90-11e4-bc76-f314bf0101e2	t	89	Especialización en Tecnología Arquitectónica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f3825fa8-6a90-11e4-bc76-f314bf0101e2	t	83	Ingeniería Electrónica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3825fa1-6a90-11e4-bc76-f314bf0101e2	t	76	Licenciatura en Teatro (Escenográfica)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3825fbd-6a90-11e4-bc76-f314bf0101e2	t	104	Maestría en Bioética	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825fb0-6a90-11e4-bc76-f314bf0101e2	t	91	Maestría en Ciencias de la Ingeniería - Mención Transporte	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3825fb7-6a90-11e4-bc76-f314bf0101e2	t	98	Maestría en Estadística Aplicada	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3825fa0-6a90-11e4-bc76-f314bf0101e2	t	75	Maestría en Gerontología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825faa-6a90-11e4-bc76-f314bf0101e2	t	85	Maestría en Microbiología con orientación en Investigación en Salud Humana	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825f9c-6a90-11e4-bc76-f314bf0101e2	t	71	Maestría en Relaciones Internacionales	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3825fb8-6a90-11e4-bc76-f314bf0101e2	t	99	Profesorado de Lengua y Literatura Castellanas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3825fad-6a90-11e4-bc76-f314bf0101e2	t	88	Profesorado de Portugués	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3825fab-6a90-11e4-bc76-f314bf0101e2	t	86	Profesorado en Español Lengua Materna y Lengua Extranjera	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3825fbe-6a90-11e4-bc76-f314bf0101e2	t	105	Especialización en Asesoramiento y Gestión Pedagógica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3825fc0-6a90-11e4-bc76-f314bf0101e2	t	107	Especialización en Gestión del Turismo Sustentable	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	\N
f3825fc1-6a90-11e4-bc76-f314bf0101e2	t	108	Maestría en Patrimonio Cultural Material, Administración, Conservación y Legislación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f382adeb-6a90-11e4-bc76-f314bf0101e2	t	118	Maestría en Antropología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f382adf0-6a90-11e4-bc76-f314bf0101e2	t	123	Especialización en Enseñanza de las Ciencias Sociales con Mención  en Formación Ética y Ciudadana	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f382adf2-6a90-11e4-bc76-f314bf0101e2	t	125	Ciclo Básico Común	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f382adf3-6a90-11e4-bc76-f314bf0101e2	t	126	Especialización en Hidráulica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	\N
f382adff-6a90-11e4-bc76-f314bf0101e2	t	138	Especialización en Radiología y Diagnóstico por Imágenes	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382adf7-6a90-11e4-bc76-f314bf0101e2	t	130	Licenciatura en Antropología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f382adec-6a90-11e4-bc76-f314bf0101e2	t	119	Licenciatura en Bioquímica Clínica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	073dd124-0cf1-40b1-a828-935a2129fb09
f382adee-6a90-11e4-bc76-f314bf0101e2	t	121	Licenciatura en Ciencias de la Educación	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f382adf6-6a90-11e4-bc76-f314bf0101e2	t	129	Licenciatura en Enfermería  - Ciclo de Complementación Curricular	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	78ed1e55-1f54-48a3-b505-54748ad44716	e510decc-e55a-4de1-877a-b62090c355e8
f382aded-6a90-11e4-bc76-f314bf0101e2	t	120	Licenciatura en Historia	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f38286d8-6a90-11e4-bc76-f314bf0101e2	t	115	Maestría en Administración Pública	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2bdbef7-f3b8-45c2-a5a1-c87d59484652	e510decc-e55a-4de1-877a-b62090c355e8
f382adea-6a90-11e4-bc76-f314bf0101e2	t	117	Maestría en Ciencias de la Ingeniería Mención Telecomunicaciones	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f38286d6-6a90-11e4-bc76-f314bf0101e2	t	113	Maestría en Diseño Arquitectónico y Urbano	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f382adf9-6a90-11e4-bc76-f314bf0101e2	t	132	Maestría en Inglés	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f382ade9-6a90-11e4-bc76-f314bf0101e2	t	116	Maestría en Inglés con Orientación en Lingüística Aplicada	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3825fc4-6a90-11e4-bc76-f314bf0101e2	t	111	Maestría en Lenguajes e Interculturalidad	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f382adfa-6a90-11e4-bc76-f314bf0101e2	t	133	Maestría en Traductología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f382adf5-6a90-11e4-bc76-f314bf0101e2	t	128	Martillero y Corredor Público	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	e5489224-e216-4bf6-8df8-387387df5b2d	e510decc-e55a-4de1-877a-b62090c355e8
f3825fbf-6a90-11e4-bc76-f314bf0101e2	t	106	Profesorado en Historia	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f382adfc-6a90-11e4-bc76-f314bf0101e2	t	135	Profesorado en Psicología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	228b2744-90f7-4f25-a82a-5b21745c7fa3	e510decc-e55a-4de1-877a-b62090c355e8
f382ae03-6a90-11e4-bc76-f314bf0101e2	t	142	Especialización en Encuestas y Análisis de Datos para la Planificación Social	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	\N
f382ae04-6a90-11e4-bc76-f314bf0101e2	t	143	Especialización en Cirugía Buco-Máxilo-Facial	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	952601b3-4b5b-44ec-a42f-38e907f4546e	\N
f382ae06-6a90-11e4-bc76-f314bf0101e2	t	145	Profesorado en Perfeccionamiento Instrumental (Piano)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f382ae09-6a90-11e4-bc76-f314bf0101e2	t	148	Técnico Instrumental de Corrector Literario	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	\N
f382ae0a-6a90-11e4-bc76-f314bf0101e2	t	149	Especialización en Psicología del Trabajo y de las Organizaciones	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	\N
f382ae0d-6a90-11e4-bc76-f314bf0101e2	t	152	Tecnicatura Superior Universitaria en Administación de Cooperativas y Mutuales	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8c688851-f8b1-48ab-a0f8-140088e4bb0b	\N
f382ae0f-6a90-11e4-bc76-f314bf0101e2	t	154	Doctorado en Historia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f382ae16-6a90-11e4-bc76-f314bf0101e2	t	161	Especialización en Producción de Cultivos Extensivos	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f383234f-6a90-11e4-bc76-f314bf0101e2	t	170	Maestría en Ciencia y Tecnología de los Alimentos	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	\N
f382ae05-6a90-11e4-bc76-f314bf0101e2	t	144	Especialización en Ortopedia y Traumatología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382ae08-6a90-11e4-bc76-f314bf0101e2	t	147	Especialización en Reumatología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382ae00-6a90-11e4-bc76-f314bf0101e2	t	139	Especialización en Urología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382ae0c-6a90-11e4-bc76-f314bf0101e2	t	151	LICENCIATURA	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f3832351-6a90-11e4-bc76-f314bf0101e2	t	172	Licenciatura en Bibliotecología y Documentación	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f382fc3e-6a90-11e4-bc76-f314bf0101e2	t	169	Licenciatura en Enfermería	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	78ed1e55-1f54-48a3-b505-54748ad44716	e510decc-e55a-4de1-877a-b62090c355e8
f382ae14-6a90-11e4-bc76-f314bf0101e2	t	159	Licenciatura en Escultura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f382ae0e-6a90-11e4-bc76-f314bf0101e2	t	153	Licenciatura en Pintura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f382ae18-6a90-11e4-bc76-f314bf0101e2	t	163	REVALIDA TITULO DE MEDICO	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0	e510decc-e55a-4de1-877a-b62090c355e8
f382d529-6a90-11e4-bc76-f314bf0101e2	t	164	Tecnicatura en Relaciones Públicas a Distancia	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f3832356-6a90-11e4-bc76-f314bf0101e2	t	177	Especialización en Criminalística y Actividades Periciales con mención en Ciencias Exactas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	\N
f3832358-6a90-11e4-bc76-f314bf0101e2	t	179	Licenciatura en Artes Visuales	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f3832359-6a90-11e4-bc76-f314bf0101e2	t	180	Profesorado en Perfeccionamiento Instrumental (Violín)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f383235a-6a90-11e4-bc76-f314bf0101e2	t	181	Especialización en Sociopsicogénesis del Entendimiento Escolar	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f383235c-6a90-11e4-bc76-f314bf0101e2	t	183	POST. EN LING. APLIC. A LOS PROC. DE LECTURA Y ESCRITURA - A	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f383235d-6a90-11e4-bc76-f314bf0101e2	t	184	Especialización en Sistemas de Radar e Instrumentación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	\N
f3832364-6a90-11e4-bc76-f314bf0101e2	t	191	Maestría en Ciencias Químicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	\N
f383236a-6a90-11e4-bc76-f314bf0101e2	t	197	Especialización en Antropología Social	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f383236c-6a90-11e4-bc76-f314bf0101e2	t	199	Especialización en Psicología Clínica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	\N
f383236e-6a90-11e4-bc76-f314bf0101e2	t	201	Especialización en Intervención Social en Niñez y Adolescencia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e1960f1-f9f4-414e-bcfb-b2f13b625798	\N
f3832370-6a90-11e4-bc76-f314bf0101e2	t	203	Maestría en Salud Sexual y Reproductiva	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f3832372-6a90-11e4-bc76-f314bf0101e2	t	205	Licenciatura en Perfeccionamiento Instrumental (Viola)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f3832373-6a90-11e4-bc76-f314bf0101e2	t	206	Doctorado en Ciencias Económicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f383236f-6a90-11e4-bc76-f314bf0101e2	t	202	Especialización en Planificación y Diseño del Paisaje	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f3832369-6a90-11e4-bc76-f314bf0101e2	t	196	Especialización en Tocoginecología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3832363-6a90-11e4-bc76-f314bf0101e2	t	190	Especialización en Traducción Científica y Técnica (A Distancia)	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f383235f-6a90-11e4-bc76-f314bf0101e2	t	186	Especialización en Traducción Jurídica y Económica (A Distancia)	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3832360-6a90-11e4-bc76-f314bf0101e2	t	187	Licenciatura en Computación	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	073dd124-0cf1-40b1-a828-935a2129fb09
f3832366-6a90-11e4-bc76-f314bf0101e2	t	193	Licenciatura en Comunicación Social	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f3832367-6a90-11e4-bc76-f314bf0101e2	t	194	Maestría en Trabajo Social con mención en Intervención Social	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e1960f1-f9f4-414e-bcfb-b2f13b625798	e510decc-e55a-4de1-877a-b62090c355e8
f3832357-6a90-11e4-bc76-f314bf0101e2	t	178	Profesorado de Lengua  Alemana	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3832374-6a90-11e4-bc76-f314bf0101e2	t	207	Tecnicatura en Periodismo Deportivo a Distancia	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f3832371-6a90-11e4-bc76-f314bf0101e2	t	204	Técnico Mecánico Electricista	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3832355-6a90-11e4-bc76-f314bf0101e2	t	176	Traductorado Público Nacional de Inglés	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	073dd124-0cf1-40b1-a828-935a2129fb09
f3832365-6a90-11e4-bc76-f314bf0101e2	t	192	Traductorado Público Nacional de Italiano	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f383237b-6a90-11e4-bc76-f314bf0101e2	t	214	Maestría en Teoría Psicoanalítica Lacaniana	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	\N
f383237c-6a90-11e4-bc76-f314bf0101e2	t	215	Especialización en Adolescencia con Mención en Educación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f384f841-6a90-11e4-bc76-f314bf0101e2	t	220	Maestría en Pedagogía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3851f53-6a90-11e4-bc76-f314bf0101e2	t	222	Tecnicatura Superior Universitaria en Administración de Cooperativas y Mutuales	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8c688851-f8b1-48ab-a0f8-140088e4bb0b	\N
f3851f54-6a90-11e4-bc76-f314bf0101e2	t	223	Tecnicatura Superior Universitaria en Recursos Humanos	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8c688851-f8b1-48ab-a0f8-140088e4bb0b	\N
f3851f59-6a90-11e4-bc76-f314bf0101e2	t	228	Maestría en Ciencias Agropecuarias	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f3851f5c-6a90-11e4-bc76-f314bf0101e2	t	231	Tecnicatura Superior Universitaria en Gestión Financiera	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8c688851-f8b1-48ab-a0f8-140088e4bb0b	\N
f3851f5e-6a90-11e4-bc76-f314bf0101e2	t	233	Doctorado en Ciencias Antropológicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3851f62-6a90-11e4-bc76-f314bf0101e2	t	237	Maestría en Gestión para la Integración Regional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	\N
f3851f5f-6a90-11e4-bc76-f314bf0101e2	t	234	Especialización en Oftalmología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f384f83d-6a90-11e4-bc76-f314bf0101e2	t	216	Especialización en Radioterapia Oncológica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3851f61-6a90-11e4-bc76-f314bf0101e2	t	236	Especializacion en Tributación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3851f5a-6a90-11e4-bc76-f314bf0101e2	t	229	Especialización en Turismo Alternativo	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3851f55-6a90-11e4-bc76-f314bf0101e2	t	224	Ingeniería en Agrimensura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3851f60-6a90-11e4-bc76-f314bf0101e2	t	235	Ingeniería Industrial	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3832379-6a90-11e4-bc76-f314bf0101e2	t	212	Maestría en Gerencia y Administración de Servicios de Salud	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3851f56-6a90-11e4-bc76-f314bf0101e2	t	225	Maestría en Lengua y Cultura Italianas en Perspectiva Intercultural	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	073dd124-0cf1-40b1-a828-935a2129fb09
f383237a-6a90-11e4-bc76-f314bf0101e2	t	213	Maestría en Manejo de Vida Silvestre - Vocacional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f384f83e-6a90-11e4-bc76-f314bf0101e2	t	217	Maestría en Partidos Políticos	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3851f63-6a90-11e4-bc76-f314bf0101e2	t	238	Profesorado en Ciencias de la Educación	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f3832377-6a90-11e4-bc76-f314bf0101e2	t	210	Profesorado en Letras Modernas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f3851f67-6a90-11e4-bc76-f314bf0101e2	t	242	POST. EN LING. APLIC. A LOS PROC. DE LECTURA Y ESCRITURA - D	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f3851f6d-6a90-11e4-bc76-f314bf0101e2	t	248	Licenciatura en Perfeccionamiento Instrumental (Piano)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f3851f6f-6a90-11e4-bc76-f314bf0101e2	t	250	Especialización en Adolescencia con Mención en Psicología del Desarrollo	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3851f72-6a90-11e4-bc76-f314bf0101e2	t	253	Profesorado en Perfeccionamiento Instrumental (Viola)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	\N
f3851f74-6a90-11e4-bc76-f314bf0101e2	t	255	Especialización en Criminalística y Actividades Periciales con mención en Ciencias Naturales	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	\N
f3851f77-6a90-11e4-bc76-f314bf0101e2	t	258	Especialización en Enfermería en el Cuidado del Paciente Crítico	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f3851f79-6a90-11e4-bc76-f314bf0101e2	t	260	POST. DOC. EN LENGUAJE Y COMUNICACION DIPLOMATURA SUPERIOR	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f3851f7b-6a90-11e4-bc76-f314bf0101e2	t	262	Especialización en Psicopedagogía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3876975-6a90-11e4-bc76-f314bf0101e2	t	272	POST. EN LING. APLIC. A LOS PROC. DE LECTURA Y ESCRITURA - E	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f3851f6c-6a90-11e4-bc76-f314bf0101e2	t	247	Ingeniería Biomédica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3851f73-6a90-11e4-bc76-f314bf0101e2	t	254	Licenciatura en Cine y Televisión	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3851f75-6a90-11e4-bc76-f314bf0101e2	t	256	Maestría en Ciencias Sociales con mención en Metodología de la Investigación Social	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e1960f1-f9f4-414e-bcfb-b2f13b625798	e510decc-e55a-4de1-877a-b62090c355e8
f3876973-6a90-11e4-bc76-f314bf0101e2	t	270	Maestría en Desarrollo Urbano	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f3851f68-6a90-11e4-bc76-f314bf0101e2	t	243	Maestría en Enseñanza de Español como Lengua Extranjera	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3876978-6a90-11e4-bc76-f314bf0101e2	t	275	Maestría En Procesos Educativos Mediados Por Tecnologías	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f387425f-6a90-11e4-bc76-f314bf0101e2	t	266	Maestría en Sociosemiótica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3876971-6a90-11e4-bc76-f314bf0101e2	t	268	Medicina	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	ab204374-4bbb-4e15-93ca-3ad7ea8833b0	e510decc-e55a-4de1-877a-b62090c355e8
f387425c-6a90-11e4-bc76-f314bf0101e2	t	263	Odontología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	c385482d-0684-4384-9aa9-b50f23dca887	e510decc-e55a-4de1-877a-b62090c355e8
f387425d-6a90-11e4-bc76-f314bf0101e2	t	264	Profesorado de Lengua Inglesa	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	073dd124-0cf1-40b1-a828-935a2129fb09
f3851f6b-6a90-11e4-bc76-f314bf0101e2	t	246	Profesorado en Ciencias Biológicas (con proyecto biológico aprobado)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3876980-6a90-11e4-bc76-f314bf0101e2	t	283	Especialización en Administración y Gestión en Enfermería	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f3876981-6a90-11e4-bc76-f314bf0101e2	t	284	Especialización en Enseñanza de las Ciencias Sociales con Mención en Geografía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3876988-6a90-11e4-bc76-f314bf0101e2	t	291	ESPECIALIZACION EN LA ENSEÑANZA DE LAS CIENCIAS EXPERIMENTALES Y LA TECNOLOGÍA	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	\N
f3876991-6a90-11e4-bc76-f314bf0101e2	t	300	Doctorado en Letras	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f3876998-6a90-11e4-bc76-f314bf0101e2	t	307	Especialización en Didáctica de las Lenguas Extranjeras(Modalidad a Distancia)	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	\N
f3876996-6a90-11e4-bc76-f314bf0101e2	t	305	Especialización en Patología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f387697b-6a90-11e4-bc76-f314bf0101e2	t	278	Especialización en Producción y Análisis de Información para  Políticas Públicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f387698f-6a90-11e4-bc76-f314bf0101e2	t	298	Especialización en Servicios y Sistemas Distribuidos	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f387697a-6a90-11e4-bc76-f314bf0101e2	t	277	Ingeniería Aeronáutica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3876995-6a90-11e4-bc76-f314bf0101e2	t	304	Ingeniería Agronómica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3876999-6a90-11e4-bc76-f314bf0101e2	t	308	Maestría en Inglés con Orientación en Literatura Angloamericana	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3876986-6a90-11e4-bc76-f314bf0101e2	t	289	Maestría en Reproducción Bovina	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	e510decc-e55a-4de1-877a-b62090c355e8
f387697f-6a90-11e4-bc76-f314bf0101e2	t	282	Notariado	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b7f875c8-fa6c-4f4d-aed3-fee20560c872	e510decc-e55a-4de1-877a-b62090c355e8
f387697e-6a90-11e4-bc76-f314bf0101e2	t	281	Profesorado en Ciencias Biológicas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f387697c-6a90-11e4-bc76-f314bf0101e2	t	279	Profesorado en Filosofía	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f387698e-6a90-11e4-bc76-f314bf0101e2	t	297	Reválida Arquitectura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b3635f78-11ee-41a0-a7cb-c6d29d517e75	e510decc-e55a-4de1-877a-b62090c355e8
f387698b-6a90-11e4-bc76-f314bf0101e2	t	294	Tecnicatura en Gestión Universitaria	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	e510decc-e55a-4de1-877a-b62090c355e8
f3876990-6a90-11e4-bc76-f314bf0101e2	t	299	Traductorado Público Nacional de Alemán	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f387699c-6a90-11e4-bc76-f314bf0101e2	t	311	Especialización en Clínica Dermatológica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f38769a1-6a90-11e4-bc76-f314bf0101e2	t	316	Ingeniería Ambiental	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	\N
f38769a2-6a90-11e4-bc76-f314bf0101e2	t	317	Especialización en Cirugía de Tórax	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	\N
f3885304-6a90-11e4-bc76-f314bf0101e2	t	319	Doctorado en Ciencias Agropecuarias	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f3885307-6a90-11e4-bc76-f314bf0101e2	t	322	POSTIT. DOC. EN LENGUAJE Y COMUNICACION ACTUALIZACION ACADEM	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f3885308-6a90-11e4-bc76-f314bf0101e2	t	323	Maestría en Sistemas de Radar e Instrumentación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	\N
f388530d-6a90-11e4-bc76-f314bf0101e2	t	328	Maestría en Ciencias Agropecuarias con Mención en Tecnología de Semillas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1f408782-6b71-4277-b7e4-2ee217729ced	\N
f388a137-6a90-11e4-bc76-f314bf0101e2	t	338	Ciclo de Nivelacion	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f388a13b-6a90-11e4-bc76-f314bf0101e2	t	342	Tecnicatura en Radiología y Terapia Radiante	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	a204a01d-41d2-4d0d-b046-f7944dae9ccf	\N
f387699d-6a90-11e4-bc76-f314bf0101e2	t	312	Especialización en Psiquiatría	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3885306-6a90-11e4-bc76-f314bf0101e2	t	321	Ingeniería Química	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f388a136-6a90-11e4-bc76-f314bf0101e2	t	337	Licenciatura en Astronomía	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f38769a3-6a90-11e4-bc76-f314bf0101e2	t	318	Licenciatura en Ciencias de la Computación	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f3887a23-6a90-11e4-bc76-f314bf0101e2	t	334	Licenciatura en Comunicación Social	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f387699f-6a90-11e4-bc76-f314bf0101e2	t	314	Licenciatura en Geografía	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f388a138-6a90-11e4-bc76-f314bf0101e2	t	339	Licenciatura en Lengua y Literatura Castellanas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f388530f-6a90-11e4-bc76-f314bf0101e2	t	330	Licenciatura en Psicología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	228b2744-90f7-4f25-a82a-5b21745c7fa3	e510decc-e55a-4de1-877a-b62090c355e8
f387699b-6a90-11e4-bc76-f314bf0101e2	t	310	Maestría en Investigación Educativa -Mención Socioantropológica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f388a13a-6a90-11e4-bc76-f314bf0101e2	t	341	Profesorado Superior de Educación en Artes Plásticas: Grabado	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3887a25-6a90-11e4-bc76-f314bf0101e2	t	336	Profesorado Superior de Educación en Artes Plásticas: Pintura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f388a139-6a90-11e4-bc76-f314bf0101e2	t	340	Tecnicatura de Laboratorio Clínico e Histopatología	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	a204a01d-41d2-4d0d-b046-f7944dae9ccf	e510decc-e55a-4de1-877a-b62090c355e8
f388530e-6a90-11e4-bc76-f314bf0101e2	t	329	Tecnicatura Superior en Bromatología	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	e5489224-e216-4bf6-8df8-387387df5b2d	e510decc-e55a-4de1-877a-b62090c355e8
f388a143-6a90-11e4-bc76-f314bf0101e2	t	350	Especialización en Enseñanza de las Ciencias Sociales con Mención en Historia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	\N
f388c862-6a90-11e4-bc76-f314bf0101e2	t	365	Ciclo Nivelación Modificado	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	\N
f3851f71-6a90-11e4-bc76-f314bf0101e2	t	252	Abogacía	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b7f875c8-fa6c-4f4d-aed3-fee20560c872	e510decc-e55a-4de1-877a-b62090c355e8
f3832368-6a90-11e4-bc76-f314bf0101e2	t	195	Archivología	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f3887a21-6a90-11e4-bc76-f314bf0101e2	t	332	Archivología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f388530c-6a90-11e4-bc76-f314bf0101e2	t	327	Arquitectura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b3635f78-11ee-41a0-a7cb-c6d29d517e75	e510decc-e55a-4de1-877a-b62090c355e8
f3851f6e-6a90-11e4-bc76-f314bf0101e2	t	249	Bibliotecología y Documentación	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f383236b-6a90-11e4-bc76-f314bf0101e2	t	198	Bioquímica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f388a13d-6a90-11e4-bc76-f314bf0101e2	t	344	CICLO BASICO DE PLASTICA	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f382fc3b-6a90-11e4-bc76-f314bf0101e2	t	166	CICLO BASICO DE TEATRO	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f388a14e-6a90-11e4-bc76-f314bf0101e2	t	361	Especialización en Salud Social y Comunitaria	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f388a14b-6a90-11e4-bc76-f314bf0101e2	t	358	Especialización en Terapia Intensiva	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f388a14c-6a90-11e4-bc76-f314bf0101e2	t	359	Geología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f388a147-6a90-11e4-bc76-f314bf0101e2	t	354	Licenciatura en Dirección Coral	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f388a149-6a90-11e4-bc76-f314bf0101e2	t	356	Licenciatura en Economía	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	e510decc-e55a-4de1-877a-b62090c355e8
f388a146-6a90-11e4-bc76-f314bf0101e2	t	353	Licenciatura en Enfermería	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	78ed1e55-1f54-48a3-b505-54748ad44716	e510decc-e55a-4de1-877a-b62090c355e8
f388a14d-6a90-11e4-bc76-f314bf0101e2	t	360	Licenciatura en Español Lengua Materna y Lengua Extranjera	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f388c866-6a90-11e4-bc76-f314bf0101e2	t	369	Licenciatura en Kinesiología  y Fisioterapia	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	0290cf5a-de09-4c8f-8a1b-948dfb2c3e1c	e510decc-e55a-4de1-877a-b62090c355e8
f388c861-6a90-11e4-bc76-f314bf0101e2	t	364	Maestría en Educación en Ciencias Experimentales y Tecnología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f388a141-6a90-11e4-bc76-f314bf0101e2	t	348	Maestría en Gestión Ambiental del Desarrollo Urbano	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f388c867-6a90-11e4-bc76-f314bf0101e2	t	370	Maestría en Salud Materno Infantil	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f388c863-6a90-11e4-bc76-f314bf0101e2	t	366	Profesorado en Letras Clásicas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f388a145-6a90-11e4-bc76-f314bf0101e2	t	352	Profesorado en Matemática	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f388a13f-6a90-11e4-bc76-f314bf0101e2	t	346	Profesorado Superior de Educación en Artes Plásticas: Escultura	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3887a24-6a90-11e4-bc76-f314bf0101e2	t	335	Ciencias Biológicas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3851f64-6a90-11e4-bc76-f314bf0101e2	t	239	Ciencias Biológicas (con articulacion Proarquibi)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f388a148-6a90-11e4-bc76-f314bf0101e2	t	355	Ciencias Económicas	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	073dd124-0cf1-40b1-a828-935a2129fb09
f3821252-6a90-11e4-bc76-f314bf0101e2	t	29	Comunicación Visual	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	e5489224-e216-4bf6-8df8-387387df5b2d	e510decc-e55a-4de1-877a-b62090c355e8
f388a140-6a90-11e4-bc76-f314bf0101e2	t	347	Constructor	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3825fb9-6a90-11e4-bc76-f314bf0101e2	t	100	Contador Público	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	7278ee68-fbee-4b04-86d9-7ad8c1f3a89d	e510decc-e55a-4de1-877a-b62090c355e8
f388c864-6a90-11e4-bc76-f314bf0101e2	t	367	Diseño Industrial	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b3635f78-11ee-41a0-a7cb-c6d29d517e75	e510decc-e55a-4de1-877a-b62090c355e8
f38286d7-6a90-11e4-bc76-f314bf0101e2	t	114	Doctorado en Administración y Política Pública	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2bdbef7-f3b8-45c2-a5a1-c87d59484652	e510decc-e55a-4de1-877a-b62090c355e8
f3821262-6a90-11e4-bc76-f314bf0101e2	t	45	Doctorado en Astronomía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f3821269-6a90-11e4-bc76-f314bf0101e2	t	52	Doctorado en Ciencia Política	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3825fb6-6a90-11e4-bc76-f314bf0101e2	t	97	Doctorado en Ciencias Biológicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3885309-6a90-11e4-bc76-f314bf0101e2	t	324	Doctorado en Ciencias de la Computación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f387699e-6a90-11e4-bc76-f314bf0101e2	t	313	Doctorado en Ciencias de la Educación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	e510decc-e55a-4de1-877a-b62090c355e8
f3825fb3-6a90-11e4-bc76-f314bf0101e2	t	94	Doctorado en Ciencias de la Ingeniería	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f38286d5-6a90-11e4-bc76-f314bf0101e2	t	112	Doctorado en Ciencias de la Salud	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3821266-6a90-11e4-bc76-f314bf0101e2	t	49	Doctorado en Ciencias del Lenguaje con Mención en Traductología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3825fbc-6a90-11e4-bc76-f314bf0101e2	t	103	Doctorado en Ciencias del Lenguaje, Mención en Culturas y Literaturas Comparadas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3876989-6a90-11e4-bc76-f314bf0101e2	t	292	Doctorado en Ciencias del Lenguaje,  Mención en Lingüística Aplicada	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3876976-6a90-11e4-bc76-f314bf0101e2	t	273	Doctorado en Ciencias Económicas con Mención Ciencias Empresariales	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f382ae02-6a90-11e4-bc76-f314bf0101e2	t	141	Doctorado en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f388a13e-6a90-11e4-bc76-f314bf0101e2	t	345	Doctorado en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3821253-6a90-11e4-bc76-f314bf0101e2	t	30	Doctorado en Ciencias Económicas con Mención en Economía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f382124e-6a90-11e4-bc76-f314bf0101e2	t	25	Doctorado en Ciencias Geológicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3821246-6a90-11e4-bc76-f314bf0101e2	t	17	Doctorado en Ciencias Químicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f388c865-6a90-11e4-bc76-f314bf0101e2	t	368	Doctorado en Comunicación Social	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f381c41a-6a90-11e4-bc76-f314bf0101e2	t	5	Doctorado en Demografía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f381c41c-6a90-11e4-bc76-f314bf0101e2	t	7	Doctorado en Derecho y Ciencias Sociales	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f3832362-6a90-11e4-bc76-f314bf0101e2	t	189	Doctorado en Estudios de Género	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f382ae17-6a90-11e4-bc76-f314bf0101e2	t	162	Doctorado en Estudios Sociales Agrarios	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3876977-6a90-11e4-bc76-f314bf0101e2	t	274	Doctorado en Estudios Sociales en América Latina	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3821270-6a90-11e4-bc76-f314bf0101e2	t	59	Doctorado en Filosofía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	e510decc-e55a-4de1-877a-b62090c355e8
f388c85f-6a90-11e4-bc76-f314bf0101e2	t	362	Doctorado en Física	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f3832378-6a90-11e4-bc76-f314bf0101e2	t	211	Doctorado en Matemática	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f388530a-6a90-11e4-bc76-f314bf0101e2	t	325	Doctorado en Medicina y Cirugía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f381eb34-6a90-11e4-bc76-f314bf0101e2	t	15	Doctorado en Neurociencias	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f3851f7a-6a90-11e4-bc76-f314bf0101e2	t	261	Doctorado en Odontología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	952601b3-4b5b-44ec-a42f-38e907f4546e	e510decc-e55a-4de1-877a-b62090c355e8
f381c41d-6a90-11e4-bc76-f314bf0101e2	t	8	Doctorado en Psicología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	dbf3ac47-6219-4995-b247-d5b8ae8e6e3d	e510decc-e55a-4de1-877a-b62090c355e8
f382adef-6a90-11e4-bc76-f314bf0101e2	t	122	Doctorado en Semiótica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f388530b-6a90-11e4-bc76-f314bf0101e2	t	326	Doctorado en Semiótica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2f96853-bb69-47a0-b8f4-8eae495674a8	e510decc-e55a-4de1-877a-b62090c355e8
f382ae15-6a90-11e4-bc76-f314bf0101e2	t	160	Especialidad en Contabilidad Superior y Auditoría	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3874260-6a90-11e4-bc76-f314bf0101e2	t	267	Especialidad en Gestión de la Innovación y Vinculación Tecnológica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	073dd124-0cf1-40b1-a828-935a2129fb09
f382ae01-6a90-11e4-bc76-f314bf0101e2	t	140	Especialidad en Gestión de Tecnologías Innovadoras	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3887a20-6a90-11e4-bc76-f314bf0101e2	t	331	Especialidad en Sindicatura Concursal	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3825fa7-6a90-11e4-bc76-f314bf0101e2	t	82	Especialización en Administración Pública Provincial y Municipal	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	e2bdbef7-f3b8-45c2-a5a1-c87d59484652	e510decc-e55a-4de1-877a-b62090c355e8
f383236d-6a90-11e4-bc76-f314bf0101e2	t	200	Especialización en Alergia e Inmunología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382adfb-6a90-11e4-bc76-f314bf0101e2	t	134	Especialización en Bioquímica Clínica en Bacteriología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f388a13c-6a90-11e4-bc76-f314bf0101e2	t	343	Especialización en Bioquímica Clínica en Bromatología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f388a144-6a90-11e4-bc76-f314bf0101e2	t	351	Especialización en Bioquímica Clínica en  Endocrinología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f381c41b-6a90-11e4-bc76-f314bf0101e2	t	6	Especialización en Bioquímica Clínica en Hematología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f3825fa5-6a90-11e4-bc76-f314bf0101e2	t	80	Especialización en Bioquímica Clínica en Inmunología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f383235b-6a90-11e4-bc76-f314bf0101e2	t	182	Especialización en Bioquímica Clínica en Parasitología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f3851f70-6a90-11e4-bc76-f314bf0101e2	t	251	Especialización  en Bioquímica Clínica en Toxicología y Bioquímica Legal	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f3851f76-6a90-11e4-bc76-f314bf0101e2	t	257	Especialización en Bioquímica Clínica en Virología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f382124d-6a90-11e4-bc76-f314bf0101e2	t	24	Especialización en Cardiología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382adf4-6a90-11e4-bc76-f314bf0101e2	t	127	Especialización en Cirugía Pediátrica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3823887-6a90-11e4-bc76-f314bf0101e2	t	66	Especialización en Cirugía Plástica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382adf1-6a90-11e4-bc76-f314bf0101e2	t	124	Especialización en Clínica Médica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f384f842-6a90-11e4-bc76-f314bf0101e2	t	221	Especialización en Clínica Pediátrica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825fc3-6a90-11e4-bc76-f314bf0101e2	t	110	Especialización en Clínica Quirúrgica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382fc3d-6a90-11e4-bc76-f314bf0101e2	t	168	Especialización en Comunicación, Medios y Prácticas Educativas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f382126f-6a90-11e4-bc76-f314bf0101e2	t	58	Especialización en Comunicación Pública de la Ciencia y Periodismo Científico	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	5e7e0189-2b66-417c-b5c7-8c721743a820	e510decc-e55a-4de1-877a-b62090c355e8
f38769a0-6a90-11e4-bc76-f314bf0101e2	t	315	Especialización en Derecho de Familia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f3851f69-6a90-11e4-bc76-f314bf0101e2	t	244	Especialización en Derecho de los Negocios	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f388c868-6a90-11e4-bc76-f314bf0101e2	t	371	Especialización en Derecho Laboral	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f382ae07-6a90-11e4-bc76-f314bf0101e2	t	146	Especialización en Derecho Penal	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f3825fc2-6a90-11e4-bc76-f314bf0101e2	t	109	Especialización en Derecho Procesal	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f3876983-6a90-11e4-bc76-f314bf0101e2	t	286	Especialización en Derecho Público	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	073dd124-0cf1-40b1-a828-935a2129fb09
f3832361-6a90-11e4-bc76-f314bf0101e2	t	188	Especialización en Derecho Tributario	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	67b2ca47-2a44-4f64-abde-af8772d718e0	e510decc-e55a-4de1-877a-b62090c355e8
f3821259-6a90-11e4-bc76-f314bf0101e2	t	36	Especialización en Diabetología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3885305-6a90-11e4-bc76-f314bf0101e2	t	320	Especialización en Endocrinología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382adf8-6a90-11e4-bc76-f314bf0101e2	t	131	Especialización en Endodoncia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	952601b3-4b5b-44ec-a42f-38e907f4546e	e510decc-e55a-4de1-877a-b62090c355e8
f3821258-6a90-11e4-bc76-f314bf0101e2	t	35	Especialización en Enfermería Familiar y Comunitaria	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3851f65-6a90-11e4-bc76-f314bf0101e2	t	240	Especialización en  Enseñanza Universitaria de la Arquitectura y el Diseño	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	e510decc-e55a-4de1-877a-b62090c355e8
f3821250-6a90-11e4-bc76-f314bf0101e2	t	27	Especialización en Esterilización	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f382125a-6a90-11e4-bc76-f314bf0101e2	t	37	Especialización en Estudios en Asia Oriental	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f388a142-6a90-11e4-bc76-f314bf0101e2	t	349	Especialización en Farmacia Hospitalaria	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f3821245-6a90-11e4-bc76-f314bf0101e2	t	16	Especialización en Farmacología Clínica	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382adfe-6a90-11e4-bc76-f314bf0101e2	t	137	Especialización en Flebología y Linfología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3876984-6a90-11e4-bc76-f314bf0101e2	t	287	Especialización en Gastroenterología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3851f58-6a90-11e4-bc76-f314bf0101e2	t	227	Especialización en Geriatría	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3832354-6a90-11e4-bc76-f314bf0101e2	t	175	Especialización en Hematología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	2b49eaa3-eaba-4603-adeb-012a37ba4f4f	e510decc-e55a-4de1-877a-b62090c355e8
f388c860-6a90-11e4-bc76-f314bf0101e2	t	363	Especialización en Infectología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382126d-6a90-11e4-bc76-f314bf0101e2	t	56	Especialización en Interpretación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f3825fa2-6a90-11e4-bc76-f314bf0101e2	t	77	Especialización en Investigación de la Comunicación	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3851f78-6a90-11e4-bc76-f314bf0101e2	t	259	Especialización en Medicina del Deporte	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382d52a-6a90-11e4-bc76-f314bf0101e2	t	165	Especialización en Medicina del Trabajo	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825fbb-6a90-11e4-bc76-f314bf0101e2	t	102	Especialización en Medicina Familiar y General	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3851f5b-6a90-11e4-bc76-f314bf0101e2	t	230	Especialización en Medicina Legal	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f382ae10-6a90-11e4-bc76-f314bf0101e2	t	155	Especialización en Medicina Transfusional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3876993-6a90-11e4-bc76-f314bf0101e2	t	302	Especialización en Nefrología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3887a22-6a90-11e4-bc76-f314bf0101e2	t	333	Especialización en Neonatología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3876994-6a90-11e4-bc76-f314bf0101e2	t	303	Especialización en Neumonología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3825f9e-6a90-11e4-bc76-f314bf0101e2	t	73	Especialización en Neurocirugía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	073dd124-0cf1-40b1-a828-935a2129fb09
f3832350-6a90-11e4-bc76-f314bf0101e2	t	171	Especialización en Neurología	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	15eca57a-fdbd-4588-8d74-b8fc47db14e4	e510decc-e55a-4de1-877a-b62090c355e8
f3876992-6a90-11e4-bc76-f314bf0101e2	t	301	Ingeniería Civil	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f384f840-6a90-11e4-bc76-f314bf0101e2	t	219	Ingeniería Mecánica Electricista	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f387699a-6a90-11e4-bc76-f314bf0101e2	t	309	Ingeniero Especialista en Telecomunicaciones Telefónicas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3876985-6a90-11e4-bc76-f314bf0101e2	t	288	Instrumentador Quirúrgico	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	78ed1e55-1f54-48a3-b505-54748ad44716	e510decc-e55a-4de1-877a-b62090c355e8
f384f83f-6a90-11e4-bc76-f314bf0101e2	t	218	Licenciatura en Ciencias de la Computación	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f3851f5d-6a90-11e4-bc76-f314bf0101e2	t	232	Licenciatura en Composición Musical	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f3876979-6a90-11e4-bc76-f314bf0101e2	t	276	Licenciatura en Física	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f387697d-6a90-11e4-bc76-f314bf0101e2	t	280	Licenciatura en Fonoaudiología	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	493d663d-fe6d-489b-9745-347c0bcaea80	e510decc-e55a-4de1-877a-b62090c355e8
f3825f98-6a90-11e4-bc76-f314bf0101e2	t	67	Licenciatura en Lengua y Literatura Francesas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f3821264-6a90-11e4-bc76-f314bf0101e2	t	47	Licenciatura en Lengua y Literatura Inglesa	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	6703de2d-9c21-4ceb-982c-a40b6fe42d88	e510decc-e55a-4de1-877a-b62090c355e8
f382125b-6a90-11e4-bc76-f314bf0101e2	t	38	Licenciatura en Letras Clásicas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f382125d-6a90-11e4-bc76-f314bf0101e2	t	40	Licenciatura en Letras Modernas	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a5a8c3c6-485f-428a-a483-3521f6af3f34	e510decc-e55a-4de1-877a-b62090c355e8
f388a14a-6a90-11e4-bc76-f314bf0101e2	t	357	Licenciatura en Matemática	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	8aab66e4-81b5-4c72-9b2b-fce7acaf4883	e510decc-e55a-4de1-877a-b62090c355e8
f3876982-6a90-11e4-bc76-f314bf0101e2	t	285	Licenciatura en Nutrición	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	eb50f50a-9064-407b-bb39-f5f1b19aadf9	e510decc-e55a-4de1-877a-b62090c355e8
f387698a-6a90-11e4-bc76-f314bf0101e2	t	293	Licenciatura en Producción de Bio-Imágenes	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a204a01d-41d2-4d0d-b046-f7944dae9ccf	e510decc-e55a-4de1-877a-b62090c355e8
f382ae13-6a90-11e4-bc76-f314bf0101e2	t	158	Licenciatura en Producción en Bio-Imágenes - Ciclo	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	a204a01d-41d2-4d0d-b046-f7944dae9ccf	e510decc-e55a-4de1-877a-b62090c355e8
f387698d-6a90-11e4-bc76-f314bf0101e2	t	296	Licenciatura en Química	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f3832376-6a90-11e4-bc76-f314bf0101e2	t	209	Licenciatura en Química Farmacéutica	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	073dd124-0cf1-40b1-a828-935a2129fb09
f3832353-6a90-11e4-bc76-f314bf0101e2	t	174	Licenciatura en  Teatro (Actoral)	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	5fc20193-5115-4bde-8b15-6de9a9502422	e510decc-e55a-4de1-877a-b62090c355e8
f383235e-6a90-11e4-bc76-f314bf0101e2	t	185	Licenciatura en Trabajo Social	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	be0f0322-10ac-4cb7-83ea-e36ab1ae04c0	e510decc-e55a-4de1-877a-b62090c355e8
f3851f66-6a90-11e4-bc76-f314bf0101e2	t	241	Licenciatura en Trabajo Social - Ciclo	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	be0f0322-10ac-4cb7-83ea-e36ab1ae04c0	e510decc-e55a-4de1-877a-b62090c355e8
f382ae0b-6a90-11e4-bc76-f314bf0101e2	t	150	Maestría en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	27866984-a0b4-4c38-bb80-e8902638b7b2	e510decc-e55a-4de1-877a-b62090c355e8
f382ae11-6a90-11e4-bc76-f314bf0101e2	t	156	Maestría en Ciencias de la Ingeniería Mención - Administración	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3876987-6a90-11e4-bc76-f314bf0101e2	t	290	Maestría en Ciencias de la Ingeniería - Mención Aeroespacial.	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f382fc3c-6a90-11e4-bc76-f314bf0101e2	t	167	Maestría en Ciencias de la Ingeniería - Mención Ambiente	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3832375-6a90-11e4-bc76-f314bf0101e2	t	208	Maestría en Ciencias de la Ingeniería - Mención en Estructuras y Geotecnia	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3821267-6a90-11e4-bc76-f314bf0101e2	t	50	Maestría en Ciencias de la Ingeniería Mención Recursos Hídricos	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	f6176f00-5018-4c33-b698-e474d85d0062	e510decc-e55a-4de1-877a-b62090c355e8
f3825f99-6a90-11e4-bc76-f314bf0101e2	t	68	Maestría en Comercio Internacional	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
f382ae12-6a90-11e4-bc76-f314bf0101e2	t	157	Maestría en Comunicación y Cultura Contemporánea	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3876997-6a90-11e4-bc76-f314bf0101e2	t	306	Maestría en Conservación y Rehabilitación del Patrimonio Arquitectónico	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	c6135604-895e-4a7c-b502-1c310ad119be	073dd124-0cf1-40b1-a828-935a2129fb09
f3851f57-6a90-11e4-bc76-f314bf0101e2	t	226	Maestría en Culturas y Literaturas Comparadas	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	49cb3c52-35c7-482e-9740-12c9096746bd	e510decc-e55a-4de1-877a-b62090c355e8
f387698c-6a90-11e4-bc76-f314bf0101e2	t	295	Maestría en Demografía	\N	bd5cbf93-b078-4950-89ab-acaf109fac66	da1d76fc-77f2-41a4-97e5-9926d481a536	1343f841-1373-4261-ad8c-4d4fe5b6de4e	e510decc-e55a-4de1-877a-b62090c355e8
f3876974-6a90-11e4-bc76-f314bf0101e2	t	271	Profesorado Universitario en Comunicación Social -Ciclo-	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f382adfd-6a90-11e4-bc76-f314bf0101e2	t	136	REVALIDA  DEL TITULO DE LICENCIADO EN ENFERMERIA	\N	a3f32ceb-a2be-4254-a3a9-466f789b262b	da1d76fc-77f2-41a4-97e5-9926d481a536	78ed1e55-1f54-48a3-b505-54748ad44716	e510decc-e55a-4de1-877a-b62090c355e8
f3851f6a-6a90-11e4-bc76-f314bf0101e2	t	245	Tecnicatura en Comunicación para las Organizaciones Sociales a Distancia	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f387425e-6a90-11e4-bc76-f314bf0101e2	t	265	Tecnicatura en Producción y Realización en Medios Masivos a Distancia	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	b17fe67c-6247-4f64-858a-f80e38f29372	e510decc-e55a-4de1-877a-b62090c355e8
f3876972-6a90-11e4-bc76-f314bf0101e2	t	269	Tecnicatura Universitaria en Jardinería y Floricultura	\N	58897c40-6dcf-47ca-af98-ed02991b0892	da1d76fc-77f2-41a4-97e5-9926d481a536	\N	e510decc-e55a-4de1-877a-b62090c355e8
\.


--
-- TOC entry 2107 (class 0 OID 1260012)
-- Dependencies: 166 2123
-- Data for Name: career_state; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY career_state (id, state_enable, code, name, comment) FROM stdin;
bbf002f1-a047-4c4b-a17d-71e4f0b717eb	t	1	Pendiente de Alta	\N
e510decc-e55a-4de1-877a-b62090c355e8	t	2	Vigente	\N
073dd124-0cf1-40b1-a828-935a2129fb09	t	3	No Vigente	\N
f463e2bf-e89c-4979-b565-3cc5c4cc801d	t	4	No Vigente con Actividad	\N
\.


--
-- TOC entry 2108 (class 0 OID 1260018)
-- Dependencies: 167 2123
-- Data for Name: career_type; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY career_type (id, state_enable, code, name, comment) FROM stdin;
58897c40-6dcf-47ca-af98-ed02991b0892	t	1	Pregrado	\N
a3f32ceb-a2be-4254-a3a9-466f789b262b	t	2	Grado	\N
bd5cbf93-b078-4950-89ab-acaf109fac66	t	3	Postgrado	\N
\.


--
-- TOC entry 2109 (class 0 OID 1260024)
-- Dependencies: 168 2123
-- Data for Name: edu_institution; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY edu_institution (id, state_enable, code, short_name, name, comment, url_logo, primary_institution) FROM stdin;
da1d76fc-77f2-41a4-97e5-9926d481a536	t	1	UNC	Universidad Nacional de Córdoba	\N	\N	t
\.


--
-- TOC entry 2110 (class 0 OID 1260030)
-- Dependencies: 169 2123
-- Data for Name: mig_codigos_internos_peu; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY mig_codigos_internos_peu (codigo_interno, codigo_ona, titulo, carrera, tipo_titulo, modalidad, nro_norma, fecha_norma, lote) FROM stdin;
 895,0	9536	Profesor Universitario en Comunicación Social	Profesorado Universitario en Comunicación Social - Ciclo	Grado	Presencial	RM 1774/2010	2010/12/01 00:00:00.000	Lote 1
892T	569	Técnico Univeristario en Comunicación Social	Licenciatura en Comunicación Social	Pregrado-Intermedio	Presencial	RM 573/1999	1999/04/27 00:00:00.000	Lote 1
 892,0	538	Licenciado en Comunicación Social	Licenciatura en Comunicación Social	Grado	Presencial	RM 573/1999	1999/04/27 00:00:00.000	Lote 1
89B	6224	Técnico en Comunicación y Turismo 	Tecnicatura en Comunicación y Turismo	Pregrado	Distancia	RM 5/2003	2003/01/06 00:00:00.000	Lote 1
89C	6230	Técnico en Periodismo Deportivo 	Tecnicatura en Periodismo Deportivo	Pregrado	Distancia	RM 5/2003	2003/01/06 00:00:00.000	Lote 1
89E	6245	Técnico en Producción y Realización en Medios Masivos 	Tecnicatura en Producción y Realización en Medios Masivos	Pregrado	Distancia	RM 5/2003	2003/01/06 00:00:00.000	Lote 1
89A	6222	Técnico en Relaciones Públicas	Tecnicatura en Relaciones Públicas	Pregrado	Distancia	RM 5/2003	2003/01/06 00:00:00.000	Lote 1
 339,0	990	Licenciado en Enfermería	Licenciatura en Enfermería	Grado	Presencial	RM1082/1994	1994/05/05 00:00:00.000	Lote 1
333	5465	Licenciado en Enfermería	Licenciatura en Enfermería - Ciclo de Complementación Curricular	Grado	Presencial	RM 1086/2011	2011/05/30 00:00:00.000	Lote 1
 338,0	6979	Enfermero	Licenciatura en Enfermería	Pregrado-Intermedio	Presencial	RM1082/1994	1994/05/05 00:00:00.000	Lote 1
 326,0	973	Licenciado en Fonoaudiología	Licenciatura en Fonoaudiología	Grado	Presencial	RM 471/2007	2007/05/07 00:00:00.000	Lote 1
 324,0	972	Fonoaudiólogo	Licenciatura en Fonoaudiología	Pregrado-Intermedio	Presencial	RM 471/2007	2007/05/07 00:00:00.000	Lote 1
 325,0	976	Licenciado en Kinesiología y Fisioterapia	Licenciatura en Kinesiología y Fisioterapia	Grado	Presencial	RM 1015/2002	2002/10/03 00:00:00.000	Lote 1
 345,0	979	Licenciado en Nutrición	Licenciatura en Nutrición	Grado	Presencial	RM 753/1998	1998/04/27 00:00:00.000	Lote 1
 872,0	524	Licenciado en Trabajo Social	Licenciatura en Trabajo Social	Grado	Presencial	RM 791/2005	2005/07/04 00:00:00.000	Lote 1
 873,0	8205	Licenciado en Trabajo Social	Licenciatura en Trabajo Social - Ciclo de Licenciatura	Grado	Distancia	RM 676/2011	2011/04/15 00:00:00.000	Lote 1
 328,0	4930	Licenciado en Producción de Bioimágenes	Licenciatura en Producción de Bioimágenes	Grado	Presencial	RM 2125/1997	1997/11/05 00:00:00.000	Lote 1
329_A	5992	Licenciado en Producción de Bio-imágenes	Licenciatura en Producción de Bioimágenes - Ciclo	Grado	Presencial	RM 1287/2012	2012/08/02 00:00:00.000	Lote 1
 322,0	10386	Técnico de Laboratorio Clínico e Histopatología	Técnico de Laboratorio Clínico e Histopatología	Pregrado	Presencial	RM 1269/2010	2012/08/02 00:00:00.000	Lote 1
011	118	Arquitecto	Arquitectura	Grado	Presencial	RM 664/2011	2011/04/11 00:00:00.000	Lote 1
012	135	Diseñador Industrial	Diseño Industrial	Grado	Presencial	RM 1127/1995	1995/11/27 00:00:00.000	Lote 1
831	6268	Ciclo Básico de Teatro	\N	\N	\N	\N	\N	Lote 1
820	11265	Ciclo Básico de Plástica	\N	\N	\N	\N	\N	Lote 1
825	11303	Profesor Superior de Educación en Artes Plásticas: Pintura	Profesorado Superior de Educación en Artes Plásticas: Pintura, Escultura, Grabado.	Grado	Presencial	RES HCS 1146/2012	\N	Lote 1
827	11301	Profesor Superior de Educación en Artes Plásticas:Escultura	Profesorado Superior de Educación en Artes Plásticas: Pintura, Escultura, Grabado.	Grado	Presencial	RES HCS 1146/2012	\N	Lote 1
828	11302	Profesor Superior de Educación en Artes Plásticas: Grabado.	Profesorado Superior de Educación en Artes Plásticas: Pintura, Escultura, Grabado.	Grado	Presencial	RES HCS 1146/2012	\N	Lote 1
841	890	Licenciado en Cine y Televisión	Licenciatura en Cine y Televisión	Grado	Presencial	RM 1683/2013	2013/08/22 00:00:00.000	Lote 1
805	2023	Licenciado en Composición Musical	Licenciatura en Composición Musical	Grado	Presencial	RM 245/2011	2011/12/30 00:00:00.000	Lote 1
824	848	Licenciado en Escultura	Licenciatura en Escultura	Grado	Presencial	RM1552/2012	2012/09/10 00:00:00.000	Lote 1
826	849	Licenciado en Grabado	Licenciatura en Grabado	Grado	Presencial	RM 1552/2012	2012/09/10 00:00:00.000	Lote 1
802	12233	Licenciado en Perfeccionamiento Instrumental (Piano)	Licenciatura en Perfeccionamiento Instrumental (Piano, Violín, Viola y Violoncello)	Grado	Presencial	RM 245/2011	2011/12/30 00:00:00.000	Lote 1
802B	12235	Licenciado en Perfeccionamiento Instrumental (Violín)	Licenciatura en Perfeccionamiento Instrumental (Piano, Violín, Viola y Violoncello)	Grado	Presencial	RM 245/2011	2011/12/30 00:00:00.000	Lote 1
802C	12234	Licenciado en Perfeccionamiento Instrumental (Viola )	Licenciatura en Perfeccionamiento Instrumental (Piano, Violín, Viola y Violoncello)	Grado	Presencial	RM 245/2011	2011/12/30 00:00:00.000	Lote 1
802D	12237	Licenciado en Perfeccionamiento Instrumental (Violoncello)	Licenciatura en Perfeccionamiento Instrumental (Piano, Violín, Viola y Violoncello)	Grado	Presencial	RM 245/2011	2011/12/30 00:00:00.000	Lote 1
822	850	Licenciado en Pintura	Licenciatura en Pintura	Grado	Presencial	RM 1552/2012	2011/09/10 00:00:00.000	Lote 1
807	5329	Licenciatura en Dirección Coral	Licenciado en Dirección Coral	Grado	Presencial	RM 481/2012	2012/04/12 00:00:00.000	Lote 1
832	891	Licenciado en Teatro	Licenciatura en Teatro	Grado	Presencial	RM 1117/1993	1993/05/26 00:00:00.000	Lote 1
805	10384	Profesor/a en Composición Musical	Profesorado en Composición Musical	Grado	Presencial	RM 1191/2012	2012/07/30 00:00:00.000	Lote 1
812	7428	Profesor/a en Educación Musical	Profesorado en Educación Musical	Grado	Presencial	RM 1190/2012	2012/07/30 00:00:00.000	Lote 1
801	12238	Profesor/a en Perfeccionamiento Instrumental (Piano)	Profesorado en Perfeccionamiento Instrumental (Piano, Violín, Viola o Violoncello)	Grado	Presencial	RM 1189/2012	2012/07/30 00:00:00.000	Lote 1
801B	12240	Profesor/a en Perfeccionamiento Instrumental ( Violín)	Profesorado en Perfeccionamiento Instrumental (Piano, Violín, Viola o Violoncello)	Grado	Presencial	RM 1189/2012	2012/07/30 00:00:00.000	Lote 1
801C	12239	Profesor/a en Perfeccionamiento Instrumental ( Viola )	Profesorado en Perfeccionamiento Instrumental (Piano, Violín, Viola o Violoncello)	Grado	Presencial	RM 1189/2012	2012/07/30 00:00:00.000	Lote 1
801D	12241	Profesor/a en Perfeccionamiento Instrumental (Violoncello)	Profesorado en Perfeccionamiento Instrumental (Piano, Violín, Viola o Violoncello)	Grado	Presencial	RM 1189/2012	2012/07/30 00:00:00.000	Lote 1
842	2012	Técnico Productor en Medios Audiovisuales	Licenciatura en Cine y Televisión	Pregrado-Intermedio	Presencial	RM 1683/2013	2013/08/22 00:00:00.000	Lote 1
843	844	Licenciado en Artes Visuales	Licenciatura en Artes Visuales	Grado	Presencial	RM 987/2013	2013/05/16 00:00:00.000	Lote 1
701	92	Ingeniero Agrónomo	Ingeniería Agronómica	Grado	Presencial	RM 991/2009	2009/06/30 00:00:00.000	Lote 1
712	11229	Técnico Univeristario en Jardinería y Floricultura	Tecnicatura Universitaria en Jardinería y Floricultura	Pregrado	Presencial	RM 1982/2010	2010/12/23 00:00:00.000	Lote 1
150	9793	Técnico en Gestión Universitaria	Tecnicatura en Gestión Universitaria	Pregrado	A Distancia	RM 755/2013	2013/04/22 00:00:00.000	Lote 1
120	7181	CICLO BASICO	\N	\N	\N	\N	\N	Lote 1
101	450	Contador Público	Contador Público	Grado	Presencial	RM 1118/2009	2009/07/17 00:00:00.000	Lote 1
125	386	Licenciado en Administración	Licenciatura en Administración	Grado	Presencial	RM 1118/2009, RM 556/2010	2009/07/17 00:00:00.000	Lote 1
111	464	Licenciado en Economía	Licenciatura en Economía	Grado	Presencial	RM 1118/2009	2009/07/17 00:00:00.000	Lote 1
138	10053	Profesor de Enseñanza Media y Superior en Ciencias Económicas	Profesorado de Enseñanza Media y Superior en Ciencias Económicas - Ciclo de Complementación Curricular	Grado	Presencial	RM 515/2013	2013/03/21 00:00:00.000	Lote 1
261	60	Biólogo	Ciencias Biológicas	Grado	Presencial	RM 3317/1994	1994/12/16 00:00:00.000	Lote 1
295	216	Constructor	Constructor	Grado	Presencial	RM 693/2002	2002/08/21 00:00:00.000	Lote 1
251	317	Geólogo	Geología	Grado	Presencial	RM 236/1995	1995/08/14 00:00:00.000	Lote 1
232	157	Ingeniero Aeronáutico	Ingeniería Aeronáutica	Grado	Presencial	RM 979/1997	1997/06/13 00:00:00.000	Lote 1
241	146	Ingeniero Agrimensor	Ingeniería en Agrimensura	Grado	Presencial	RM 2115/2007, RM 979/2013	7/12/2007, 15/05/2013	Lote 1
223	5390	Ingeniero Biomédico	Ingeniería Biomédica	Grado	Presencial	RM 1106/2008, RM 1408/2013	11/08/2008, 1/07/2013	Lote 1
201	158	Ingeniero Civil	Ingeniería Civil	Grado	Presencial	RM 739/2007	2007/06/14 00:00:00.000	Lote 1
281	173	Ingeniero Electrónico	Ingeniería Electrónica	Grado	Presencial	RM 456/2010	2010/04/13 00:00:00.000	Lote 1
247	252	Ingeniero Industrial	Ingeniería Industrial	Grado	Presencial	RM 571/2008, RM 1712/2013	16/05/2008, 22/08/2013	Lote 1
212	190	Ingeniero Mecánico	Ingeniería Mecánica	Grado	Presencial	RM 403/2008	2008/04/11 00:00:00.000	Lote 1
211	192	Ingeniero Mecánico Electricista	Ingeniería Mecánica Electricista	Grado	Presencial	RM 780/2007	2007/06/25 00:00:00.000	Lote 1
246	212	Ingeniero Químico	Ingeniería Química	Grado	Presencial	RM 2114/2007	2007/12/07 00:00:00.000	Lote 1
213	2392	Ingeniero Ambiental	Ingeniería Ambiental	Grado	Presencial	RES HCS 1516/2011	\N	Lote 1
285	270	Ingeniero en Computación	Ingeniería en Computación	Grado	Presencial	RM 212/2001	2001/03/19 00:00:00.000	Lote 1
271	77	Profesor en Ciencias Biológicas	Profesorado en Ciencias Biológicas	Grado	Presencial	RM 3317/1994	1994/12/16 00:00:00.000	Lote 1
296	2006	Técnico Mecánico Electricista	Técnico Mecánico Electricista	Pregrado	Presencial	RM 47/1999	1999/01/14 00:00:00.000	Lote 1
304	959	Médico	Medicina	Grado	Presencial	RM 1486/2012	2012/08/30 00:00:00.000	Lote 1
301	960	Médico Cirujano (No vigente) 	Medicina	Grado	Presencial	\N	\N	Lote 1
CBCPM	4924	CICLO BASICO	\N	\N	\N	\N	\N	Lote 1
551	334	Bioquímico	Bioquímica	Grado	Presencial	RM 1643/2012	2012/09/20 00:00:00.000	Lote 1
5512	\N	Bioquímico	Bioquímica	Grado	\N	\N	\N	Lote 1
545	337	Farmacéutico	Farmacia	Grado	Presencial	RM 852/2013	2013/04/30 00:00:00.000	Lote 1
5452	\N	Farmacéutico	Farmacia	Grado	\N	\N	\N	Lote 1
531	37	Licenciado en Química	Licenciatura en Química	Grado	Presencial	RM 364/1995	1995/02/27 00:00:00.000	Lote 1
555	\N	Licenciado en Bioquímica Clínica	No vigente  .solo para titulos (Egre)	Grado	Presencial	\N	\N	Lote 1
541	\N	Licenciado en Química Farmacéutica 	No vigente  .solo para titulos (Egre)	Grado	Presencial	\N	\N	Lote 1
061	360	Notario	Ciclo Notarial	Grado	Presencial	RM 434/2000	2000/05/22 00:00:00.000	Lote 1
051	349	Abogado	Abogacía	Grado	Presencial	HCS 544/99	\N	Lote 1
052	361	Procurador (Título No vigente)	Abogacía	Pregrado-Intermedio 	Presencial	\N	\N	Lote 1
445	517	Licenciado en Antropología	Licenciatura en Antropología	Grado	Presencial	RM 1000/2009	2009/06/30 00:00:00.000	Lote 1
482	3877	Licenciado en Archivología	Archivología	Grado	Presencial	RM 228/2000	2000/12/07 00:00:00.000	Lote 1
472	578	Licenciado en Bibliotecología y Documentación	Licenciatura en Bibliotecología y Documentación	Grado	Presencial	RM 907/1996	1996/08/26 00:00:00.000	Lote 1
451	726	Licenciado en Ciencias de la Educación	Licenciatura en Ciencias de la Educación	Grado	Presencial	RM 762/2003	2003/12/01 00:00:00.000	Lote 1
451A	3938	Licenciado en Ciencias de la Educación	Licenciatura en Ciencias de la Educación - Ciclo	Grado	Presencial	RM 36/2011	2011/12/19 00:00:00.000	Lote 1
401	643	Licenciado en Filosofía	Licenciatura en Filosofía	Grado	Presencial	RM 1077/2012	2012/07/20 00:00:00.000	Lote 1
491	612	Licenciado en Geografía	Licenciatura en Geografía	Grado	Presencial	RM 192/2003	2003/02/14 00:00:00.000	Lote 1
441	794	Licenciado en Historia	Licenciatura en Historia	Grado	Presencial	RM 1194/2012	2012/07/30 00:00:00.000	Lote 1
411	651	Licenciado en Letras Clásicas	Licenciatura en Letras Clásicas	Grado	Presencial	RM 789/2012	2012/06/08 00:00:00.000	Lote 1
421	652	Licenciado en Letras Modernas	Licenciatura en Letras Modernas	Grado	Presencial	RM 889/2002, RM 1188/2005	23/9/2002, 7/10/2005	Lote 1
418	11542	Profesor en Letras Clásicas	Profesorado en Letras Clásicas	Grado	Presencial	RM 1371/2012	2012/08/17 00:00:00.000	Lote 1
458	732	Profesor en Ciencias de la Educación	Profesorado en Ciencias de la Educación	Grado	Presencial	RM 762/2003	2003/12/01 00:00:00.000	Lote 1
408	643	Profesor en Filosofía	Profesorado en Filosofía	Grado	Presencial	RM 797/2005	2005/07/04 00:00:00.000	Lote 1
448	6189	Profesor en Historia	Profesorado en Historia	Grado	Presencial	RM 1195/2012	2013/07/30 00:00:00.000	Lote 1
428	10750	Profesor en Letras Modernas	Profesorado en Letras Modernas	Grado	Presencial	RM 310/2003	2003/03/06 00:00:00.000	Lote 1
471	2079	Bibliotecólogo	Bibliotecología	Pregrado	Presencial	RM 907/1996	1996/08/26 00:00:00.000	Lote 1
422	7189	Corrector Literario	Técnico Instrumental de Corrector Literario	Pregrado	Presencial	RM 889/2002	2002/09/23 00:00:00.000	Lote 1
481	6231	Técnico Profesional Archivero	Archivología	Pregrado-Intermedio	Presencial	RM 228/2000	2000/12/07 00:00:00.000	Lote 1
74B	6220	Licenciado en Español Lengua Materna y Lengua Extranjera	Licenciatura en Español Lengua Materna y Lengua Extranjera	Grado	Presencial	RM 1106/2002	2002/11/01 00:00:00.000	Lote 1
781	4926	Licenciado en Lengua y Literatura Alemanas	Licenciatura en Lengua y Literatura Alemanas	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
761	4928	Licenciado en Lengua y Literatura Francesas	Licenciatura en Lengua y Literatura Francesas	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
751	4886	Licenciado en Lengua y Literatura Inglesas	Licenciatura en Lengua y Literatura Inglesas	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
771	4929	Licenciado en Lengua y Literatura Italianas	Licenciatura en Lengua y Literatura Italianas	Grado	Presencial	RM1471/1993	1993/07/06 00:00:00.000	Lote 1
789	10050	Profesor de Lengua Alemana	Profesorado de Lengua Alemana	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
769	10052	Profesor de Lengua Francesa	Profesorado de Lengua Francesa	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
759	695	Profesor de Lengua Inglesa	Profesorado de Lengua Inglesa	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
779	10051	Profesor de Lengua Italiana	Profesorado en Lengua Italiana	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
739	3875	Profesor de Portugués	Profesorado de Portugués	Grado	Presencial	RM 477/2000	2000/06/02 00:00:00.000	Lote 1
74A	6219	Profesor en Español Lengua Materna y Lengua Extranjera	Profesorado en Español Lengua Materna y Lengua Extranjera	Grado	Presencial	RM 1106/2002	2002/11/01 00:00:00.000	Lote 1
782	10222	Traductor Público Nacional de Alemán	Traductorado Público Nacional de Alemán	Grado	Presencial	RM 1471/9393	1993/07/06 00:00:00.000	Lote 1
762	10223	Traductor Público Nacional de Francés	Traductorado Público Nacional de Francés	Grado	Presencial	RM 1471/9393	1993/07/06 00:00:00.000	Lote 1
752	10224	Traductor Público Nacional de Inglés	Traductorado Público Nacional de Inglés	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
772	10225	Traductor Público Nacional de Italiano	traductorado Público Nacional de Italiano	Grado	Presencial	RM 1471/1993	1993/07/06 00:00:00.000	Lote 1
611	333	Licenciado en Astronomía	Licenciatura en Astronomía	Grado	Presencial	RM 1184/2012	2012/07/30 00:00:00.000	Lote 1
638	2053	Licenciado en Ciencias de la Computación	Licenciatura en Ciencias de la Computación	Grado	Presencial	RM 673/1999	1999/08/18 00:00:00.000	Lote 1
621	24	Licenciado en Física	Licenciatura en Física	Grado	Presencial	RM 1113/2009	2009/07/17 00:00:00.000	Lote 1
601	3	Licenciado en Matemática	Licenciatura en Matemática	Grado	Presencial	RM 2258/2012	2012/12/11 00:00:00.000	Lote 1
6287/628	29	Profesor en Física	Profesorado en Física	Grado	Presencial	RM 103/1998	1998/01/27 00:00:00.000	Lote 1
6085/608	13	Profesor en Matemática	Profesorado en Matemática	Grado	Presencial	RM 103/1998	1998/01/27 00:00:00.000	Lote 1
637	264	Analista en Computación	Licenciatura en Ciencias de la Computación	Pregrado-Intermedio	Presencial	RM 673/1999	1999/08/18 00:00:00.000	Lote 1
501	964	Odontólogo	Odontología	Grado	Presencial	RM 1199/2012	2012/07/30 00:00:00.000	Lote 1
461	809	Licenciado en Psicología	Licenciatura en Psicología	Grado	Presencial	HCS 98/86	\N	Lote 1
468	5192	Profesor en Psicología	Profesorado en Psicología	Grado	Presencial	HCS 98/86	\N	Lote 1
\.


--
-- TOC entry 2111 (class 0 OID 1260036)
-- Dependencies: 170 2123
-- Data for Name: mig_ofertas_araucano; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY mig_ofertas_araucano (id_unidad_academica_araucano, unidad_academica, id_oferta_oficial, id_titulo_oficial, codigo_titulo_ona, denominacion, modalidad, tipo_titulo, activa, oficial, lote) FROM stdin;
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8412,0	 8109,0	8109	Magister en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	Presencial	Maestría	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 104458,0	 11442,0	11442	Magister en Ciencias Agropecuarias con Mención en Protección Vegetal	Presencial	Maestría	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8670,0	 6467,0	6467	Especialista en Farmacología Clínica	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8803,0	 6121,0	6121	CBC - Licenciado en Química	Presencial	Ciclo Básico Común	N	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 102419,0	 10585,0	10585	Magister en Ciencias Agropecuarias - Mención Recursos Naturales	Presencial	Maestría	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 403,0	 6230,0	6230	Técnico en Periodismo Deportivo - MD	A Distancia	Técnico Instrumental	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 101882,0	 9585,0	9585	Doctor en Estudios de Género	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8730,0	 643,0	643	Profesor en Filosofía	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8746,0	 3728,0	3728	Especialista en Enseñanza de la Lengua y la Literatura	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8668,0	 6469,0	6469	Especialista en Radiología y Diagnóstico por Imágenes	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8757,0	 1493,0	1493	Magister en Antropología Social	Presencial	Maestría	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 101854,0	 8314,0	8314	Especialista en Comunicación Pública de la Ciencia y Periodismo Científico	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105114,0	 849,0	849	Licenciado en Grabado	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8277,0	 7742,0	7742	Especialista en Estudios de Asia Oriental con Orientación en China	Presencial	Especialidad	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8741,0	 4932,0	4932	Licenciado en Teatro orientación Escenográfica	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8842,0	 192,0	192	Ingeniero Mecánico Electricista	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8675,0	 6451,0	6451	Magister en Salud Materno Infantil	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 102011,0	 9577,0	9577	Especialista en Traducción Científica y Técnica - MD	A Distancia	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7661,0	 709,0	709	Traductor Público Nacional en Inglés	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7664,0	 679,0	679	Traductor Público Nacional en Francés	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 105212,0	 10777,0	10777	Especialista en Producción y Analisis de Información para Políticas Públicas	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105117,0	 11303,0	11303	Profesor Superior de Educación en Artes Plásticas: Pintura	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 101098,0	 10224,0	10224	Traductor Público Nacional de Inglés	Presencial	Grado	N	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8773,0	 1295,0	1295	Especialista en Derecho Penal	Presencial	Especialidad	Y	Y	Lote 1
 170,0	Escuela de Trabajo Social	 105187,0	 8205,0	8205	Licenciado en Trabajo Social - Ciclo de Licenciatura - MD	A Distancia	Ciclo de Licenciatura	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8748,0	 2367,0	2367	Profesor de Letras Clásicas	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 103394,0	 100365,0	100365	Perito Mercantil-Bachiller	Presencial	Secundario	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 101967,0	 10384,0	10384	Profesor en Composición Musical	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102544,0	 100200,0	100200	Auxiliar Técnico en Operaciones Financieras	Presencial	Terciario No Universitario	N	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8423,0	 1239,0	1239	Magister en Estadística Aplicada	Presencial	Maestría	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8284,0	 7299,0	7299	Magister en Formulación y Desarrollo de Estrategias Públicas y Privadas	Presencial	Maestría	N	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8790,0	 1407,0	1407	Especialista en Tributación	Presencial	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8291,0	 6574,0	6574	Magister en Demografía	Presencial	Maestría	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8792,0	 1391,0	1391	Magister en Comercio Internacional	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8821,0	 9098,0	9098	Magister en Gestión Integrada de los Recursos Hídricos	Presencial	Maestría	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8673,0	 6457,0	6457	Especialista en Oftalmología	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8823,0	 77,0	77	Profesor en Ciencias Biológicas	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 101745,0	 10135,0	10135	Técnico Superior en Gestión Financiera	Presencial	Otros Pregrados	N	Y	Lote 1
 2741,0	Facultad de Artes	 103990,0	 11303,0	11303	Profesor Superior de Educación en Artes Plásticas: Pintura	Presencial	Grado	Y	Y	Lote 1
 177,0	Escuela de Tecnologí­a Médica	 104298,0	 11375,0	11375	Técnico de Radiología	Presencial	Otros Pregrados	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8732,0	 6268,0	6268	CBC - Licenciado en Teatro	Presencial	Ciclo Básico Común	N	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 101659,0	 100136,0	100136	Bachiller Humanista con Orientación en Humanidades y Ciencias Sociales	Presencial	Secundario	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 104454,0	 11440,0	11440	Magister en Ciencias Agropecuarias con Mención en Economía y Desarrollo Rural	Presencial	Maestría	N	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 102486,0	 5111,0	5111	Licenciado en Bioquímica	Presencial	Grado	N	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 101676,0	 10138,0	10138	Técnico Superior en Bromatología	Presencial	Otros Pregrados	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8743,0	 4923,0	4923	CBC - Profesor Superior de Artes Plásticas	Presencial	Ciclo Básico Común	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8720,0	 7325,0	7325	Especialista en Asesoramiento y Gestión Pedagógica	Presencial	Especialidad	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 405,0	 6224,0	6224	Técnico en Comunicación y Turismo - MD	A Distancia	Técnico Instrumental	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8299,0	 1454,0	1454	Doctor en Ciencia Política	Presencial	Doctorado	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 407,0	 538,0	538	Licenciado en Comunicación Social	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 101883,0	 9594,0	9594	Especialista en Turismo Alternativo	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8703,0	 1631,0	1631	Especialista en Clínica Médica	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8786,0	 464,0	464	Licenciado en Economía	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8830,0	 7316,0	7316	Magister en Ciencias de la Ingeniería Mención de Administración	Presencial	Maestría	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 103627,0	 4859,0	4859	Obstetra	Presencial	Grado	Y	Y	Lote 1
 179,0	Escuela de Fonoaudiologí­a	 8431,0	 972,0	972	Fonoaudiólogo	Presencial	Título Intermedio	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8867,0	 92,0	92	Ingeniero Agrónomo	Presencial	Grado	Y	Y	Lote 1
 177,0	Escuela de Tecnologí­a Médica	 8655,0	 4930,0	4930	Licenciado en Producción de Bioimágenes	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 101744,0	 2860,0	2860	Técnico Superior en Comercialización	Presencial	Otros Pregrados	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8697,0	 1645,0	1645	Especialista en Infectología	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8819,0	 1067,0	1067	Magister en Química	Presencial	Maestría	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8682,0	 2991,0	2991	Especialista en Neonatología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8725,0	 726,0	726	Licenciado en Ciencias de la Educación	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8815,0	 2727,0	2727	Especialista en Química Clínica	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 102012,0	 8333,0	8333	Magister en Lenguajes e Interculturalidad	Presencial	Maestría	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105118,0	 850,0	850	Licenciado en Pintura	Presencial	Grado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8777,0	 8234,0	8234	Especialista en Gestión de Tecnologías Innovadoras	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8796,0	 8230,0	8230	Especialista en Bioquímica Clínica en Endocrinología	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7666,0	 6581,0	6581	Magister en Inglés con Orientación en Literatura Angloamericana	Presencial	Maestría	Y	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 8573,0	 6566,0	6566	Magister en Neuropsicología	Presencial	Maestría	N	Y	Lote 1
 2741,0	Facultad de Artes	 103804,0	 10384,0	10384	Profesor en Composición Musical	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8733,0	 612,0	612	Licenciado en Geografía	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102148,0	 100145,0	100145	Bachiller orientado en Economía y Gestión y Técnico Básico en Gestión Organizacional	Presencial	Secundario	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8417,0	 29,0	29	Profesor en Física	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8820,0	 1058,0	1058	Doctor en Ciencias Químicas	Presencial	Doctorado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 103405,0	 1064,0	1064	Magister en Ciencias Químicas	Presencial	Maestría	Y	Y	Lote 1
 178,0	Escuela de Enfermerí­a	 8654,0	 6451,0	6451	Magister en Salud Materno Infantil	Presencial	Maestría	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8288,0	 7288,0	7288	Magister en Políticas y Gestión del Desarrollo Local	Presencial	Maestría	N	Y	Lote 1
 2146,0	Facultad de Lenguas	 7671,0	 4936,0	4936	Profesor en Lengua Francesa	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8708,0	 1616,0	1616	Doctor en Medicina y Cirugía	Presencial	Doctorado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8286,0	 7297,0	7297	Especialista en Comunicación, Medios y Prácticas Educativas	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103987,0	 2012,0	2012	Técnico Productor en Medios Audiovisuales	Presencial	Título Intermedio	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7668,0	 6219,0	6219	Profesor en Español Lengua Materna y Lengua Extranjera	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8295,0	 6443,0	6443	Magister en Políticas y Estrategias	Presencial	Maestría	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8425,0	 1040,0	1040	Doctor en Física	Presencial	Doctorado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8659,0	 7493,0	7493	Especialista en Salud Social y Comunitaria	Presencial	Especialidad	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8875,0	 6568,0	6568	Doctor en Ciencias Agropecuarias	Presencial	Doctorado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7667,0	 6220,0	6220	Licenciado en Español Lengua Materna y Lengua Extranjera	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8674,0	 6456,0	6456	Especialista en Cirugía Pediátrica	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8853,0	 1075,0	1075	Doctor en Ciencias Biológicas	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8750,0	 2024,0	2024	Licenciado en Perfeccionamiento Instrumental	Presencial	Grado	N	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 103219,0	 10980,0	10980	Especialista en Mercosur - Aspectos Jurídico - Económicos	Presencial	Especialidad	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 101972,0	 1538,0	1538	Doctor en Letras Modernas	Presencial	Doctorado	N	Y	Lote 1
 2741,0	Facultad de Artes	 104291,0	 890,0	890	Licenciado en Cine y Televisión	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 104900,0	 11560,0	11560	Especialista en Psicopedagogía	Presencial	Especialidad	N	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8779,0	 7335,0	7335	Doctor en Ciencias Económicas con Mención Ciencias Empresariales	Presencial	Doctorado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8835,0	 317,0	317	Geólogo	Presencial	Grado	Y	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 101660,0	 100137,0	100137	Preceptor y Auxiliar Docente	Presencial	Terciario No Universitario	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8689,0	 1662,0	1662	Especialista en Psiquiatría	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 103562,0	 11183,0	11183	Especialista en Medicina Generalista	Presencial	Especialidad	N	Y	Lote 1
 2146,0	Facultad de Lenguas	 7659,0	 725,0	725	Traductor Público Nacional en Italiano	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8694,0	 1650,0	1650	Especialista en Medicina Legal	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7676,0	 4926,0	4926	Licenciado en Lengua y Literatura Alemanas	Presencial	Grado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8771,0	 1302,0	1302	Especialista en Derecho Público	Presencial	Especialidad	N	Y	Lote 1
 1819,0	Instituto de Investigación y Formación en la Administración Pública	 8274,0	 6890,0	6890	Magister en Administración Pública, Provincial y Municipal	Presencial	Maestría	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8838,0	 216,0	216	Constructor	Presencial	Grado	Y	Y	Lote 1
 180,0	Escuela de Kinesiologí­a y Fisioterapia	 100997,0	 4153,0	4153	Fisioterapeuta	Presencial	Otros Pregrados	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 100047,0	 959,0	959	Médico	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8754,0	 1557,0	1557	Doctor en Ciencias de la Educación	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 104698,0	 11542,0	11542	Profesor en Letras Clásicas	Presencial	Grado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8421,0	 13,0	13	Profesor en Matemática	Presencial	Grado	Y	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 101675,0	 4770,0	4770	Martillero y Corredor Público	Presencial	Otros Pregrados	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103797,0	 6268,0	6268	CBC - Licenciado en Teatro	Presencial	Ciclo Básico Común	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8724,0	 7302,0	7302	Especialista en Adolescencia con Mención en Educación o Psicología del Desarrollo	Presencial	Especialidad	N	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 103295,0	 10996,0	10996	Especialista en Adolescencia con Mención en Psicología del Desarrollo	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 100423,0	 5111,0	5111	Licenciado en Bioquímica	Presencial	Grado	N	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8415,0	 3224,0	3224	Doctor en Matemática	Presencial	Doctorado	Y	Y	Lote 1
 177,0	Escuela de Tecnologí­a Médica	 8656,0	 1004,0	1004	Técnico en Laboratorio Clínico e Histopatología	Presencial	Técnico Instrumental	Y	Y	Lote 1
 178,0	Escuela de Enfermerí­a	 8652,0	 989,0	989	Enfermera/o	Presencial	Título Intermedio	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8690,0	 1659,0	1659	Especialista en Otorrinolaringología	Presencial	Especialidad	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102545,0	 100201,0	100201	Auxiliar Técnico en Remuneraciones	Presencial	Terciario No Universitario	N	Y	Lote 1
 178,0	Escuela de Enfermerí­a	 8651,0	 990,0	990	Licenciado en Enfermería	Presencial	Grado	Y	Y	Lote 1
 177,0	Escuela de Tecnologí­a Médica	 101971,0	 10386,0	10386	Técnico de Laboratorio Clínico e Histopatología	Presencial	Otros Pregrados	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105121,0	 7428,0	7428	Profesor en Educación Musical	Presencial	Grado	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8870,0	 8112,0	8112	Especialista en Producción de Cultivos Extensivos	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103799,0	 848,0	848	Licenciado en Escultura	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 100998,0	 891,0	891	Licenciado en Teatro	Presencial	Grado	Y	Y	Lote 1
 170,0	Escuela de Trabajo Social	 104568,0	 11467,0	11467	Magister en Ciencias Sociales con Mención en Metodología de la Investigación Social	Presencial	Maestría	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8860,0	 6546,0	6546	Especialista en Planificación y Diseño del Paisaje	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8707,0	 1618,0	1618	Especialista en Alergia e Inmunología	Presencial	Especialidad	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 101747,0	 10133,0	10133	Analista de Sistemas de Informática	Presencial	Otros Pregrados	N	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8783,0	 7181,0	7181	Ciclo Básico	Presencial	Ciclo Básico Común	N	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8817,0	 2021,0	2021	Licenciado en Química Farmacéutica	Presencial	Grado	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8671,0	 6459,0	6459	Especialista en Patología	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8808,0	 3716,0	3716	Especialista en Parasitología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8728,0	 652,0	652	Licenciado en Letras Modernas	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 100702,0	 6189,0	6189	Profesor en Historia	Presencial	Grado	Y	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 103629,0	 100031,0	100031	Bachiller	Presencial	Secundario	N	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 103807,0	 11229,0	11229	Técnico Universitario en Jardinería y Floricultura	Presencial	Otros Pregrados	Y	Y	Lote 1
 179,0	Escuela de Fonoaudiologí­a	 8430,0	 973,0	973	Licenciado en Fonoaudiología	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105119,0	 891,0	891	Licenciado en Teatro	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8742,0	 4931,0	4931	Licenciado en Teatro orientación Actoral	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8676,0	 10586,0	10586	Magister en Gerencia y Administración de Servicios de Salud	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7658,0	 7327,0	7327	Doctor en Ciencias del Lenguaje con Mención en Traductología	Presencial	Doctorado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8419,0	 24,0	24	Licenciado en Física	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8706,0	 1621,0	1621	Especialista en Anestesiología	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8841,0	 2006,0	2006	Técnico Mecánico Electricista	Presencial	Técnico Instrumental	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8832,0	 60,0	60	Biólogo	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8667,0	 6470,0	6470	Especialista en Medicina Familiar y General	Presencial	Especialidad	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 402,0	 6245,0	6245	Técnico en Producción y Realización en Medios Masivos - MD	A Distancia	Técnico Instrumental	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8862,0	 2377,0	2377	Magister en Gestión Ambiental del Desarrollo Urbano	Presencial	Maestría	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 101828,0	 7428,0	7428	Profesor en Educación Musical	Presencial	Grado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8776,0	 9793,0	9793	Técnico en Gestión Universitaria - MD	A Distancia	Otros Pregrados	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8740,0	 4934,0	4934	Profesor de Letras Modernas	Presencial	Grado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8778,0	 7738,0	7738	Especialista en Gestión de Innovación y la Vinculación Tecnológica	Presencial	Especialidad	N	Y	Lote 1
 170,0	Escuela de Trabajo Social	 103162,0	 3940,0	3940	Licenciado en Trabajo Social - Ciclo de Licenciatura	Presencial	Ciclo de Licenciatura	N	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8411,0	 8110,0	8110	Magister en Análisis y Procesamiento de Imágenes	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8833,0	 5390,0	5390	Ingeniero Biomédico	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 103121,0	 100343,0	100343	Bachiller orientado en Economía y Gestión de las organizaciones y Técnico Básico en Gestión Organizacional	Presencial	Secundario	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 101902,0	 9576,0	9576	Especialista en Traducción Jurídica y Económica - MD	A Distancia	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 102108,0	 9622,0	9622	Magister en Microbiología, con orientación en Investigación en Salud Humana	Presencial	Maestría	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8416,0	 3,0	3	Licenciado en Matemática	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 101673,0	 10220,0	10220	Doctor en Fisicoquímica	Presencial	Doctorado	N	Y	Lote 1
 170,0	Escuela de Trabajo Social	 105178,0	 8205,0	8205	Licenciado en Trabajo Social - Ciclo de Licenciatura - MD	A Distancia	Ciclo de Complementación Curricular	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 100980,0	 695,0	695	Profesor de Lengua Inglesa	Presencial	Grado	N	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8878,0	 3074,0	3074	Magister en Ciencias Agropecuarias	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7674,0	 4928,0	4928	Licenciado en Lengua y Literatura Francesas	Presencial	Grado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8414,0	 333,0	333	Licenciado en Astronomía	Presencial	Grado	Y	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 8572,0	 7302,0	7302	Especialista en Adolescencia con Mención en Educación o Psicología del Desarrollo	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7680,0	 1547,0	1547	Magister en Lingüística Aplicada a la Enseñanza de la Lengua (Materna o Extranjera)	Presencial	Maestría	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 102418,0	 10584,0	10584	Magister en Ciencias Agropecuarias  - Mención Producción Vegetal	Presencial	Maestría	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8714,0	 849,0	849	Licenciado en Grabado	Presencial	Grado	Y	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 104137,0	 11350,0	11350	Dibujante Especialista en Dibujo Técnico, Decorativo y Publicitario	Presencial	Terciario No Universitario	N	Y	Lote 1
 1819,0	Instituto de Investigación y Formación en la Administración Pública	 102487,0	 10634,0	10634	Especialista en Administración Pública Provincial y Municipal	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 103930,0	 11278,0	11278	Doctor en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	Presencial	Doctorado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8793,0	 1239,0	1239	Magister en Estadística Aplicada	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 104107,0	 11353,0	11353	Doctor en Ciencias del Lenguaje, Mención en Culturas y Literaturas Comparadas	Presencial	Doctorado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8765,0	 361,0	361	Procurador	Presencial	Título Intermedio	N	Y	Lote 1
 2741,0	Facultad de Artes	 105115,0	 11301,0	11301	Profesor Superior de Educación en Artes Plásticas: Escultura	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8297,0	 1488,0	1488	Magister en Sociología	Presencial	Maestría	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 103467,0	 554,0	554	Técnico en Comunicación Social	Presencial	Grado	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8749,0	 2079,0	2079	Bibliotecólogo	Presencial	Título Intermedio	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7657,0	 7328,0	7328	Doctor en Ciencias del Lenguaje Mención Culturas y Literaturas Comparadas	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8711,0	 900,0	900	Licenciado en Composición	Presencial	Grado	N	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8818,0	 1637,0	1637	Especialista en Endocrinología	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 103160,0	 10052,0	10052	Profesor de Lengua Francesa	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8738,0	 4943,0	4943	Profesor Superior en Composición	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102543,0	 100199,0	100199	Asistente Técnico en Relaciones Laborales	Presencial	Terciario No Universitario	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8822,0	 7727,0	7727	Magister en Educación en Ciencias Experimentales y Tecnología	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8850,0	 144,0	144	Agrimensor	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8662,0	 6476,0	6476	Especialista en Neurocirugía	Presencial	Especialidad	N	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8789,0	 3713,0	3713	Magister en Dirección de Negocios	Presencial	Maestría	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105130,0	 11266,0	11266	Licenciado en Perfeccionamiento Instrumental (Piano, Violín, Viola y Violoncello)	Presencial	Grado	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8874,0	 6569,0	6569	Magister en Ciencias Agropecuarias - Mención Agrometeorología	Presencial	Maestría	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 102157,0	 3008,0	3008	Doctor en Comunicación Social	Presencial	Doctorado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105112,0	 5329,0	5329	Licenciado en Dirección Coral	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 102769,0	 10223,0	10223	Traductor Público Nacional de Francés	Presencial	Grado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 103713,0	 271,0	271	Licenciado en Computación	Presencial	Grado	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8727,0	 6571,0	6571	Doctor en Semiótica	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 102104,0	 10476,0	10476	Especialista en Sociopsicogénesis del Entendimiento Escolar	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8739,0	 4940,0	4940	Profesor Superior de Educación en Artes Plásticas	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103802,0	 891,0	891	Licenciado en Teatro	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103805,0	 7428,0	7428	Profesor en Educación Musical	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7672,0	 4935,0	4935	Profesor en Lengua Alemana	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8287,0	 7289,0	7289	Magister en Investigación Educativa Mención Socioantropológica	Presencial	Maestría	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8280,0	 7729,0	7729	Doctor en Estudios Sociales de América Latina	Presencial	Doctorado	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 104457,0	 11443,0	11443	Magister en Ciencias Agropecuarias con Mención en Producción Vegetal	Presencial	Maestría	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8837,0	 252,0	252	Ingeniero Industrial	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 103161,0	 10967,0	10967	Profesor de Lengua y Literatura Castellanas	Presencial	Grado	N	Y	Lote 1
 180,0	Escuela de Kinesiologí­a y Fisioterapia	 8408,0	 976,0	976	Licenciado en Kinesiología y Fisioterapia	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8717,0	 800,0	800	Profesor de Historia	Presencial	Grado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 100981,0	 10053,0	10053	Profesor de Enseñanza Media y Superior en Ciencias Económicas	Presencial	Grado	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8824,0	 7490,0	7490	Magister en Ciencias de la Ingeniería - Mención Ambiente	Presencial	Maestría	Y	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 101674,0	 10137,0	10137	Comunicador Visual	Presencial	Otros Pregrados	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7670,0	 4937,0	4937	Profesor en Lengua Inglesa	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8721,0	 7324,0	7324	Magister en Pedagogía	Presencial	Maestría	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8865,0	 1137,0	1137	Magister en Diseño Arquitectónico y Urbano	Presencial	Maestría	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8864,0	 118,0	118	Arquitecto	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8840,0	 212,0	212	Ingeniero Químico	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105113,0	 848,0	848	Licenciado en Escultura	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8834,0	 5364,0	5364	Doctor en Ciencias de la Ingeniería	Presencial	Doctorado	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8855,0	 7333,0	7333	Especialista en Tecnología Arquitectónica	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7656,0	 7329,0	7329	Doctor en Ciencias del Lenguaje Mención en Lingüística Aplicada	Presencial	Doctorado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8813,0	 334,0	334	Bioquímico	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103803,0	 4940,0	4940	Profesor Superior de Educación en Artes Plásticas	Presencial	Grado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8298,0	 1472,0	1472	Magister en Relaciones Internacionales	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8843,0	 191,0	191	Ingeniero Mecánico Aeronáutico	Presencial	Grado	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8871,0	 8098,0	8098	Especialista en Tecnologías Multimedia para Desarrollos Educativos	A Distancia	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8289,0	 6576,0	6576	Magister en Sociosemiótica	Presencial	Maestría	Y	Y	Lote 1
 170,0	Escuela de Trabajo Social	 8758,0	 7336,0	7336	Maestría en Ciencias Sociales con Mención en Metodología de la Investigación Social y Mención en Políticas Sociales	Presencial	Maestría	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8769,0	 1454,0	1454	Doctor en Ciencia Política	Presencial	Doctorado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 104302,0	 11385,0	11385	Auxiliar Técnico en Administración Cooperativa	Presencial	Otros Pregrados	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8683,0	 2939,0	2939	Especialista en Neumonología	Presencial	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8294,0	 6571,0	6571	Doctor en Semiótica	Presencial	Doctorado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 101885,0	 9578,0	9578	Especialista en Interpretación	Presencial	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8278,0	 7741,0	7741	Especialista en Estudios de Asia Oriental con Orientación en Japón	Presencial	Especialidad	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8847,0	 158,0	158	Ingeniero Civil	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8709,0	 940,0	940	Profesor en Perfeccionamiento Musical	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8831,0	 7315,0	7315	Magister en Ciencias de la Ingeniería - Mención en Recursos Hídricos	Presencial	Maestría	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8275,0	 9057,0	9057	Especialista en Estudios de Asia Oriental	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8784,0	 6619,0	6619	Técnico en Gestión Universitaria	Presencial	Otros Pregrados	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8661,0	 6887,0	6887	Especialista en Medicina Transfusional	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8663,0	 6474,0	6474	Magister en Salud Sexual y Reproductiva	Presencial	Maestría	Y	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 8574,0	 5192,0	5192	Profesor en Psicología	Presencial	Grado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8424,0	 1214,0	1214	Doctor en Ciencias de la Computación	Presencial	Doctorado	Y	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 8570,0	 8111,0	8111	Especialista en Psicología del Trabajo y las Organizaciones	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8735,0	 578,0	578	Licenciado en Bibliotecología y Documentación	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8710,0	 935,0	935	Profesor de Música, orientación Educación Musical	Presencial	Grado	N	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8797,0	 8229,0	8229	Especialista en Bioquímica Clínica en Inmunología	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103989,0	 11302,0	11302	Profesor Superior de Educación en Artes Plásticas: Grabado	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8712,0	 890,0	890	Licenciado en Cine y Televisión	Presencial	Grado	N	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8876,0	 6567,0	6567	Magister en Ciencias Agropecuarias - Mención Tecnología de Semillas	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 102914,0	 4253,0	4253	Ingeniero Geólogo	Presencial	Grado	N	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 100046,0	 569,0	569	Técnico Universitario en Comunicación Social	Presencial	Técnico Instrumental	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8788,0	 386,0	386	Licenciado en Administración	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102149,0	 100144,0	100144	Bachiller orientado en Humanidades y Ciencias Sociales y Técnico Básico en Relaciones Humanas y Comunicación	Presencial	Secundario	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8290,0	 6575,0	6575	Magister en Partidos Políticos	Presencial	Maestría	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8781,0	 7247,0	7247	Doctor en Demografía	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 102485,0	 6231,0	6231	Técnico Profesional Archivero	Presencial	Título Intermedio	Y	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 8571,0	 809,0	809	Licenciado en Psicología	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7669,0	 4938,0	4938	Profesor en Lengua Italiana	Presencial	Grado	N	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8854,0	 7334,0	7334	Magister en Tecnología Arquitectónica	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8827,0	 7319,0	7319	Magister en Ciencias de la Ingeniería Mención en Estructuras y Geotecnia	Presencial	Maestría	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 101835,0	 8219,0	8219	Doctor en Neurociencias	Presencial	Doctorado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8816,0	 2022,0	2022	Licenciado en Bioquímica Clínica	Presencial	Grado	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8669,0	 6468,0	6468	Magister en Drogadependencia	Presencial	Maestría	N	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 104447,0	 11408,0	11409	Profesor en Física para la Enseñanza Secundaria	Presencial	Otros Pregrados	N	Y	Lote 1
 2741,0	Facultad de Artes	 105122,0	 2012,0	2012	Técnico Productor en Medios Audiovisuales	Presencial	Título Intermedio	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8825,0	 7321,0	7321	Especialista en Telecomunicaciones Telefónicas	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8688,0	 1666,0	1666	Especialista en Reumatología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 103294,0	 10995,0	10995	Especialista en Adolescencia con Mención en Educación	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103852,0	 11265,0	11265	Ciclo Básico de Plástica	Presencial	Ciclo Básico Común	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8794,0	 8232,0	8232	Especialista en Bioquímica Clínica en Bacteriología	Presencial	Especialidad	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 102686,0	 1315,0	1315	Magister en Derecho Internacional Público	Presencial	Maestría	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8836,0	 270,0	270	Ingeniero en Computación	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8715,0	 848,0	848	Licenciado en Escultura	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102150,0	 100143,0	100143	Bachiller orientado en Ciencias Naturales y Técnico Básico en Problemática Ambiental	Presencial	Secundario	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8296,0	 6338,0	6338	Magister en Investigación Educativa	Presencial	Maestría	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 404,0	 6226,0	6226	Técnico en Comunicación para las Organizaciones Sociales - MD	A Distancia	Técnico Instrumental	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8691,0	 1658,0	1658	Especialista en Oncología Clínica	Presencial	Especialidad	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8857,0	 7296,0	7296	Doctor en Ciencias del Diseño	Presencial	Doctorado	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 101968,0	 10385,0	10385	Profesor en Perfeccionamiento Instrumental	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8756,0	 1526,0	1526	Doctor en Filosofía	Presencial	Doctorado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8762,0	 7323,0	7323	Magister en Patrimonio Cultural Material, Administración, Conservación y Legislación	Presencial	Maestría	N	Y	Lote 1
 2723,0	Colegio Nacional de Monserrat	 102474,0	 10633,0	10633	Auxiliar Técnico en Bromatología	Presencial	Terciario No Universitario	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 105137,0	 10749,0	10749	Magister en Antropología	Presencial	Maestría	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8807,0	 3717,0	3717	Especialista en Bacteriología	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8848,0	 157,0	157	Ingeniero Aeronáutico	Presencial	Grado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 104446,0	 11410,0	11411	Profesor en Matemática para la Enseñanza Secundaria	Presencial	Otros Pregrados	N	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8761,0	 7746,0	7746	Especialista en Derecho Laboral	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8722,0	 7323,0	7323	Magister en Patrimonio Cultural Material, Administración, Conservación y Legislación	Presencial	Maestría	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 101829,0	 6231,0	6231	Técnico Profesional Archivero	Presencial	Título Intermedio	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8420,0	 2053,0	2053	Licenciado en Ciencias de la Computación	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8845,0	 173,0	173	Ingeniero Electrónico	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8809,0	 3715,0	3715	Especialista en Inmunología	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7663,0	 6896,0	6896	Magister en Traductología	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7673,0	 4929,0	4929	Licenciado en Lengua y Literatura Italianas	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8799,0	 8227,0	8227	Especialista en Bioquímica Clínica en Toxicología y Bioquímica Legal	Presencial	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8293,0	 6572,0	6572	Magister en Gestión para la Integración Regional	Presencial	Maestría	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8770,0	 1305,0	1305	Especialista en Derecho Tributario	Presencial	Especialidad	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8764,0	 3732,0	3732	Especialista en Derecho de los Negocios	Presencial	Especialidad	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8859,0	 7246,0	7246	Magister en Gestión y Desarrollo Habitacional	Presencial	Maestría	Y	Y	Lote 1
 176,0	Escuela de Nutrición	 8657,0	 979,0	979	Licenciado en Nutrición	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8699,0	 1641,0	1641	Especialista en Gastroenterología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8747,0	 3706,0	3706	Doctor en Artes	Presencial	Doctorado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 104109,0	 11352,0	11352	Magister en Lengua y Cultura Italianas en Perspectiva Intercultural	Presencial	Maestría	N	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8839,0	 213,0	213	Ingeniero Químico Industrial	Presencial	Grado	Y	Y	Lote 1
 7012,0	Rectorado	 102671,0	 10768,0	10768	Magíster en Formulación, Evaluación y Administración de Proyectos de Inversión	Presencial	Maestría	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8680,0	 4125,0	4125	Especialista en Clínica Pediátrica	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8718,0	 794,0	794	Licenciado en Historia	Presencial	Grado	Y	Y	Lote 1
 177,0	Escuela de Tecnologí­a Médica	 100542,0	 995,0	995	Técnico en Radiología y Terapia Radiante	Presencial	Técnico Instrumental	N	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8285,0	 7298,0	7298	Doctor en Estudios Sociales Agrarios	Presencial	Doctorado	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8868,0	 9058,0	9058	Magister en Reproducción Bovina	Presencial	Maestría	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8775,0	 1280,0	1280	Doctor en Derecho y Ciencias Sociales	Presencial	Doctorado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 103850,0	 10168,0	10168	Especialista en Gestión de la Innovación y Vinculación Tecnológica	Presencial	Especialidad	N	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8276,0	 7743,0	7743	Especialista en Estudios de Asia Oriental con Orientación en Corea	Presencial	Especialidad	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8713,0	 850,0	850	Licenciado en Pintura	Presencial	Grado	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 104456,0	 11441,0	11441	Magister en Ciencias Agropecuarias con Mención en Producción Animal	Presencial	Maestría	N	Y	Lote 1
 2146,0	Facultad de Lenguas	 101757,0	 10049,0	10049	Profesor de Inglés de Enseñaza Secundaria	Presencial	Grado	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8681,0	 3710,0	3710	Especialista en Ortopedia y Traumatología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8751,0	 2023,0	2023	Licenciado en Composición Musical	Presencial	Grado	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8418,0	 264,0	264	Analista en Computación	Presencial	Título Intermedio	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103798,0	 2023,0	2023	Licenciado en Composición Musical	Presencial	Grado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8772,0	 1298,0	1298	Especialista en Derecho Procesal	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8782,0	 7197,0	7197	Técnico en Economía y Administración de Pequeñas y Medianas Empresas	Presencial	Otros Pregrados	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 102379,0	 8217,0	8217	Especialista en Esterilización	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7675,0	 4927,0	4927	Licenciado en Lengua y Literatura Castellanas	Presencial	Grado	Y	Y	Lote 1
 1819,0	Instituto de Investigación y Formación en la Administración Pública	 101834,0	 2390,0	2390	Magister en Administración Pública	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 102770,0	 10225,0	10225	Traductor Público Nacional de Italiano	Presencial	Grado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8791,0	 1405,0	1405	Especialista en Sindicatura Concursal	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8852,0	 1083,0	1083	Magister en Manejo de Vida Silvestre	Presencial	Maestría	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8665,0	 6472,0	6472	Especialista en Cirugía de Tórax	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 104108,0	 11355,0	11355	Doctor en Ciencias del Lenguaje, Mención en Lingüística Aplicada	Presencial	Doctorado	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 406,0	 6222,0	6222	Técnico en Relaciones Públicas - MD	A Distancia	Técnico Instrumental	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7660,0	 724,0	724	Traductor Público Nacional en Alemán	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8687,0	 1668,0	1668	Especialista en Terapia Intensiva	Presencial	Especialidad	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8866,0	 1136,0	1136	Magister en Desarrollo Urbano	Presencial	Maestría	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8849,0	 146,0	146	Ingeniero Agrimensor	Presencial	Grado	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8858,0	 7287,0	7287	Magister en Conservación y Rehabilitación del Patrimonio Arquitectónico	Presencial	Maestría	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8705,0	 1623,0	1623	Especialista en Cardiología	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 103851,0	 11261,0	11261	Profesor de Lengua y Literatura Italiana para la Enseñanza Superior	Presencial	Grado	N	Y	Lote 1
 2146,0	Facultad de Lenguas	 102768,0	 10222,0	10222	Traductor Público Nacional de Alemán	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8679,0	 5869,0	5869	Magister en Bioética	Presencial	Maestría	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8413,0	 7739,0	7739	Especialista en Servicios y Sistemas Distribuidos	Presencial	Especialidad	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 104455,0	 11444,0	11444	Magister en Ciencias Agropecuarias con Mención en Ingeniería y Mecanización Rural	Presencial	Maestría	N	Y	Lote 1
 181,0	Facultad de Odontologí­a	 8335,0	 1749,0	1749	Doctor en Odontología	Presencial	Doctorado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8686,0	 1669,0	1669	Especialista en Tocoginecología	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8828,0	 7318,0	7318	Magister en Ciencias de la Ingeniería Mención Aeroespacial	Presencial	Maestría	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8723,0	 732,0	732	Profesor en Ciencias de la Educación	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8704,0	 1627,0	1627	Especialista en Cirugía Plástica	Presencial	Especialidad	Y	Y	Lote 1
 170,0	Escuela de Trabajo Social	 8759,0	 7290,0	7290	Magister en Trabajo Social con Mención en Intervención Social	Presencial	Maestría	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105136,0	 11750,0	11750	Profesor en Perfeccionamiento Instrumental (Piano, Violín, Viola o Violoncello)	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 103927,0	 11277,0	11277	Profesor de Italiano de Enseñanza Secundaria	Presencial	Grado	N	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8292,0	 6573,0	6573	Magister en Comunicación y Cultura Contemporánea	Presencial	Maestría	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7655,0	 7728,0	7728	Magister en Culturas y Literaturas Comparadas	Presencial	Maestría	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 102378,0	 959,0	959	Médico	Presencial	Grado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8763,0	 7312,0	7312	Magister en Derecho y Argumentación	Presencial	Maestría	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 104459,0	 11445,0	11445	Magister en Ciencias Agropecuarias con Mención en Recursos Naturales	Presencial	Maestría	N	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8872,0	 7298,0	7298	Doctor en Estudios Sociales Agrarios	Presencial	Doctorado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 101097,0	 10221,0	10221	Profesor de Castellano de Enseñanza Secundaria	Presencial	Grado	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8719,0	 7326,0	7326	Especialista en Pedagogía de la Formación	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105110,0	 6268,0	6268	CBC - Licenciado en Teatro	Presencial	Ciclo Básico Común	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8664,0	 6473,0	6473	Especialista en Enfermería Familiar y Comunitaria	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8798,0	 8228,0	8228	Especialista en Bioquímica Clínica en Parasitología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8736,0	 572,0	572	Archivero	Presencial	Título Intermedio	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8844,0	 190,0	190	Ingeniero Mecánico	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8806,0	 3718,0	3718	Especialista en Bromatología	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8811,0	 37,0	37	Licenciado en Química	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8812,0	 337,0	337	Farmacéutico	Presencial	Grado	Y	Y	Lote 1
 1786,0	Facultad de Psicologí­a	 8575,0	 1591,0	1591	Doctor en Psicología	Presencial	Doctorado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8678,0	 6448,0	6448	Doctor en Ciencias de la Salud	Presencial	Doctorado	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8281,0	 7332,0	7332	Especialista en Diseño de Encuestas y Análisis de Datos para la Planificación Social	Presencial	Especialidad	N	Y	Lote 1
 2741,0	Facultad de Artes	 105131,0	 4923,0	4923	CBC - Profesor Superior de Artes Plásticas	Presencial	Ciclo Básico Común	Y	Y	Lote 1
 178,0	Escuela de Enfermerí­a	 8653,0	 6473,0	6473	Especialista en Enfermería Familiar y Comunitaria	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103801,0	 850,0	850	Licenciado en Pintura	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8737,0	 517,0	517	Licenciado en Antropología	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8795,0	 8231,0	8231	Especialista en Bioquímica Clínica en Bromatología	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 105074,0	 4308,0	4308	Licenciado en Contabilidad	Presencial	Grado	N	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8684,0	 1783,0	1783	Magister en Salud Pública	Presencial	Maestría	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8752,0	 2012,0	2012	Técnico Productor en Medios Audiovisuales	Presencial	Título Intermedio	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8869,0	 9056,0	9056	Especialista en Alimentación de Bovinos	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8846,0	 167,0	167	Ingeniero Electricista-Electrónico	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8677,0	 6449,0	6449	Magister en Gerontología	Presencial	Maestría	Y	Y	Lote 1
 178,0	Escuela de Enfermerí­a	 8650,0	 993,0	993	Instrumentador Quirúrgico	Presencial	Técnico Instrumental	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8695,0	 1648,0	1648	Especialista en Medicina del Trabajo	Presencial	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8282,0	 7331,0	7331	Especialista en Gestión del Turismo Sustentable	Presencial	Especialidad	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8877,0	 3810,0	3810	Magister en Gestión Ambiental Agropecuaria	Presencial	Maestría	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8879,0	 1239,0	1239	Magister en Estadística Aplicada	Presencial	Maestría	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105111,0	 2023,0	2023	Licenciado en Composición Musical	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8660,0	 6888,0	6888	Especialista en Diabetología	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8851,0	 1242,0	1242	Doctor en Ciencias Geológicas	Presencial	Doctorado	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8856,0	 7300,0	7300	Especialista en Enseñanza Universitaria de la Arquitectura y el Diseño	Presencial	Especialidad	Y	Y	Lote 1
 170,0	Escuela de Trabajo Social	 8760,0	 524,0	524	Licenciado en Trabajo Social	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8666,0	 6471,0	6471	Especialista en Radioterapia Oncológica	Presencial	Especialidad	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8768,0	 1488,0	1488	Magister en Sociología	Presencial	Maestría	Y	Y	Lote 1
 181,0	Facultad de Odontologí­a	 8334,0	 1752,0	1752	Especialista en Endodoncia	Presencial	Especialidad	Y	Y	Lote 1
 1793,0	Facultad de Matemáticas, Astronomí­a y Fí­sica	 8422,0	 1249,0	1249	Doctor en Astronomía	Presencial	Doctorado	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 401,0	 9536,0	9536	Profesor Universitario en Comunicación Social - Ciclo de Profesorado	Presencial	Ciclo de Profesorado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8702,0	 1632,0	1632	Especialista en Clínica Quirúrgica	Presencial	Especialidad	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8826,0	 7320,0	7320	Magister en Ciencias de la Ingeniería Mención en Transporte	Presencial	Maestría	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8863,0	 135,0	135	Diseñador Industrial	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8731,0	 639,0	639	Licenciado en Filosofía	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8802,0	 7768,0	7768	Especialista en Farmacia Hospitalaria	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8780,0	 7322,0	7322	Doctor en Ciencias Económicas Mención en Economía	Presencial	Doctorado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103800,0	 849,0	849	Licenciado en Grabado	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8672,0	 6458,0	6458	Especialista en Clínica Dermatológica	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8700,0	 1640,0	1640	Especialista en Flebología y Linfología	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8685,0	 1670,0	1670	Especialista en Urología	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8693,0	 1651,0	1651	Especialista en Nefrología	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 103931,0	 11279,0	11279	Doctor en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	Presencial	Doctorado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7679,0	 3875,0	3875	Profesor de Portugués	Presencial	Grado	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102937,0	 100333,0	100333	Bachiller Perito Mercantil con Orientación en Ciencias Informáticas	Presencial	Secundario	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8716,0	 8113,0	8113	Especialista en Antropología Social	Presencial	Especialidad	Y	Y	Lote 1
 2741,0	Facultad de Artes	 104320,0	 3706,0	3706	Doctor en Artes	Presencial	Doctorado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7654,0	 9038,0	9038	Magister en Lengua y Culturas Italianas en Perspectiva Intercultural	Presencial	Maestría	N	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8805,0	 3719,0	3719	Especialista en Toxicología y Bioquímica Legal	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8726,0	 7189,0	7189	Corrector Literario	Presencial	Otros Pregrados	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 103932,0	 11280,0	11280	Doctor en Ciencias Económicas con Mención en Economía	Presencial	Doctorado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105116,0	 11302,0	11302	Profesor Superior de Educación en Artes Plásticas: Grabado	Presencial	Grado	Y	Y	Lote 1
 165,0	Facultad de Ciencias Exactas, Fí­sicas y Naturales	 8829,0	 7317,0	7317	Magister en Ciencias de la Ingeniería Mención Telecomunicaciones	Presencial	Maestría	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103731,0	 5329,0	5329	Licenciado en Dirección Coral	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103991,0	 11266,0	11266	Licenciado en Perfeccionamiento Instrumental (Piano, Violín, Viola y Violoncello)	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7665,0	 6582,0	6582	Magister en Inglés con Orientación en Lingüística Aplicada	Presencial	Maestría	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8753,0	 1585,0	1585	Doctor en Historia	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8734,0	 5865,0	5865	Especialista en Enseñanza de las Ciencias Sociales	Presencial	Especialidad	Y	Y	Lote 1
 163,0	Facultad de Ciencias Agropecuarias	 8873,0	 7240,0	7240	Especialista en Reproducción Bovina	Presencial	Especialidad	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 101743,0	 10134,0	10134	Técnico Superior en Administración Cooperativa y Mutual	Presencial	Otros Pregrados	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 103200,0	 10750,0	10750	Profesor en Letras Modernas	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 105120,0	 10384,0	10384	Profesor en Composición Musical	Presencial	Grado	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8800,0	 8226,0	8226	Especialista en Bioquímica Clínica en Virología	Presencial	Especialidad	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8814,0	 3124,0	3124	Magister en Ciencia y Tecnología de los Alimentos	Presencial	Maestría	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8755,0	 1536,0	1536	Doctor en Letras	Presencial	Doctorado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8729,0	 651,0	651	Licenciado en Letras Clásicas	Presencial	Grado	Y	Y	Lote 1
 181,0	Facultad de Odontologí­a	 8332,0	 964,0	964	Odontólogo	Presencial	Grado	Y	Y	Lote 1
 164,0	Facultad de Arquitectura, Urbanismo y Diseño Industrial	 8861,0	 2595,0	2595	Magister en Gestión del Desarrollo Urbano Regional	Presencial	Maestría	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8810,0	 3714,0	3714	Especialista en Hematología	Presencial	Especialidad	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 103159,0	 10050,0	10050	Profesor de Lengua Alemana	Presencial	Grado	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8785,0	 6295,0	6295	Especialista en Contabilidad Superior y Auditoría	Presencial	Especialidad	Y	Y	Lote 1
 897,0	Escuela de Ciencias de Información	 100583,0	 569,0	569	Técnico Universitario en Comunicación Social	Presencial	Técnico Instrumental	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103986,0	 890,0	890	Licenciado en Cine y Televisión	Presencial	Grado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 103928,0	 11281,0	11281	Especialista en Derecho Procesal con Orientación en Derecho Procesal Penal	Presencial	Especialidad	N	Y	Lote 1
 2146,0	Facultad de Lenguas	 7662,0	 6897,0	6897	Magister en Enseñanza de Español como Lengua Extranjera	Presencial	Maestría	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8766,0	 360,0	360	Notario	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103806,0	 10385,0	10385	Profesor en Perfeccionamiento Instrumental	Presencial	Grado	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8774,0	 1286,0	1286	Especialista en Derecho de Familia	Presencial	Especialidad	Y	Y	Lote 1
 168,0	Facultad de Ciencias Económicas	 8787,0	 450,0	450	Contador Público	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 7678,0	 4623,0	4623	Profesor en Lengua y Literatura Castellanas	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8692,0	 1654,0	1654	Especialista en Neurología	Presencial	Especialidad	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8698,0	 1642,0	1642	Especialista en Geriatría	Presencial	Especialidad	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 102504,0	 7231,0	7231	Analista de Sistemas Informáticos	Presencial	Otros Pregrados	N	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8283,0	 7301,0	7301	Especialista en Investigación de la Comunicación	Presencial	Especialidad	Y	Y	Lote 1
 169,0	Facultad de Derecho y Ciencias Sociales	 8767,0	 349,0	349	Abogado	Presencial	Grado	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8745,0	 3734,0	3734	Magister en Literaturas Latinoamericanas	Presencial	Maestría	Y	Y	Lote 1
 2724,0	Escuela Superior de Comercio Manuel Belgrano	 101746,0	 10136,0	10136	Técnico Superior en Recursos Humanos	Presencial	Otros Pregrados	N	Y	Lote 1
 2146,0	Facultad de Lenguas	 7677,0	 4886,0	4886	Licenciado en Lengua y Literatura Inglesas	Presencial	Grado	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103988,0	 11301,0	11301	Profesor Superior de Educación en Artes Plásticas: Escultura	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8658,0	 960,0	960	Médico Cirujano	Presencial	Grado	N	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8804,0	 3720,0	3720	Especialista en Virología	Presencial	Especialidad	Y	Y	Lote 1
 1818,0	Centro de Estudios Avanzados	 8279,0	 7730,0	7730	Magister en Procesos Educativos Mediados por Tecnologías - MD	A Distancia	Maestría	Y	Y	Lote 1
 167,0	Facultad de Ciencias Quí­micas	 8801,0	 8218,0	8218	Especialista en Bioquímica Clínica en Hematología	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 101884,0	 9621,0	9621	Doctor en Ciencias Antropológicas	Presencial	Doctorado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 101096,0	 6886,0	6886	Especialista en Citopatología	Presencial	Especialidad	N	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 102619,0	 10749,0	10749	Magister en Antropología	Presencial	Maestría	Y	Y	Lote 1
 2741,0	Facultad de Artes	 103628,0	 11198,0	11198	Profesor Superior de Educación en Artes Plásticas: Pintura, Escultura, Grabado	Presencial	Grado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8701,0	 1637,0	1637	Especialista en Endocrinología	Presencial	Especialidad	Y	Y	Lote 1
 1819,0	Instituto de Investigación y Formación en la Administración Pública	 102488,0	 10650,0	10650	Doctor en Administración y Política Pública	Presencial	Doctorado	Y	Y	Lote 1
 175,0	Facultad de Ciencias Médicas	 8696,0	 1647,0	1647	Especialista en Medicina del Deporte	Presencial	Especialidad	Y	Y	Lote 1
 172,0	Facultad de Filosofí­a y Humanidades	 8744,0	 3877,0	3877	Licenciado en Archivología	Presencial	Grado	Y	Y	Lote 1
 2146,0	Facultad de Lenguas	 102600,0	 10051,0	10051	Profesor de Lengua Italiana	Presencial	Grado	Y	Y	Lote 1
 181,0	Facultad de Odontologí­a	 8333,0	 6565,0	6565	Especialista en Prótesis Fija, Removible e Implantología	Presencial	Especialidad	Y	Y	Lote 1
\.


--
-- TOC entry 2112 (class 0 OID 1260042)
-- Dependencies: 171 2123
-- Data for Name: mig_ofertas_guarani; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY mig_ofertas_guarani (unidad_academica, nombre, valor, instituc_araucano, titulo, nombre_titulo, nombre_titulo_femenino, nivel, tipo_de_titulo, tipo_diploma, tipo_diploma_codigo, nro_resolucion, fecha_resolucion, nro_res_minist, fecha_res_minist, titulo_araucano, carrera, nombre_carrera, lote) FROM stdin;
\.


--
-- TOC entry 2113 (class 0 OID 1260048)
-- Dependencies: 172 2123
-- Data for Name: mig_ofertas_guarani_2014; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY mig_ofertas_guarani_2014 (codigo_ua, nombre_ua, ua, instituc_araucano, titulo, titulo_nombre, titulo_nombre_femenino, nivel, tipo_de_titulo, tipo_diploma, tipo_diploma_codigo, nro_resolucion, fecha_resolucion, nro_res_minist, fecha_res_minist, titulo_araucano, carrera, nombre_carrera, lote) FROM stdin;
 19,0	Facultad de Ciencias Agropecuarias	Facultad de Ciencias Agropecuarias	 163,0	 701,0	Ingeniero Agrónomo	Ingeniera Agrónoma	GRADO	G	Grado	3	\N	1966-03-21	\N	\N	92	 701,0	Ingeniería Agronómica	Lote 1
 19,0	Facultad de Ciencias Agropecuarias	Facultad de Ciencias Agropecuarias	 163,0	 712,0	Técnico Universitario en Jardinería y Floricultura	Técnica Universitaria en Jardinería y Floricultura	GRADO	P	Pregrado	1	\N	\N	1982/2010	12/23/10	11229	 712,0	Tecnicatura Universitaria en Jardinería y Floricultura	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	702	Especialista en Tecnologías Multimedia para Desarrollos Educativos	Especialista en Tecnologías Multimedia para Desarrollos Educativos	GRADO	E	Posgrado	5	135/07	2006-03-15	-	\N	\N	70209	Especialización en Tecnologías Multimedia para Desarrollos Educativos - Semi Presencial	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	705	Especialista en Reproducción Bovina	Especialista en Reproducción Bovina	GRADO	E	Posgrado	5	276/02	2002-08-06	610/03	12/22/03	\N	70502	Especialización en Reproducción Bovina	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	705B	Magister en Reproducción Bovina	Magister en Reproducción Bovina	GRADO	M	Posgrado	5	61/2008	2008-03-18	907/2009	06/11/09	9058	705B	Maestría en Reproducción Bovina	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	706	Magister en Ciencias Agropecuarias	Magister en Ciencias Agropecuarias	GRADO	M	Posgrado	5	99/96	1996-03-19	824/99	12/06/99	\N	70696	Maestría en Ciencias Agropecuarias	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	708	Magister en Ciencias Agropecuarias con Mención en Tecnología de Semillas	Magister en Ciencias Agropecuarias con Mención en Tecnología de Semillas	GRADO	M	Posgrado	5	ord 4/87	1983-02-23	566/99	10/14/99	\N	70888	Maestría en Ciencias Agropecuarias con Mención en Tecnología de Semillas	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	709	Doctor en Ciencias Agropecuarias	Doctora en Ciencias Agropecuarias	GRADO	D	Posgrado	5	98/96	1996-03-19	372/99	08/09/99	\N	70996	Doctorado en Ciencias Agropecuarias	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	710	Especialista en Alimentación de Bovinos	Especialista en Alimentación de Bovinos	GRADO	E	Posgrado	5	172/09	2009-04-07	\N	\N	\N	70997	Especialización en Alimentación de Bovinos	Lote 1
P19	Escuela de Posgrado FCA	Facultad de Ciencias Agropecuarias	163	8112	Especialista en Producción de Cultivos Extensivos	Especialista en Producción de Cultivos Extensivos	GRADO	E	Posgrado	5	\N	\N	\N	\N	\N	70998	Especialización en Producción de Cultivos Extensivos	Lote 1
13	Facultad de Arquitectura, Urbanismo y Diseño	Facultad de Arquitectura, Urbanismo y Diseño	164	011	Arquitecto	Arquitecta	GRADO	G	Grado	3	19/75	1975-11-27	53/75	12/30/95	118	011	Arquitectura	Lote 1
13	Facultad de Arquitectura, Urbanismo y Diseño	Facultad de Arquitectura, Urbanismo y Diseño	164	012	Diseñador Industrial	Diseñadora Industrial	GRADO	G	Grado	3	233/89	1989-11-07	1127/95	11/27/95	135	012	Diseño Industrial	Lote 1
13	Facultad de Arquitectura, Urbanismo y Diseño	Facultad de Arquitectura, Urbanismo y Diseño	164	011	Arquitecto	Arquitecta	GRADO	G	Grado	3	19/75	1975-11-27	53/75	12/30/95	118	REV	Reválida Arquitectura	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	02	Especialista en Planificación y Diseño del Paisaje	Especialista en Planificación y Diseño del Paisaje	GRADO	E	Posgrado	5	209/03	2003-06-03	1542/04	11/25/04	6546	016	Especialización en Planificación y Diseño del Paisaje	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	03	Magister en Gestión Ambiental del Desarrollo Urbano	Magister en Gestión Ambiental del Desarrollo Urbano	GRADO	M	Posgrado	5	244/96	1996-06-04	1346/98	07/13/98	2377	015	Maestría en Gestión Ambiental del Desarrollo Urbano	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	04	Especialista en Enseñanza Universitaria de la Arquitectura y el Diseño	Especialista en Enseñanza Universitaria de la Arquitectura y el Diseño	GRADO	E	Posgrado	5	350/05	2005-09-06	\N	\N	7300	021	Especialización en  Enseñanza Universitaria de la Arquitectura y el Diseño	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	05	Magister en Diseño Arquitectónico y Urbano	Magister en Diseño Arquitectónico y Urbano	GRADO	M	Posgrado	5	36/90	1990-03-20	\N	\N	1137	014	Maestría en Diseño Arquitectónico y Urbano	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	06	Magister en Gestión y Desarrollo Habitacional	Magister en Gestión y Desarrollo Habitacional	GRADO	M	Posgrado	5	345/97	1997-11-04	1237/99	\N	7246	017	Maestría en Gestión y Desarrollo Habitacional	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	07	Magister en Conservación y Rehabilitación del Patrimonio Arquitectónico	Magister en Conservación y Rehabilitación del Patrimonio Arquitectónico	GRADO	M	Posgrado	5	347/97	1997-11-04	632/05	09/06/05	7287	022	Maestría en Conservación y Rehabilitación del Patrimonio Arquitectónico	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	08	Especialista en Tecnología Arquitectónica	Especialista en Tecnología Arquitectónica	GRADO	E	Posgrado	5	18/05	2005-03-01	\N	\N	7333	019	Especialización en Tecnología Arquitectónica	Lote 1
P13	Facultad de Arquitectura-Escuela de Graduados	Facultad de Arquitectura, Urbanismo y Diseño	164	10	Magister en Desarrollo Urbano	Magister en Desarrollo Urbano	GRADO	M	Posgrado	5	30/90	1990-03-20	\N	\N	1136	013	Maestría en Desarrollo Urbano	Lote 1
05	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	169	051	Abogado	Abogada	GRADO	G	Grado	3	\N	1999-08-02	207/99	\N	349	051	Abogacía	Lote 1
05	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	169	052	Procurador	Procuradora	INTERMEDIO	G	Grado	3	\N	1961-03-04	4/61	01/01/61	361	051	Abogacía	Lote 1
05	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	169	061	Notario	Notaria	GRADO	G	Grado	3	\N	1999-12-02	343/99	12/02/99	360	061	Notariado	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	053	Especialista en Derecho Procesal	Especialista en Derecho Procesal	GRADO	E	Posgrado	5	495/96	1996-12-17	1906/97	10/08/97	1298	053	Especialización en Derecho Procesal	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	056	Especialista en Derecho Público	Especialista en Derecho Público	GRADO	E	Posgrado	5	130/93 HCS	1993-05-04	1234	12/06/95	1302	056	Especialización en Derecho Público	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	059	Doctor en Derecho y Ciencias Sociales	Doctora en Derecho y Ciencias Sociales	GRADO	D	Posgrado	5	HCD 4/99	1999-06-17	491/99 CONEAU	09/13/99	1280	059	Doctorado en Derecho y Ciencias Sociales	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	05A	Especialista en Derecho Penal	Especialista en Derecho Penal	GRADO	E	Posgrado	5	546/05	2005-11-15	993/06	08/04/06	1295	05A	Especialización en Derecho Penal	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	05B	Especialista en Derecho de los Negocios	Especialista en Derecho de los Negocios	GRADO	E	Posgrado	5	189/2000	2000-05-02	88/2001	02/19/01	3732	05B	Especialización en Derecho de los Negocios	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	05C	Especialista en Derecho de Familia	Especialista en Derecho de Familia	GRADO	E	Posgrado	5	144/06	2006-04-04	987/07	06/06/07	1286	05C	Especialización en Derecho de Familia	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	05D	Especialista en Derecho Tributario	Especialista en Derecho Tributario	GRADO	E	Posgrado	5	HCS 146/06	2006-04-04	496/08	05/09/08	1305	05D	Especialización en Derecho Tributario	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	05E	Magister en Derecho y Argumentación	Magister en Derecho y Argumentación	GRADO	M	Posgrado	5	338/05	2005-09-06	222/08	03/11/08	7312	05E	Maestria en Derecho y Argumentación	Lote 1
P05	Facultad de Derecho y Cs. Ss. - Secretaría de Posgrado	Facultad de Derecho y Ciencias Sociales	169	05F	Especialista en Derecho Laboral	Especialista en Derecho Laboral	GRADO	E	Posgrado	5	059/07 SPG	2007-04-09	\N	\N	7746	05F	Especialización en Derecho Laboral	Lote 1
64	Inst. de Investigación y Formación en Administración Pública	Inst. de Investigación y Formación en Administración Pública	1819	940	Especialista en Administración Pública Provincial y Municipal	Especialista en Administración Pública Provincial y Municipal	GRADO	E	Posgrado	5	39	2004-10-14	232	03/12/08	10634	940	Especialización en Administración Pública Provincial y Municipal	Lote 1
64	Inst. de Investigación y Formación en Administración Pública	Inst. de Investigación y Formación en Administración Pública	1819	941	Magister en Administración Pública	Magister en Administración Pública	GRADO	M	Posgrado	5	368/1996	1996-09-17	415/09	08/25/09	2390	941	Maestría en Administración Pública	Lote 1
64	Inst. de Investigación y Formación en Administración Pública	Inst. de Investigación y Formación en Administración Pública	1819	942	Doctor en Administración y Política Pública	Doctora en Administración y Política Pública	GRADO	D	Posgrado	5	01/2007	2007-02-23	1498	10/01/10	10650	942	Doctorado en Administración y Política Pública	Lote 1
14	Facultad de Odontología	Facultad de Odontología	181	501	Odontólogo	Odontóloga	GRADO	G	Grado	3	\N	1956-11-05	\N	\N	964	501	Odontología	Lote 1
P14	Escuela de Posgrado - Facultad de Odontologia	Facultad de Odontología	181	505	Especialista en Cirugía Buco-Máxilo-Facial	Especialista en Cirugía Buco-Máxilo-Facial	GRADO	E	Posgrado	5	\N	\N	\N	\N	\N	505	Especialización en Cirugía Buco-Máxilo-Facial	Lote 1
P14	Escuela de Posgrado - Facultad de Odontologia	Facultad de Odontología	181	506	Especialista en Ortodoncia y Ortopedia Dento-Máxilo-Facial	Especialista en Ortodoncia y Ortopedia Dento-Máxilo-Facial	GRADO	E	Posgrado	5	\N	\N	\N	\N	\N	506	Especialización en Ortodoncia y Ortopedia Dento-Máxilo-Facial	Lote 1
P14	Escuela de Posgrado - Facultad de Odontologia	Facultad de Odontología	181	507	Especialista en Endondoncia	Especialista en Endondoncia	GRADO	E	Posgrado	5	293/08	2008-07-25	095/00	07/25/08	1752	507	Especialización en Endodoncia	Lote 1
P14	Escuela de Posgrado - Facultad de Odontologia	Facultad de Odontología	181	508	Especialista en Prótesis Fija, Removible e Implantología	Especialista en Prótesis Fija, Removible e Implantología	GRADO	E	Posgrado	5	297/08	2008-07-25	095/00	07/25/08	6565	508	Especialización en Prótesis Fija, Removible e Implantología	Lote 1
P14	Escuela de Posgrado - Facultad de Odontologia	Facultad de Odontología	181	D509	Doctor en Odontología	Doctora en Odontología	GRADO	D	Posgrado	5	3/80	1980-02-11	\N	\N	1749	509	Doctorado en Odontología	Lote 1
75	Facultad de Psicología	Facultad de Psicología	1786	461	Licenciado en Psicología	Licenciada en Psicología	GRADO	G	Grado	3	\N	\N	\N	\N	809	461	Licenciatura en Psicología	Lote 1
75	Facultad de Psicología	Facultad de Psicología	1786	468	Profesor en Psicología	Profesora en Psicología	GRADO	G	Grado	3	\N	\N	\N	\N	5192	468	Profesorado en Psicología	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	462	Magister en Intervención e Investigación Psicosocial	Magister en Intervención e Investigación Psicosocial	GRADO	M	Posgrado	5	01/10	2010-02-24	\N	\N	\N	462	Maestría en Intervención e Investigación Psicosocial	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	463	Especialista en Psicología Clínica	Especialista en Psicología Clínica	GRADO	E	Posgrado	5	428	2010-10-28	\N	\N	1594	463	Especialización en Psicología Clínica	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	464	Especialista en Psicología Educacional	Especialista en Psicología Educacional	GRADO	E	Posgrado	5	08	2010-02-24	\N	\N	\N	464	Especialización en Psicología Educacional	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	465	Especialista en Psicología Sanitaria	Especialista en Psicología Sanitaria	GRADO	E	Posgrado	5	02	2010-02-24	\N	\N	\N	465	Especialización en Psicología Sanitaria	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	466	Especialista en Psicología del Trabajo y de las Organizaciones	Especialista en Psicología del Trabajo y de las Organizaciones	GRADO	E	Posgrado	5	HCS 188/07	2007-04-17	\N	\N	\N	466	Especialización en Psicología del Trabajo y de las Organizaciones	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	469	Doctor en Psicología	Doctora en Psicología	GRADO	D	Posgrado	5	276/00	\N	\N	\N	1591	469	Doctorado en Psicología	Lote 1
P75	Facultad de Psicologia	Facultad de Psicología	1786	469A	Magister en Teoría Psicoanalítica Lacaniana	Magister en Teoría Psicoanalítica Lacaniana	GRADO	M	Posgrado	5	1	2013-02-04	\N	\N	\N	469A	Maestría en Teoría Psicoanalítica Lacaniana	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 5304,0	Ciclo Básico Común	Ciclo Básico Común	GRADO	P	Pregrado	1	\N	\N	\N	\N	4924	 5304,0	Ciclo Básico Común	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 5304,0	Ciclo Básico Común	Ciclo Básico Común	GRADO	P	Pregrado	1	\N	\N	\N	\N	4924	CBCPM	Ciclo Básico Común Modificado	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 5304,0	Ciclo Básico Común	Ciclo Básico Común	GRADO	P	Pregrado	1	\N	\N	\N	\N	4924	CN	Ciclo de Nivelacion	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 5304,0	Ciclo Básico Común	Ciclo Básico Común	GRADO	P	Pregrado	1	\N	\N	\N	\N	4924	CNPM	Ciclo Nivelación Modificado	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 531,0	Licenciado en Química	Licenciada en Química	GRADO	G	Grado	3	 191,0	1994-03-05	 364,0	02/27/95	37	 531,0	Licenciatura en Química	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 541,0	Licenciatura en Química Farmacéutica / Farmacéutico	Licenciada en Química Farmacéutica / Farmacéutica	GRADO	G	Grado	3	\N	1969-12-26	RR 1079	12/26/69	2021	 54173,0	Licenciatura en Química Farmacéutica	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	541/1	Farmacéutico	Farmacéutica	GRADO	G	Grado	3	 191,0	1994-03-05	 364,0	02/27/95	337	 541,0	Farmacia	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 5452,0	Farmacéutico	Farmacéutica	GRADO	G	Grado	3	 10,0	2007-02-16	\N	\N	337	 5452,0	Farmacia	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 5512,0	Bioquímico	Bioquímica	GRADO	G	Grado	3	 2,0	2007-02-16	 1643,0	09/20/12	334	 5512,0	Bioquímica	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	 555,0	Licenciado en Bioquímica Clínica / Bioquímico Clínico	Licenciada en Bioquímica Clínica / Bioquímica Clínica	GRADO	G	Grado	3	\N	1969-12-26	 1079,0	12/26/69	2022	 55573,0	Licenciatura en Bioquímica Clínica	Lote 1
 15,0	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	 167,0	555/1	Bioquímico	Bioquímica	GRADO	G	Grado	3	 191,0	1994-03-05	 364,0	02/27/95	334	 555,0	Bioquímica	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	1058	Doctor en Ciencias Químicas	Doctora en Ciencias Químicas	GRADO	D	Posgrado	5	ORD. 1/01	2001-04-06	\N	\N	1058	539	Doctorado en Ciencias Químicas	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	1064	Magister en Ciencias Químicas	Magister en Ciencias Químicas	GRADO	M	Posgrado	5	ORD. 1/02	2002-04-05	\N	\N	\N	538	Maestría en Ciencias Químicas	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	1637	Especialista en Bioquímica Clínica en Endocrinología	Especialista en Bioquímica Clínica en Endocrinología	GRADO	E	Posgrado	5	ORD. 02/08	2008-08-08	RES 824/02	09/17/02	1637	562	Especialización en Bioquímica Clínica en  Endocrinología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	2727	Especialista en Química Clínica	Especialista en Química Clínica	GRADO	E	Posgrado	5	ORD. 9	2005-12-16	220/08	03/10/08	2727	532	Especialización en Química Clínica	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	3714	Especialista en Hematología	Especialista en Hematología	GRADO	E	Posgrado	5	ORD. 1/07	2007-10-22	\N	\N	3714	570	Especialización en Hematología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	7768	Especialista en Farmacia Hospitalaria	Especialista en Farmacia Hospitalaria	GRADO	E	Posgrado	5	ORD 1/06	2006-07-07	\N	\N	7768	571	Especialización en Farmacia Hospitalaria	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8217	Especialista en Esterilización	Especialista en Esterilización	GRADO	E	Posgrado	5	\N	2005-11-18	92	01/30/08	8217	569	Especialización en Esterilización	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8218	Especialista en Bioquímica Clínica en Hematología	Especialista en Bioquímica Clínica en Hematología	GRADO	E	Posgrado	5	\N	\N	\N	\N	8218	561	Especialización en Bioquímica Clínica en Hematología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8226	Especialista en Bioquímica Clínica en Virología	Especialista en Bioquímica Clínica en Virología	GRADO	E	Posgrado	5	ORD. 2/08	2008-08-08	824	09/17/02	8226	568	Especialización en Bioquímica Clínica en Virología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8227	Especialista en Bioquímica Clínica en Toxicología y Bioquímica Legal	Especialista en Bioquímica Clínica en Toxicología y Bioquímica Legal	GRADO	E	Posgrado	5	2/08	\N	824/02	09/17/02	8227	567	Especialización  en Bioquímica Clínica en Toxicología y Bioquímica Legal	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8228	Especialista en Bioquímica Clínica en Parasitología	Especialista en Bioquímica Clínica en Parasitología	GRADO	E	Posgrado	5	ORD. 2/08	2008-08-08	824/02	09/17/02	8228	564	Especialización en Bioquímica Clínica en Parasitología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8229	Especialista en Bioquímica Clínica en Inmunología	Especialista en Bioquímica Clínica en Inmunología	GRADO	E	Posgrado	5	ORD. 2/08	2008-08-08	824/02	09/17/02	8229	563	Especialización en Bioquímica Clínica en Inmunología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8231	Especialista en Bioquímica Clínica en Bromatología	Especialista en Bioquímica Clínica en Bromatología	GRADO	E	Posgrado	5	ORD. 2/08	2008-08-08	RES. Nº 824/02	09/17/02	8231	566	Especialización en Bioquímica Clínica en Bromatología	Lote 1
P15	Facultad de Ciencias Químicas	Facultad de Ciencias Químicas	167	8232	Especialista en Bioquímica Clínica en Bacteriología	Especialista en Bioquímica Clínica en Bacteriología	GRADO	E	Posgrado	5	\N	2008-08-08	RES. 824	09/17/02	8232	565	Especialización en Bioquímica Clínica en Bacteriología	Lote 1
P15	Posgrado de Ciencias Quimicas	DE LA FACULTAD DE CIENCIAS QUIMICAS	\N	3124	Magister en Ciencia y Tecnología de los Alimentos	Magister en Ciencia y Tecnología de los Alimentos	GRADO	M	Posgrado	5	1194/2009	2009-12-21	\N	\N	\N	581	Maestría en Ciencia y Tecnología de los Alimentos	Lote 1
P15	Posgrado de Ciencias Quimicas	DE LA FACULTAD DE CIENCIAS QUIMICAS	\N	580	Doctor en Neurociencias	Doctora en Neurociencias	GRADO	D	Posgrado	5	166/09	2009-04-07	\N	\N	8219	580	Doctorado en Neurociencias	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	213	Ingeniero Ambiental	Ingeniera Ambiental	GRADO	G	Grado	3	1005-HCD-2011	2011-11-04	\N	\N	2392	213	Ingeniería Ambiental	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	251	Geólogo	Geóloga	GRADO	G	Grado	3	1010-HCS	2012-10-16	236	08/14/95	317	251	Geología	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	B90	Biólogo	Bióloga	GRADO	G	Grado	3	144	1989-08-01	3317	12/16/94	60	261	Ciencias Biológicas	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	B90	Biólogo	Bióloga	GRADO	G	Grado	3	144	1989-08-01	3317	12/16/94	60	261P	Ciencias Biológicas (con articulacion Proarquibi)	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	COM00	Ingeniero en Computación	Ingeniera en Computación	GRADO	G	Grado	3	90-HCD-2000	2000-06-06	212	03/19/01	270	285	Ingeniería en Computación	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	CS92	Constructor	Constructora	GRADO	G	Grado	3	141	1998-04-07	2419	11/30/98	216	295	Constructor	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	G97	Geólogo	Geóloga	GRADO	G	Grado	3	287-HCS-97	1997-09-16	236	08/14/95	317	251	Geología	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	G97	Geólogo	Geóloga	GRADO	G	Grado	3	287-HCS-97	1997-09-16	236	08/14/95	317	251V	Geología Vocacional	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IA97	Ingeniero Aeronáutico	Ingeniera Aeronáutica	GRADO	G	Grado	3	524-HCD-96	1996-12-10	979	06/13/97	157	232	Ingeniería Aeronáutica	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IAG01	Ingeniero Agrimensor	Ingeniera Agrimensora	GRADO	G	Grado	3	286-HCD-2000	2000-12-12	1056	05/04/95	144	241	Ingeniería en Agrimensura	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IB03	Ingeniero Biomédico	Ingeniera Biomédica	GRADO	G	Grado	3	173-HCD-2005	2005-04-01	\N	\N	5390	223	Ingeniería Biomédica	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IC97	Ingeniero Civil	Ingeniera Civil	GRADO	G	Grado	3	15-HCD-1997	1997-02-25	391	07/23/99	158	201	Ingeniería Civil	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IE97	Ingeniero Electrónico	Ingeniera Electrónica	GRADO	G	Grado	3	453 HCD 1996	1996-11-28	3324	12/16/94	173	281	Ingeniería Electrónica	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	II98	Ingeniero Industrial	Ingeniera Industrial	GRADO	G	Grado	3	189-HCD-1998	1998-10-06	387	07/23/99	252	247	Ingeniería Industrial	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IM00	Ingeniero Mecánico	Ingeniera Mecánica	GRADO	G	Grado	3	60-HCD-1999	1999-04-20	269	04/05/00	190	212	Ingeniería Mecánica	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IME97	Ingeniero Mecánico Electricista	Ingeniera Mecánica Electricista	GRADO	G	Grado	3	526-HCD-96	1996-12-10	\N	\N	192	211	Ingeniería Mecánica Electricista	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	IQ92	Ingeniero Químico	Ingeniera Química	GRADO	G	Grado	3	477-HCD-1994	1994-11-01	1614	07/06/95	212	246	Ingeniería Química	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	PB90	Profesor en Ciencias Biológicas	Profesora en Ciencias Biológicas	GRADO	G	Grado	3	144 HCS	1989-08-01	3317	12/16/94	77	271	Profesorado en Ciencias Biológicas	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	PB90	Profesor en Ciencias Biológicas	Profesora en Ciencias Biológicas	GRADO	G	Grado	3	144 HCS	1989-08-01	3317	12/16/94	77	271BA	Profesorado en Ciencias Biológicas (con proyecto biológico aprobado)	Lote 1
10	Facultad de Ciencias Exactas Físicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	TME97	Técnico Mecánico Electricista	Técnica Mecánica Electricista	GRADO	G	Grado	3	66 HCS	2002-03-18	47	\N	2006	296	Técnico Mecánico Electricista	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	1075	Doctor en Ciencias Biológicas	Doctora en Ciencias Biológicas	GRADO	D	Posgrado	5	262-HCS-2006	2006-06-06	\N	\N	1075	269	Doctorado en Ciencias Biológicas	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	202TF	Magister en Ciencias de la Ingeniería, Mención Recursos Hídricos	Magister en Ciencias de la Ingeniería, Mención Recursos Hídricos	GRADO	M	Posgrado	5	79-HCS-1998	1998-03-17	2446	11/30/98	7315	202	Maestría en Ciencias de la Ingeniería Mención Recursos Hídricos	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	203TF	Magister en Ciencias de la Ingeniería - Mención en Administración	Magister en Ciencias de la Ingeniería - Mención en Administración	GRADO	M	Posgrado	5	\N	\N	223/00	12/07/00	7316	203	Maestría en Ciencias de la Ingeniería Mención - Administración	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	204TF	Magister en Ciencias de la Ingeniería Mención Telecomunicaciones	Magister en Ciencias de la Ingeniería Mención Telecomunicaciones	GRADO	M	Posgrado	5	298-HCS-2000	2000-07-04	333/2000	12/19/00	7317	204	Maestría en Ciencias de la Ingeniería Mención Telecomunicaciones	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	205TF	Magister en Ciencias de la Ingeniería - Mención Aeroespacial.	Magister en ciencias de la Ingeniería - Mención Aeroespacial.	GRADO	M	Posgrado	5	246-HCS-2001	2001-07-03	\N	\N	7318	205	Maestría en Ciencias de la Ingeniería - Mención Aeroespacial.	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	206TF	Magister en Ciencias de la Ingeniería - Mención Estructuras y Geotecnia	Magister en Ciencias de la Ingeniería - Mención Estructuras y Geotecnia	GRADO	M	Posgrado	5	279 - HCS / 01	2001-08-21	\N	\N	7319	206	Maestría en Ciencias de la Ingeniería - Mención en Estructuras y Geotecnia	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	207TF	Magister en Ciencias de la Ingeniería - Mención Transporte	Magister en Ciencias de la Ingeniería - Mención Transporte	GRADO	M	Posgrado	5	315 - HCS / 01	2001-09-04	NO POSEO	10/20/03	7320	207	Maestría en Ciencias de la Ingeniería - Mención Transporte	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	208TF	Ingeniero Especialista en Telecomunicaciones Telefónicas	Ingeniera Especialista en Telecomunicaciones Telefónicas	GRADO	E	Posgrado	5	\N	\N	\N	\N	7321	208	Ingeniero Especialista en Telecomunicaciones Telefónicas	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	209TF	Doctor en Ciencias de la Ingeniería	Doctora en Ciencias de la Ingeniería	GRADO	D	Posgrado	5	208/HCS/87	1987-09-01	684	11/23/03	5364	209	Doctorado en Ciencias de la Ingeniería	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	210TF	Magister en Ciencias de la Ingeniería - Mención Ambiente	Magister en Ciencias de la Ingeniería - Mención Ambiente	GRADO	M	Posgrado	5	146 - HCS / 06	2006-04-04	86	01/30/06	7490	210	Maestría en Ciencias de la Ingeniería - Mención Ambiente	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	258TF	Magister en Manejo de Vida Silvestre	Magister en Manejo de Vida Silvestre	GRADO	M	Posgrado	5	HCS 297	1991-12-11	1067	06/03/98	1083	258	Maestría en Manejo de Vida Silvestre	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	258TF	Magister en Manejo de Vida Silvestre	Magister en Manejo de Vida Silvestre	GRADO	M	Posgrado	5	HCS 297	1991-12-11	1067	06/03/98	1083	258 V	Maestría en Manejo de Vida Silvestre - Vocacional	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	259TF	Doctor en Ciencias Geológicas	Doctora en Ciencias Geológicas	GRADO	D	Posgrado	5	632/11	\N	0236/95	\N	1242	259	Doctorado en Ciencias Geológicas	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	262	Magister en Educación en Ciencias Experimentales y Tecnología	Magister en Educación en Ciencias Experimentales y Tecnología	GRADO	M	Posgrado	5	\N	2004-12-16	\N	\N	7727	262	Maestría en Educación en Ciencias Experimentales y Tecnología	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	292	Especialista en Hidráulica	Especialista en Hidráulica	GRADO	E	Posgrado	5	94/2011	\N	\N	\N	10776	292	Especialización en Hidráulica	Lote 1
10	Facultad de Cs. Exactas, Fisicas y Naturales	Facultad de Ciencias Exactas, Físicas y Naturales	165	298	Especialista en Productividad Organizacional	Especialista en Productividad Organizacional	GRADO	E	Posgrado	5	87 HCD 2009	2009-03-06	363	02/28/11	8331	298	Especialización en Productividad Organizacional	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	101	Contador Público	Contadora Pública	GRADO	G	Grado	3	\N	1979-03-21	2/79	03/21/79	450	101	Contador Público	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	111	Licenciado en Economía	Licenciada en Economía	GRADO	G	Grado	3	\N	1979-03-21	2/79	03/21/79	464	111	Licenciatura en Economía	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	120	Ciencias Económicas	Ciencias Económicas	GRADO	P	Pregrado	1	\N	\N	\N	\N	7181	120	Ciencias Económicas	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	125	Licenciado en Administración	Licenciada en Administración	GRADO	G	Grado	3	\N	1979-03-21	2/79	03/21/79	386	125	Licenciatura en Administración	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	138	Profesor de Enseñanza Media y Superior en Ciencias Económicas	Profesora de Enseñanza Media y Superior en Ciencias Económicas	GRADO	G	Grado	3	\N	1983-01-01	\N	\N	10053	138	Profesorado de Enseñanza Media y Superior en Ciencias Económicas -Ciclo de Complementación Curricular-	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	140	Técnico en Economía y Administración de Pequeñas y Medianas Empresas	Técnica en Economía y Administración de Pequeñas y Medianas Empresas	GRADO	P	Pregrado	1	PPP/PP	2004-03-01	\N	\N	7197	140	Tecnicatura en Economía y Administración de Pequeñas y Medianas Empresas	Lote 1
11	Facultad de Ciencias Económicas	Facultad de Ciencias Económicas	168	150	Técnico en Gestión Universitaria	Técnica en Gestión Universitaria	GRADO	P	Pregrado	1	\N	\N	\N	\N	9793	150	Tecnicatura en Gestión Universitaria	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	103	Especialista en Contabilidad Superior y Auditoría	Especialista en Contabilidad Superior y Auditoría	GRADO	E	Posgrado	5	\N	\N	\N	\N	6295	103	Especialidad en Contabilidad Superior y Auditoría	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	104	Magister en Comercio Internacional	Magister en Comercio Internacional	GRADO	M	Posgrado	5	\N	\N	\N	\N	1391	104	Maestría en Comercio Internacional	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	105	Especialista en Gestión de la Innovación y Vinculación Tecnológica	Especialista en Gestión de la Innovación y Vinculación Tecnológica	GRADO	E	Posgrado	5	463/2008	2008-12-15	\N	\N	10168	105	Especialidad en Gestión de la Innovación y Vinculación Tecnológica	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	106	Especialista en Gestión de Tecnologías Innovadoras	Especialista en Gestión de Tecnologías Innovadoras	GRADO	E	Posgrado	5	\N	\N	907	10/20/09	8234	106	Especialidad en Gestión de Tecnologías Innovadoras	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	109	Doctor en Ciencias Económicas	Doctora en Ciencias Económicas	GRADO	D	Posgrado	5	\N	\N	\N	\N	\N	109	Doctorado en Ciencias Económicas	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	109A	Doctor en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	Doctora en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	GRADO	D	Posgrado	5	\N	\N	\N	\N	11278	109A	Doctorado en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	109B	Doctor en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	Doctora en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	GRADO	D	Posgrado	5	\N	\N	\N	\N	11279	109B	Doctorado en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	109C	Doctor en Ciencias Económicas con Mención en Economía	Doctora en Ciencias Económicas con Mención en Economía	GRADO	D	Posgrado	5	\N	\N	\N	\N	11280	109C	Doctorado en Ciencias Económicas con Mención en Economía	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	109D	Doctor en Ciencias Económicas con Mención Ciencias Empresariales	Doctora en Ciencias Económicas con Mención Ciencias Empresariales	GRADO	D	Posgrado	5	\N	\N	\N	\N	7335	109D	Doctorado en Ciencias Económicas con Mención Ciencias Empresariales	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	132	Magister en Dirección de Negocios	Magister en Dirección de Negocios	GRADO	M	Posgrado	5	\N	1996-07-01	372	07/01/96	3713	132	Maestría en Dirección de Negocios	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	MGSOC	Magíster en Sociología	Magíster en Sociología	GRADO	M	Posgrado	5	82	2003-03-18	934	08/11/05	1488	908	Maestría en Sociología	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	135	Especialista en Sindicatura Concursal	Especialista en Sindicatura Concursal	GRADO	E	Posgrado	5	\N	1991-04-08	349/91	04/08/91	1405	135	Especialidad en Sindicatura Concursal	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	137	Especialista en Tributación	Especialista en Tributación	GRADO	E	Posgrado	5	\N	1994-08-08	366	08/08/94	1407	137	Especializacion en Tributación	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	139	Doctor en Demografía	Doctora en Demografía	GRADO	D	Posgrado	5	11-00-40544	2000-10-19	11-00-40544	10/19/00	7247	139	Doctorado en Demografía	Lote 1
P11	Fac. Ciencias Económicas  - Esc. de Graduados	Facultad de Ciencias Económicas	168	921	Magister en Estadística Aplicada	Magister en Estadística Aplicada	GRADO	M	Posgrado	5	\N	\N	\N	\N	1239	921	Maestría en Estadística Aplicada	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	601	Licenciado en Matemática	Licenciada en Matemática	GRADO	G	Grado	3	\N	1957-02-26	1/57	02/26/57	3	601	Licenciatura en Matemática	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	6085	Profesor en Matemática	Profesora en Matemática	GRADO	G	Grado	3	\N	1997-06-24	103/98	01/27/98	13	6085	Profesorado en Matemática	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	611	Licenciado en Astronomía	Licenciada en Astronomía	GRADO	G	Grado	3	\N	1957-02-26	1/57	02/26/57	333	611	Licenciatura en Astronomía	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	621	Licenciado en Física	Licenciada en Física	GRADO	G	Grado	3	\N	1957-02-26	1/57	02/26/57	24	621	Licenciatura en Física	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	6287	Profesor en Física	Profesora en Física	GRADO	G	Grado	3	\N	1997-06-24	108/98	01/27/98	29	6287	Profesorado en Física	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	631	Licenciado en Computación	Licenciada en Computación	GRADO	G	Grado	3	\N	1992-09-01	2816/93	10/19/93	271	631	Licenciatura en Computación	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	637	Analista en Computación	Analista en Computación	INTERMEDIO	P	Pregrado	1	\N	1997-12-16	673/99	08/18/99	264	638	Licenciatura en Ciencias de la Computación	Lote 1
03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	638	Licenciado en Ciencias de la Computación	Licenciada en Ciencias de la Computación	GRADO	G	Grado	3	\N	1997-12-16	673/99	08/18/99	2053	638	Licenciatura en Ciencias de la Computación	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	609	Doctor en Matemática	Doctora en Matemática	GRADO	D	Posgrado	5	HCS 06/56	1956-11-15	\N	\N	3224	609	Doctorado en Matemática	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	619	Doctor en Astronomía	Doctora en Astronomía	GRADO	D	Posgrado	5	HCS 06/56	1956-11-15	\N	\N	1249	619	Doctorado en Astronomía	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	629	Doctor en Física	Doctora en Física	GRADO	D	Posgrado	5	HCS 06/56	1956-11-15	\N	\N	1040	629	Doctorado en Física	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	632	Especialista en Servicios y Sistemas Distribuidos	Especialista en Servicios y Sistemas Distribuidos	GRADO	E	Posgrado	5	03/06	2006-11-13	\N	\N	7739	632	Especialización en Servicios y Sistemas Distribuidos	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	633	Magister en Análisis y Procesamiento de Imágenes	Magister en Análisis y Procesamiento de Imágenes	GRADO	M	Posgrado	5	HCS 122/2007	2007-03-20	1221/2008	08/29/08	8110	633	Maestría en Análisis y Procesamiento de Imágenes	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	634	Especialista en Comunicación Pública de la Ciencia y Periodismo Científico	Especialista en Comunicación Pública de la Ciencia y Periodismo Científico	GRADO	E	Posgrado	5	HCS 118/2010	2010-03-16	\N	\N	8314	634	Especialización en Comunicación Pública de la Ciencia y Periodismo Científico	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	635	Especialista en Sistemas de Radar e Instrumentación	Especialista en Sistemas de Radar e Instrumentación	GRADO	E	Posgrado	5	HCS 220/2010	2010-04-06	\N	\N	8313	635	Especialización en Sistemas de Radar e Instrumentación	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	636	Magister en Sistemas de Radar e Instrumentación	Magister en Sistemas de Radar e Instrumentación	GRADO	M	Posgrado	5	221/2010	2010-04-06	\N	\N	\N	636	Maestría en Sistemas de Radar e Instrumentación	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	639	Doctor en Ciencias de la Computación	Doctora en Ciencias de la Computación	GRADO	D	Posgrado	5	HCS 520/05	2005-11-15	\N	\N	1214	639	Doctorado en Ciencias de la Computación	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	642	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Exactas	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Exactas	GRADO	E	Posgrado	5	CD 03/2012	2012-08-27	\N	\N	\N	642	Especialización en Criminalística y Actividades Periciales con mención en Ciencias Exactas	Lote 1
P03	Facultad de Matemática, Astronomía y Física	Facultad de Matemática, Astronomía y Física	1793	643	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Naturales	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Naturales	GRADO	E	Posgrado	5	CD 03/2012	2012-08-27	\N	\N	\N	643	Especialización en Criminalística y Actividades Periciales con mención en Ciencias Naturales	Lote 1
01	Escuela Superior de Comercio Manuel Belgrano	Escuela Superior de Comercio Manuel Belgrano	2724	M02	Técnico Superior Universitario en Administración de Cooperativas y Mutuales	Técnica Superior Universitaria en Administraciónde Cooperativas y Mutuales	GRADO	P	Pregrado	1	1113	2010-10-26	730	05/24/12	\N	M02	Tecnicatura Superior Universitaria en Administación de Cooperativas y Mutuales	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	MPEMT	Magíster en Procesos Educativos Mediados por Tecnologías	Magíster en Procesos Educativos Mediados por Tecnologías	GRADO	M	Posgrado	5	93	2006-03-21	1972	12/10/08	7730	90N	Maestría En Procesos Educativos Mediados Por Tecnologías	Lote 1
01	Escuela Superior de Comercio Manuel Belgrano	Escuela Superior de Comercio Manuel Belgrano	2724	MB06	Técnico Superior Universitario en Administración de Cooperativas y Mutuales	Técnico Superior Universitario en Administración de Cooperativas y Mutuales	GRADO	P	Pregrado	1	1113	2010-10-26	730	05/24/12	\N	MB06	Tecnicatura Superior Universitaria en Administración de Cooperativas y Mutuales	Lote 1
01	Escuela Superior de Comercio Manuel Belgrano	Escuela Superior de Comercio Manuel Belgrano	2724	MB07	Técnico Superior Universitario en Recursos Humanos	Técnico Superior Universitario en Recursos Humanos	GRADO	P	Pregrado	1	1141	2010-10-26	593	04/25/12	10764	MB07	Tecnicatura Superior Universitaria en Recursos Humanos	Lote 1
01	Escuela Superior de Comercio Manuel Belgrano	Escuela Superior de Comercio Manuel Belgrano	2724	MB08	Técnico Superior Unversitario en Comercialización	Técnico Superior Universitario en Comercialización	GRADO	P	Pregrado	1	1142	2010-10-26	31	12/14/11	\N	MB08	Tecnicatura Superior Universitaria en Comercialización	Lote 1
01	Escuela Superior de Comercio Manuel Belgrano	Escuela Superior de Comercio Manuel Belgrano	2724	MB09	Analista Universitario en Sistemas Informáticos	Analista Universitario en Sistemas Informáticos	GRADO	P	Pregrado	1	RHCS 1309/2011	2011-11-15	749/2013	04/18/13	\N	MB09	Analista Universitario en Sistemas Informáticos	Lote 1
01	Escuela Superior de Comercio Manuel Belgrano	Escuela Superior de Comercio Manuel Belgrano	2724	MB10	Técnico Superior Universitario en Gestión Financiera	Técnico Superior Universitario en Gestión Financiera	GRADO	P	Pregrado	1	RHCS 1308/2011	2011-11-15	851/2013	04/30/13	\N	MB10	Tecnicatura Superior Universitaria en Gestión Financiera	Lote 1
02	Colegio Nacional de Monserrat	Colegio Nacional de Monserrat	2723	CM01	Comunicador Visual	Comunicador Visual	GRADO	P	Pregrado	1	581/05	2005-12-06	493/06	05/11/06	10137	CM01	Comunicación Visual	Lote 1
02	Colegio Nacional de Monserrat	Colegio Nacional de Monserrat	2723	CM02	Martillero y Corredor Público	Martillero y Corredor Público	GRADO	P	Pregrado	1	582/05	2005-12-02	536/06	05/11/06	4770	CM02	Martillero y Corredor Público	Lote 1
02	Colegio Nacional de Monserrat	Colegio Nacional de Monserrat	2723	CM03	Técnico Superior en Bromatología	Técnico Superior en Bromatología	GRADO	P	Pregrado	1	583/05	2005-12-06	411/06	04/24/06	10138	CM03	Tecnicatura Superior en Bromatología	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	901	Magíster en Sociosemiótica	Magíster en Sociosemiótica	GRADO	M	Posgrado	5	178	1991-08-06	\N	\N	6576	901	Maestría en Sociosemiótica	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	902	Magíster en Partidos Políticos	Magíster en Partidos Políticos	GRADO	M	Posgrado	5	42	1995-02-21	988	03/01/95	6575	902	Maestría en Partidos Políticos	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	903	Magíster en Relaciones Internacionales	Magíster en Relaciones Internacionales	GRADO	M	Posgrado	5	159	1991-07-02	1104	03/01/95	1472	903	Maestría en Relaciones Internacionales	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	904	Magíster en Investigación Educativa - Mención Socioantropológica	Magíster en Investigación Educativa - Mención Socioantropológica	GRADO	M	Posgrado	5	318	1992-11-17	598	07/16/96	7289	904	Maestría en Investigación Educativa -Mención Socioantropológica	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	907	Magíster en Comunicación y Cultura Contemporánea	Magíster en Comunicación y Cultura Contemporánea	GRADO	M	Posgrado	5	429	2007-12-16	2084	10/09/98	6573	907	Maestría en Comunicación y Cultura Contemporánea	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	909	Magíster en Gestión para la Integración Regional	Magíster en Gestión para la Integración Regional	GRADO	M	Posgrado	5	113	2003-04-01	608	06/01/04	\N	909	Maestría en Gestión para la Integración Regional	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90B	Especialista en Gestión del Turismo Sustentable	Especialista en Gestión del Turismo Sustentable	GRADO	E	Posgrado	5	311	2004-09-07	\N	\N	\N	90B	Especialización en Gestión del Turismo Sustentable	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90C	Magíster en Políticas y Gestión del Desarrollo Local	Magíster en Políticas y Gestión del Desarrollo Local	GRADO	M	Posgrado	5	405	2004-11-02	222	12/30/08	7288	90C	Maestría en Políticas y Gestión del Desarrollo Local	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90F	Magíster en Formulación y Desarrollo de Estrategias Públicas y Privadas	Magíster en Formulación y Desarrollo de Estrategias Públicas y Privadas	GRADO	M	Posgrado	5	406	2004-11-02	\N	\N	\N	90F	Maestría en Formulación de Estrategias  Públicas y Privadas	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90G	Doctor en Ciencia Política	Doctora en Ciencia Política	GRADO	D	Posgrado	5	276	2004-08-17	844	06/25/07	1454	90G	Doctorado en Ciencia Política	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90H	Doctor en Estudios Sociales Agrarios	Doctora en Estudios Sociales Agrarios	GRADO	D	Posgrado	5	241	2008-02-03	1858	05/02/05	7298	90H	Doctorado en Estudios Sociales Agrarios	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90P	Doctor en Estudios Sociales de América Latina	Doctora en Estudios Sociales de América Latina	GRADO	D	Posgrado	5	143	2008-05-06	312	09/21/09	7729	90P	Doctorado en Estudios Sociales en América Latina	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90Q	Especialista en Turismo Alternativo	Especialista en Turismo Alternativo	GRADO	E	Posgrado	5	407	2010-05-04	\N	\N	9594	90Q	Especialización en Turismo Alternativo	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90T	Especialista en Producción y Análisis de Información para Políticas Públicas	Especialista en Producción y Análisis de Información para Políticas Públicas	GRADO	E	Posgrado	5	209	2011-04-05	\N	\N	10777	90T	Especialización en Producción y Análisis de Información para  Políticas Públicas	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	90U	Especialista en Gestión y Producción de Medios Audiovisuales	Especialista en Gestión y Producción de Medios Audiovisuales	GRADO	E	Posgrado	5	577	2012-08-07	160	02/01/11	\N	90U	Especialización en Gestión y Producción de Medios Audiovisuales	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	DGEN	Doctor en Estudios de Género	Doctora en Estudios de Género	GRADO	D	Posgrado	5	177	2009-04-07	370	\N	9585	90O	Doctorado en Estudios de Género	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	ESPED	Especialista en Comunicación, Medios y Prácticas Educativas	Especialista en Comunicación, Medios y Prácticas Educativas	GRADO	E	Posgrado	5	566	2008-11-18	\N	\N	7297	90D	Especialización en Comunicación, Medios y Prácticas Educativas	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	MDEM	Magíster en Demografía	Magíster en Demografía	GRADO	M	Posgrado	5	401	1993-12-21	3316	12/16/94	6574	906	Maestría en Demografía	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	T90A	Doctor en Semiótica	Doctora en Semiótica	GRADO	D	Posgrado	5	201	2003-06-03	1115	01/19/04	6571	90A	Doctorado en Semiótica	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	T90I	Especialista en Diseño de Encuestas y Análisis de Datos para la Planificación Social	Especialista en Diseño de Encuestas y Análisis de Datos para la Planificación Social	GRADO	E	Posgrado	5	441	2004-11-17	\N	\N	\N	90I	Especialización en Encuestas y Análisis de Datos para la Planificación Social	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	T90R	ESPECIALISTA EN LA ENSEÑANZA DE LAS CIENCIAS EXPERIMENTALES Y LA TECNOLOGÍA	ESPECIALISTA EN LA ENSEÑANZA DE LAS CIENCIAS EXPERIMENTALES Y LA TECNOLOGÍA	GRADO	E	Posgrado	5	255	2010-04-06	\N	\N	\N	90R	ESPECIALIZACION EN LA ENSEÑANZA DE LAS CIENCIAS EXPERIMENTALES Y LA TECNOLOGÍA	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	TEIC	Especialista en Investigación de la Comunicación	Especialista en Investigación de la Comunicación	GRADO	E	Posgrado	5	409	2010-05-04	152	02/26/08	7301	90E	Especialización en Investigación de la Comunicación	Lote 1
69	Centro de Estudios Avanzados	Centro de Estudios Avanzados	1818	TIT90	Especialista en Estudios de Asia Oriental	Especialista en Estudios de Asia Oriental	GRADO	E	Posgrado	5	242	2008-06-03	631	06/06/08	9057	90L	Especialización en Estudios en Asia Oriental	Lote 1
49-10	Instituto de Altos Estudios Espaciales Mario Gulich	Facultad de Matemática, Astronomía y Física	37	M0109	Magister en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	Magister en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	GRADO	M	Posgrado	5	RHCS UNC N° 42	2008-03-04	975	07/13/10	8109	640	Maestría en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	401	Licenciado en Filosofía	Licenciada en Filosofía	GRADO	G	Grado	3	12/86	1986-11-12	12/86	12/01/86	639	401	Licenciatura en Filosofía	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	408	Profesor en Filosofía	Profesora en Filosofía	GRADO	G	Grado	3	H.C.D. 785/86	1986-03-12	\N	\N	643	408	Profesorado en Filosofía	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	411	Licenciado en Letras Clásicas	Licenciada en Letras Clásicas	GRADO	G	Grado	3	HCS 266	1986-06-30	\N	\N	651	411	Licenciatura en Letras Clásicas	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	418	Profesor en Letras Clásicas	Profesora en Letras Clásicas	GRADO	G	Grado	3	266 HCS	1986-06-01	\N	\N	2367	418	Profesorado en Letras Clásicas	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	421	Licenciado en Letras Modernas	Licenciada en Letras Modernas	GRADO	G	Grado	3	HCS 253	1986-07-31	1188	10/07/05	652	421	Licenciatura en Letras Modernas	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	421	Licenciado en Letras Modernas	Licenciada en Letras Modernas	GRADO	G	Grado	3	HCS 253	1986-07-31	1188	10/07/05	652	424	LICENCIATURA	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	422	Corrector Literario	Correctora Literaria	GRADO	P	Pregrado	1	\N	\N	\N	\N	559	422	Técnico Instrumental de Corrector Literario	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	428	Profesor en Letras Modernas	Profesora en Letras Modernas	GRADO	G	Grado	3	HCS 254	1986-07-31	\N	\N	4934	428	Profesorado en Letras Modernas	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	441	Licenciado en Historia	Licenciada en Historia	GRADO	G	Grado	3	346/92	1993-03-16	47	03/31/93	794	441	Licenciatura en Historia	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	445	Licenciado en Antropología	Licenciada en Antropología	GRADO	G	Grado	3	689/08	2008-06-11	1000	06/30/09	517	445	Licenciatura en Antropología	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	448	Profesor en Historia	Profesora en Historia	GRADO	G	Grado	3	346/92	1993-03-16	47	03/31/93	800	448	Profesorado en Historia	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	451	Licenciado en Ciencias de la Educación	Licenciada en Ciencias de la Educación	GRADO	G	Grado	3	H.C.S. 161/93	1993-12-10	\N	\N	726	451	Licenciatura en Ciencias de la Educación	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	458	Profesor en Ciencias de la Educación	Profesora en Ciencias de la Educación	GRADO	G	Grado	3	H.C.S. 161/93	1993-12-10	\N	\N	732	458	Profesorado en Ciencias de la Educación	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	45A	Licenciado en Ciencias de la Educación	Licenciada en Ciencias de la Educación	GRADO	G	Grado	3	410	2010-08-04	36	12/19/11	3938	45A	Licenciatura en Ciencias de la Educación -Ciclo-	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	471	Bibliotecólogo	Bibliotecóloga	GRADO	P	Pregrado	1	H.C.S. 219/95	1995-07-04	\N	\N	2079	471	Bibliotecología y Documentación	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	472	Licenciado en Bibliotecología y Documentación	Licenciada en Bibliotecología y Documentación	GRADO	G	Grado	3	H.C.S. 219/95	1995-07-04	\N	\N	578	472	Licenciatura en Bibliotecología y Documentación	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	481	Técnico Profesional Archivero	Técnica Profesional Archivera	GRADO	P	Pregrado	1	122/86	1986-03-12	\N	\N	572	481	Archivología	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	482	Licenciado en Archivología	Licenciada en Archivología	GRADO	G	Grado	3	\N	\N	228/00	12/07/00	3877	482	Archivología	Lote 1
12	Facultad de Filosofía y Humanidades	Facultad de Filosofía y Humanidades	172	491	Licenciado en Geografía	Licenciada en Geografía	GRADO	G	Grado	3	HCS 40/02	2002-02-19	192/03	02/14/03	612	491	Licenciatura en Geografía	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	402	Especialista en Enseñanza de las Ciencias Sociales con Mención en Historia	Especialista en Enseñanza de las Ciencias Sociales con Mención en Historia	GRADO	E	Posgrado	5	275/2001	2001-09-17	271/02	06/10/02	\N	402	Especialización en Enseñanza de las Ciencias Sociales con Mención en Historia	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	403	Especialista en Enseñanza de las Ciencias Sociales con Mención en Geografía	Especialista en Enseñanza de las Ciencias Sociales con Mención en Geografía	GRADO	E	Posgrado	5	275/01	2001-09-17	271/01	01/10/02	\N	403	Especialización en Enseñanza de las Ciencias Sociales con Mención en Geografía	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	404	Especialista en Enseñanza de las Ciencias Sociales con Mención en Formación Ética y Ciudadana	Especialista en Enseñanza de las Ciencias Sociales con Mención en Formación Ética y Ciudadana	GRADO	E	Posgrado	5	275/01	2001-09-17	271/02	06/10/02	\N	404	Especialización en Enseñanza de las Ciencias Sociales con Mención  en Formación Ética y Ciudadana	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	405	Magister en Antropología	Magister en Antropología	GRADO	M	Posgrado	5	238/00	2002-04-30	173/02	04/30/02	\N	405	Maestría en Antropología	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	406	Especialista en Enseñanza de la Lengua y  la Literatura	Especialista en Enseñanza de la Lengua y  la Literatura	GRADO	E	Posgrado	5	36/96	1996-03-08	1914/97	10/08/97	\N	406	Especialización en Enseñanza de la Lengua y la Literatura	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	407	Especialista en Pedagogía de la Formación	Especialista en Pedagogía de la Formación	GRADO	D	Posgrado	5	33/2009	2009-03-09	536/2011	03/31/11	\N	407	Especialización en Pedagogía de la Formación	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	410	Doctor en Ciencias Antropológicas	Doctora en Ciencias Antropológicas	GRADO	D	Posgrado	5	534/2008	2008-12-01	1503/2011	11/05/11	\N	410	Doctorado en Ciencias Antropológicas	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	413	Especialista en Sociopsicogénesis del Entendimiento Escolar	Especialista en Sociopsicogénesis del Entendimiento Escolar	GRADO	E	Posgrado	5	32/2009	2009-03-09	1732/2011	09/28/11	\N	413	Especialización en Sociopsicogénesis del Entendimiento Escolar	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	442	Magister en Patrimonio Cultural Material, Administración, Conservación y Legislación	Magister en Patrimonio Cultural Material, Administración, Conservación y Legislación	GRADO	M	Posgrado	5	155/03	2001-08-13	991/06	11/06/01	\N	442	Maestría en Patrimonio Cultural Material, Administración, Conservación y Legislación	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	446	Especialista en Antropología Social	Especialista en Antropología Social	GRADO	E	Posgrado	5	130/07	2007-03-20	\N	\N	\N	446	Especialización en Antropología Social	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	452	Especialista en Asesoramiento y Gestión Pedagógica	Especialista en Asesoramiento y Gestión Pedagógica	GRADO	E	Posgrado	5	436/01	2001-12-17	32/04	01/15/04	\N	452	Especialización en Asesoramiento y Gestión Pedagógica	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	453	Magister en Pedagogía	Magister en Pedagogía	GRADO	M	Posgrado	5	435/2001	2001-12-17	1077/03	12/30/13	\N	453	Maestría en Pedagogía	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	455	Especialista en Adolescencia con Mención en Educación	Especialista en Adolescencia con Mención en Educación	GRADO	E	Posgrado	5	526/04	2004-11-01	445/2008	04/24/08	\N	455	Especialización en Adolescencia con Mención en Educación	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	456	Especialista en Adolescencia con Mención en Psicología del Desarrollo	Especialista en Adolescencia con Mención en Psicología del Desarrollo	GRADO	E	Posgrado	5	526/2004	2004-11-01	445/2008	04/24/08	\N	456	Especialización en Adolescencia con Mención en Psicología del Desarrollo	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	457	Especialista en Psicopedagogía	Especialista en Psicopedagogía	GRADO	E	Posgrado	5	16/07	2007-03-05	228/09	09/11/09	\N	457	Especialización en Psicopedagogía	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	855	Doctor en Ciencias de la Educación	Doctora en Ciencias de la Educación	GRADO	D	Posgrado	5	\N	2000-12-12	\N	12/15/00	\N	855	Doctorado en Ciencias de la Educación	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	856	Doctor en Filosofía	Doctora en Filosofía	GRADO	D	Posgrado	5	\N	2000-12-12	\N	12/12/01	1526	855	Doctorado en Ciencias de la Educación	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	856	Doctor en Filosofía	Doctora en Filosofía	GRADO	D	Posgrado	5	\N	2000-12-12	\N	12/12/01	1526	856	Doctorado en Filosofía	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	857	Doctor en Historia	Doctora en Historia	GRADO	D	Posgrado	5	\N	\N	\N	\N	\N	855	Doctorado en Ciencias de la Educación	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	857	Doctor en Historia	Doctora en Historia	GRADO	D	Posgrado	5	\N	\N	\N	\N	\N	857	Doctorado en Historia	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	861	Doctor en Letras	Doctora en Letras	GRADO	D	Posgrado	5	1/00	2000-09-12	517	04/09/03	\N	861	Doctorado en Letras	Lote 1
12-P	Facultad de Filosofía y Humanidades -Secretaría de Posgrado	Facultad de Filosofía y Humanidades	172	90A	Doctor en Semiótica	Doctora en Semiótica	GRADO	D	Posgrado	5	22/03	2003-05-21	\N	\N	\N	90A	Doctorado en Semiótica	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	801	Profesor en Perfeccionamiento Instrumental (Piano)	Profesora en Perfeccionamiento Instrumental (Piano)	GRADO	G	Grado	3	H.C.S 187/86	1986-03-20	MIN. 1189/2012	09/07/12	12238	801	Profesorado en Perfeccionamiento Instrumental (Piano)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	801B	Profesor en Perfeccionamiento Instrumental (Violín)	Profesora en Perfeccionamiento Instrumental (Violín)	GRADO	G	Grado	3	HCD 187/86	1986-03-10	MIN. 1189/2012	09/07/12	12240	801B	Profesorado en Perfeccionamiento Instrumental (Violín)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	801C	Profesor en Perfeccionamiento Instrumental (Viola)	Profesora en Perfeccionamiento Instrumental (Viola)	GRADO	G	Grado	3	HCD 187/86	1986-03-10	MIN. 1189/2012	09/07/12	12239	801C	Profesorado en Perfeccionamiento Instrumental (Viola)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	802	Licenciado en Perfeccionamiento Instrumental (Piano)	Licenciada en Perfeccionamiento Instrumental (Piano)	GRADO	G	Grado	3	H.C.S. 187/86	1986-03-20	MIN.245/2011	12/30/11	12233	802	Licenciatura en Perfeccionamiento Instrumental (Piano)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	802B	Licenciado en Perfeccionamiento Instrumental (Violín)	Licenciada en Perfeccionamiento Instrumental (Violín)	GRADO	G	Grado	3	HCS 187/86	1986-03-20	MIN. 245/2011	12/30/11	12235	802B	Licenciatura en Perfeccionamiento Instrumental (Violin)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	802C	Licenciado en Perfeccionamiento Instrumental (Viola)	Licenciada en Perfeccionamiento Instrumental (Viola)	GRADO	G	Grado	3	HCS 187/86	1986-03-20	MIN. 245/2011	12/30/11	12234	802C	Licenciatura en Perfeccionamiento Instrumental (Viola)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	805	Profesor en Composición Musical	Profesora en Composición Musical	GRADO	G	Grado	3	H.C.S. 167/86	1986-03-20	\N	\N	10384	805	Profesorado en Composición Musical	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	806	Licenciado en Composición Musical	Licenciada en Composición Musical	GRADO	G	Grado	3	H.C.S. 187/86	1986-03-20	\N	\N	2023	806	Licenciatura en Composición Musical	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	807	Licenciado en Dirección Coral	Licenciada en Dirección Coral	GRADO	G	Grado	3	1340/2010	2010-11-30	481/2012	03/12/12	5329	807	Licenciatura en Dirección Coral	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	812	Profesor en Educación Musical	Profesora en Educación Musical	GRADO	G	Grado	3	H.C.S. 187/86	1986-03-20	\N	\N	7428	812	Profesorado en Educación Musical	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	820	Ciclo Básico de Plástica	Ciclo Básico de Plástica	GRADO	P	Pregrado	1	H.C.S. 26/85	1985-03-19	\N	\N	11265	820	CICLO BASICO DE PLASTICA	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	822	Licenciado en Pintura	Licenciada en Pintura	GRADO	G	Grado	3	H.C.S.26/85	\N	\N	\N	850	822	Licenciatura en Pintura	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	824	Licenciado en Escultura	Licenciada en Escultura	GRADO	G	Grado	3	H.C.S. 86/85	\N	\N	\N	848	824	Licenciatura en Escultura	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	825	Profesor Superior de Educación en  Artes Plásticas: Pintura	Profesora Superior de Educación en Artes Plásticas: Pintura	GRADO	G	Grado	3	H.C.S 26/85	1985-03-19	\N	\N	11303	825	Profesorado Superior de Educación en Artes Plásticas: Pintura	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	826	Licenciado en Grabado	Licenciada en Grabado	GRADO	G	Grado	3	H.C.S. 26/85	\N	\N	\N	849	826	Licenciatura en Grabado	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	827	Profesor Superior de Educación en Artes Plásticas: Escultura	Profesora Superior de Educación en Artes Plásticas: Escultura	GRADO	G	Grado	3	H.C.S. 26/85	1985-03-19	\N	\N	11301	827	Profesorado Superior de Educación en Artes Plásticas: Escultura	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	828	Profesor Superior de Educación en Artes Plásticas: Grabado	Profesora Superior de Educación en Artes Plásticas: Grabado	GRADO	G	Grado	3	H.C.S. 26/85	1985-03-19	\N	\N	11302	828	Profesorado Superior de Educación en Artes Plásticas: Grabado	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	831	Ciclo Básico de Teatro	Ciclo Básico de Teatro	GRADO	P	Pregrado	1	H.C.S. 31/89	1989-03-28	\N	\N	6268	831	CICLO BASICO DE TEATRO	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	832	Licenciado en Teatro	Licenciada en Teatro	GRADO	G	Grado	3	H.C.S. 31/89	1989-03-28	\N	\N	891	832	Licenciatura en  Teatro (Actoral)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	832	Licenciado en Teatro	Licenciada en Teatro	GRADO	G	Grado	3	H.C.S. 31/89	1989-03-28	\N	\N	891	833	Licenciatura en Teatro (Escenográfica)	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	841	Licenciado en Cine y Televisión	Licenciada en Cine y Televisión	GRADO	G	Grado	3	H.C.S. 311-87	1987-11-16	\N	\N	890	841	Licenciatura en Cine y Televisión	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	842	Técnico Productor en Medios Audiovisuales	Técnica Productora en Medios Audiovisuales	INTERMEDIO	P	Pregrado	1	H.C.S. 311-87	1987-11-16	\N	\N	2012	842	Licenciatura en Cine y Televisión	Lote 1
95	Facultad de Artes	Facultad de Artes	2741	843	Licenciado en Artes Visuales	Licenciada en Artes Visuales	GRADO	G	Grado	3	429	2011-09-05	987	05/16/13	844	843	Licenciatura en Artes Visuales	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	892	Licenciado en Comunicación Social	Licenciada en Comunicación Social	GRADO	G	Grado	3	236/93	1993-08-03	RM 573/1999	04/07/99	538	892	Licenciatura en Comunicación Social	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	892T	Técnico Universitario en Comunicación Social	Técnica Universitaria en Comunicación Social	INTERMEDIO	P	Pregrado	1	236/93	1993-08-03	RM 573/1999	04/27/99	569	892	Licenciatura en Comunicación Social	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	895	Profesor Universitario en Comunicación Social	Profesora Universitaria en Comunicación Social	GRADO	G	Grado	3	1313	2009-12-15	RM 1774/2010	12/01/10	9536	895	Profesorado Universitario en Comunicación Social -Ciclo-	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	89A	Técnico en Relaciones Públicas	Técnica en Relaciones Públicas	GRADO	P	Pregrado	1	\N	\N	RM 5/2003	01/06/03	6222	89A	Tecnicatura en Relaciones Públicas a Distancia	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	89B	Técnico en Comunicación y Turismo	Técnica en Comunicación y Turismo	GRADO	P	Pregrado	1	\N	\N	RM 5/2003	01/06/03	6224	89B	Tecnicatura en Comunicación y Turismo a Distancia	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	89C	Técnico en Periodismo Deportivo	Técnica en Periodismo Deportivo	GRADO	P	Pregrado	1	\N	\N	RM 5/2003	01/06/03	6230	89C	Tecnicatura en Periodismo Deportivo a Distancia	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	89D	Técnico en Comunicación para las Organizaciones Sociales	Técnica en Comunicación para las Organizaciones Sociales	GRADO	P	Pregrado	1	\N	\N	5	01/06/03	6226	89D	Tecnicatura en Comunicación para las Organizaciones Sociales a Distancia	Lote 1
42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	897	89E	Técnico en Producción y Realización en Medios Masivos	Técnica en Producción y Realización en Medios Masivos	GRADO	P	Pregrado	1	\N	\N	RM 5/2003	01/06/03	6245	89E	Tecnicatura en Producción y Realización en Medios Masivos a Distancia	Lote 1
P42	Escuela de Ciencias de la Informacion	Facultad de Derecho y Ciencias Sociales	\N	894	Doctor en Comunicación Social	Doctora en Comunicación Social	GRADO	D	Posgrado	5	\N	\N	1075	05/28/13	3008	894	Doctorado en Comunicación Social	Lote 1
20	Escuela de Trabajo Social	Facultad de Derecho y Ciencias Sociales	170	872	Licenciado en Trabajo Social	Licenciado en Trabajo Social	GRADO	G	Grado	3	8/86	1986-02-11	1084/94	\N	524	872	Licenciatura en Trabajo Social	Lote 1
20	Escuela de Trabajo Social	Facultad de Derecho y Ciencias Sociales	170	873	Licenciado en Trabajo Social	Licenciada en Trabajo Social	GRADO	G	Grado	3	117/09	2009-04-01	676/2011	04/15/11	524	873	Licenciatura en Trabajo Social - Ciclo	Lote 1
P20	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	170	106	Especialista en Intervención Social en Niñez y Adolescencia	Especialista en Intervención Social en Niñez y Adolescencia	GRADO	E	Posgrado	5	106/13	2013-03-05	\N	\N	11888	106	Especialización en Intervención Social en Niñez y Adolescencia	Lote 1
P20	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	170	877	Magister en Ciencias Sociales con mención en Metodología de la Investigación Social	Magister en Ciencias Sociales con mención en Metodología de la Investigación Social	GRADO	M	Posgrado	5	91/94	1994-12-05	954/99	\N	11467	877	Maestría en Ciencias Sociales con mención en Metodología de la Investigación Social	Lote 1
P20	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	170	878	Magister en Ciencias Sociales con Mención en Políticas Sociales	Magister en Ciencias Sociales con Mención en Políticas Sociales	GRADO	M	Posgrado	5	91/94	1994-12-05	954/99	\N	11889	878	Maestría en Ciencias Sociales con mención en Políticas Sociales	Lote 1
P20	Facultad de Derecho y Ciencias Sociales	Facultad de Derecho y Ciencias Sociales	170	879	Magister en Trabajo Social con Mención en Intervención Social	Magister en Trabajo Social con Mención en Intervención Social	GRADO	M	Posgrado	5	330	2004-09-21	\N	\N	7290	879	Maestría en Trabajo Social con mención en Intervención Social	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	739	Profesor de Portugués	Profesora de Portugués	GRADO	G	Grado	3	\N	2000-06-02	\N	\N	3875	739	Profesorado de Portugués	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	741	Licenciado en Lengua y Literatura Castellanas	Licenciada en Lengua y Literatura Castellanas	GRADO	G	Grado	3	\N	1989-03-28	\N	\N	4927	741	Licenciatura en Lengua y Literatura Castellanas	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	749	Profesor de Lengua y Literatura Castellanas	Profesora de Lengua y Literatura Castellanas	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	4623	749	Profesorado de Lengua y Literatura Castellanas	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	74A	Profesor en Español Lengua Materna y Lengua Extranjera	Profesora en Español Lengua Materna y Lengua Extranjera	GRADO	G	Grado	3	\N	\N	\N	\N	6219	74A	Profesorado en Español Lengua Materna y Lengua Extranjera	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	74B	Licenciado en Español Lengua Materna y Lengua Extranjera	Licenciada en Español Lengua Materna y Lengua Extranjera	GRADO	G	Grado	3	\N	\N	\N	\N	6220	74B	Licenciatura en Español Lengua Materna y Lengua Extranjera	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	751	Licenciado en Lengua y Literatura Inglesas	Licenciada en Lengua y Literatura Inglesas	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	4886	751	Licenciatura en Lengua y Literatura Inglesa	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	752	Traductor Público Nacional de Inglés	Traductora Pública Nacional de Inglés	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	10224	752	Traductorado Público Nacional de Inglés	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	759	Profesor de Lengua Inglesa	Profesora de Lengua Inglesa	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	695	759	Profesorado de Lengua Inglesa	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	761	Licenciado en Lengua y Literatura Francesas	Licenciada en Lengua y Literatura Francesas	GRADO	G	Grado	3	\N	1989-03-28	\N	\N	4928	761	Licenciatura en Lengua y Literatura Francesas	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	762	Traductor Público Nacional de Francés	Traductora Pública Nacional de Francés	GRADO	G	Grado	3	\N	1989-03-28	\N	\N	10223	762	Traductorado Público Nacional de Francés	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	769	Profesor de Lengua Francesa	Profesora de Lengua Francesa	GRADO	G	Grado	3	\N	1989-03-28	\N	\N	10052	769	Profesorado de Lengua Francesa	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	771	Licenciado en Lengua y Literatura Italianas	Licenciada en Lengua y Literatura Italianas	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	4929	771	Licenciatura en Lengua y Literatura Italianas	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	772	Traductor Público Nacional de Italiano	Traductora Pública Nacional de Italiano	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	10225	772	Traductorado Público Nacional de Italiano	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	779	Profesor de Lengua Italiana	Profesora de Lengua Italiana	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	10051	779	Profesorado de Lengua Italiana	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	781	Licenciado en Lengua y Literatura Alemanas	Licenciada en Lengua y Literatura Alemanas	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	4926	781	Licenciatura en Lengua y Literatura Alemanas	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	782	Traductor Público Nacional de Alemán	Traductora Pública Nacional de Alemán	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	10222	782	Traductorado Público Nacional de Alemán	Lote 1
16	Facultad de Lenguas	Facultad de Lenguas	2146	789	Profesor de Lengua Alemana	Profesora de Lengua Alemana	GRADO	G	Grado	3	\N	1989-03-28	32/89	\N	10050	789	Profesorado de Lengua  Alemana	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	793	Magister en Inglés con Orientación en Lingüística Aplicada	Magister en Inglés con Orientación en Lingüística Aplicada	GRADO	M	Posgrado	5	505/1999	1999-10-19	219/2001	\N	6582	793	Maestría en Inglés con Orientación en Lingüística Aplicada	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	793	Magister en Inglés con Orientación en Lingüística Aplicada	Magister en Inglés con Orientación en Lingüística Aplicada	GRADO	M	Posgrado	5	505/1999	1999-10-19	219/2001	\N	6582	79300	Maestría en Inglés	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	794	Magister en Lengua y Cultura Italianas en Perspectiva Intercultural	Magister en Lengua y Cultura Italianas en Perspectiva Intercultural	GRADO	M	Posgrado	5	568(H.C.S.)	1999-11-16	\N	\N	11352	79400	Maestría en Lengua y Cultura Italianas en Perspectiva Intercultural	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	795	Magister en Inglés con Orientación en Literatura Angloamericana	Magister en Inglés con Orientación en Literatura Angloamericana	GRADO	M	Posgrado	5	505/1999	1999-10-19	219/2001	\N	6581	795	Maestría en Inglés con Orientación en Literatura Angloamericana	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	796	Magister en Traductología	Magister en Traductología	GRADO	M	Posgrado	5	326/2002	2002-09-03	1002/2004	\N	6896	796	Maestría en Traductología	Lote 1
06	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	304	Médico	Médica	GRADO	G	Grado	3	HCD 584	2008-10-01	962	06/30/10	959	301	Medicina	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	797	Magister en Enseñanza de Español como Lengua Extranjera	Magister en Enseñanza de Español como Lengua Extranjera	GRADO	M	Posgrado	5	251/2002	2002-08-06	\N	\N	6897	797	Maestría en Enseñanza de Español como Lengua Extranjera	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	798	Doctor en Ciencias del Lenguaje con Mención en Traductología	Doctora en Ciencias del Lenguaje con Mención en Traductología	GRADO	D	Posgrado	5	250/2002	2002-08-06	\N	\N	7327	798	Doctorado en Ciencias del Lenguaje con Mención en Traductología	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79A	Doctor en Ciencias del Lenguaje,  Mención en Culturas y Literaturas Comparadas	Doctora en Ciencias del Lenguaje, Mención en Culturas y Literaturas Comparadas	GRADO	D	Posgrado	5	277/2002	2002-08-06	\N	\N	11353	79A	Doctorado en Ciencias del Lenguaje, Mención en Culturas y Literaturas Comparadas	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79B	Doctor en Ciencias del Lenguaje, Mención en Lingüística Aplicada	Doctora en Ciencias del Lenguaje,  Mención en Lingüística Aplicada	GRADO	D	Posgrado	5	249/2002	2002-08-06	92/2004	\N	11355	79B	Doctorado en Ciencias del Lenguaje,  Mención en Lingüística Aplicada	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79C	Magister en Culturas y Literaturas Comparadas	Magister en Culturas y Literaturas Comparadas	GRADO	M	Posgrado	5	005/2007	2007-02-21	\N	\N	7728	79C	Maestría en Culturas y Literaturas Comparadas	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79D	Magister en Lenguajes e Interculturalidad	Magister en Lenguajes e Interculturalidad	GRADO	M	Posgrado	5	145/2009	\N	\N	\N	8333	79D	Maestría en Lenguajes e Interculturalidad	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79E	Especialista en Traducción Jurídica y Económica	Especialista en Traducción Jurídica y Económica	GRADO	E	Posgrado	5	HCD 284/2009	2009-11-11	\N	\N	9576	79E	Especialización en Traducción Jurídica y Económica (A Distancia)	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79F	Especialista en Traducción Científica y Técnica	Especialista en Traducción Científica y Técnica	GRADO	E	Posgrado	5	HCD 285/2009	2009-11-11	\N	\N	9577	79F	Especialización en Traducción Científica y Técnica (A Distancia)	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79G	Especialista en Interpretación	Especialista en Interpretación	GRADO	E	Posgrado	5	HCD 286/2009	2009-11-11	\N	\N	9578	79G	Especialización en Interpretación	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79H	Especialista en Procesos y Prácticas de la Lectura y la Escritura	Especialista en Procesos y Prácticas de la Lectura y la Escritura	GRADO	E	Posgrado	5	023/2011	2011-03-16	\N	\N	\N	79H	Especialización en Procesos y Prácticas de la Lectura y la Escritura	Lote 1
P16	Facultad de Lenguas - Posgrado	Facultad de Lenguas	2146	79I	Especialista en Didáctica de las Lenguas Extranjeras	Especialista en Didáctica de las Lenguas Extranjeras	GRADO	E	Posgrado	5	109/2012	2012-03-21	\N	\N	\N	79I	Especialización en Didáctica de las Lenguas Extranjeras(Modalidad a Distancia)	Lote 1
PT16	Facultad de Lenguas - Postitulo	Facultad de Lenguas	\N	124AA	POSTITULO DOCENTE EN LENGUAJE Y COMUNICACION ACTUAL. ACAD.	POSTITULO DOCENTE EN LENGUAJE Y COMUNICACION ACTUAL. ACAD.	GRADO	S	Posgrado	5	210/2003	2003-10-01	\N	\N	\N	124AA	POSTIT. DOC. EN LENGUAJE Y COMUNICACION ACTUALIZACION ACADEM	Lote 1
PT16	Facultad de Lenguas - Postitulo	Facultad de Lenguas	\N	124DS	POSTITULO DOC. EN LENGUAJE Y COMUNICACION DIPLOMAT- SUPERIOR	POSTITULO DOC. EN LENGUAJE Y COMUNICACION DIPLOMAT- SUPERIOR	GRADO	S	Posgrado	5	210/2003	2003-10-01	\N	\N	\N	124DS	POST. DOC. EN LENGUAJE Y COMUNICACION DIPLOMATURA SUPERIOR	Lote 1
PT16	Facultad de Lenguas - Postitulo	Facultad de Lenguas	\N	124ES	POSTITULO EN LENGUAJE Y COMUNICACION ESPECIAL SUPERIOR	POSTITULO EN LENGUAJE Y COMUNICACION ESPECIAL SUPERIOR	GRADO	S	Posgrado	5	210/2003	2003-10-01	\N	\N	\N	124ES	POSTIT. DOC.  EN LENGUAJE Y COMUNICACION ESPECIAL. SUPERIOR	Lote 1
PT16	Facultad de Lenguas - Postitulo	Facultad de Lenguas	\N	126AA	POSTITULO DOC. EN LINGUISTICA APLICADA - ACTUAL. ACADEMICA	POSTITULO DOC. EN LINGUISTICA APLICADA - ACTUAL. ACADEMICA	GRADO	S	Posgrado	5	308/2004	2004-09-07	\N	\N	\N	126AA	POST. EN LING. APLIC. A LOS PROC. DE LECTURA Y ESCRITURA - A	Lote 1
PT16	Facultad de Lenguas - Postitulo	Facultad de Lenguas	\N	126DS	POSTITULO DOC. EN LINGUISTICA APLICADA - DIPLOMATURA SUP.	POSTITULO DOC. EN LINGUISTICA APLICADA - DIPLOMATURA SUP.	GRADO	S	Posgrado	5	308/2004	2004-09-07	\N	\N	\N	126DS	POST. EN LING. APLIC. A LOS PROC. DE LECTURA Y ESCRITURA - D	Lote 1
PT16	Facultad de Lenguas - Postitulo	Facultad de Lenguas	\N	126ES	POSTITULO DOC. EN LINGUISTICA APLICADA - ESPECIALIZ SUPERIOR	POSTITULO DOC. EN LINGUISTICA APLICADA - ESPECIALIZ SUPERIOR	GRADO	S	Posgrado	5	308/2004	2004-09-07	\N	\N	\N	126ES	POST. EN LING. APLIC. A LOS PROC. DE LECTURA Y ESCRITURA - E	Lote 1
06027	Facultad de Cs Médicas - Escuela de Enfermería	Facultad de Ciencias Médicas	178	337	Instrumentador Quirúrgico	Instrumentadora Quirúrgica	GRADO	G	Grado	3	1657	1997-03-01	\N	\N	993	337	Instrumentador Quirúrgico	Lote 1
06027	Facultad de Cs Médicas - Escuela de Enfermería	Facultad de Ciencias Médicas	178	338	Enfermero	Enfermera	INTERMEDIO	P	Pregrado	1	340/86	1986-03-10	\N	\N	989	339	Licenciatura en Enfermería	Lote 1
06027	Facultad de Cs Médicas - Escuela de Enfermería	Facultad de Ciencias Médicas	178	339	Licenciado en Enfermería	Licenciada en Enfermería	GRADO	G	Grado	3	340/86	1986-03-10	\N	\N	990	333	Licenciatura en Enfermería  - Ciclo de Complementación Curricular	Lote 1
06027	Facultad de Cs Médicas - Escuela de Enfermería	Facultad de Ciencias Médicas	178	339	Licenciado en Enfermería	Licenciada en Enfermería	GRADO	G	Grado	3	340/86	1986-03-10	\N	\N	990	339	Licenciatura en Enfermería	Lote 1
06027	Facultad de Cs Médicas - Escuela de Enfermería	Facultad de Ciencias Médicas	178	339	Licenciado en Enfermería	Licenciada en Enfermería	GRADO	G	Grado	3	340/86	1986-03-10	\N	\N	990	REV	REVALIDA  DEL TITULO DE LICENCIADO EN ENFERMERIA	Lote 1
06-1	Facultad de Cs Médicas - Escuela de Fonoaudiología	Facultad de Ciencias Médicas	179	325	Fonoaudiólogo	Fonoaudióloga	INTERMEDIO	P	Pregrado	1	\N	1990-11-30	108/90-H.C.S.	\N	972	326	Licenciatura en Fonoaudiología	Lote 1
06-1	Facultad de Cs Médicas - Escuela de Fonoaudiología	Facultad de Ciencias Médicas	179	326	Licenciado en Fonoaudiología	Licenciada en Fonoaudiología	GRADO	G	Grado	3	\N	1990-11-30	108/90-H.C.S.-	\N	973	326	Licenciatura en Fonoaudiología	Lote 1
06025	Facultad de Cs Médicas - Escuela de Kinesiología	Facultad de Ciencias Médicas	180	325	Licenciado en Kinesiología y Fisioterapia	Licenciada en Kinesiología y Fisioterapia	GRADO	G	Grado	3	184/86	1986-03-01	1015/02	03/01/86	976	325	Licenciatura en Kinesiología  y Fisioterapia	Lote 1
06	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	301	Médico Cirujano	Médica Cirujana	GRADO	G	Grado	3	0001	1977-03-01	\N	\N	960	301	Medicina	Lote 1
06	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	304	Médico	Médica	GRADO	G	Grado	3	HCD 584	2008-10-01	962	06/30/10	959	REV	REVALIDA TITULO DE MEDICO	Lote 1
06031	Facultad de Cs Médicas - Escuela de Nutrición	Facultad de Ciencias Médicas	176	345	Licenciado en Nutrición	Licenciada en Nutrición	GRADO	G	Grado	3	\N	\N	\N	\N	979	345	Licenciatura en Nutrición	Lote 1
06026	Facultad de Cs Médicas - Escuela de Tenología Médica	Facultad de Ciencias Médicas	177	322	Técnico de Laboratorio Clínico e Histopatología	Técnica de Laboratorio Clínico e Histopatología	GRADO	P	Pregrado	1	100/70	1970-12-01	\N	\N	10386	322	Tecnicatura de Laboratorio Clínico e Histopatología	Lote 1
06026	Facultad de Cs Médicas - Escuela de Tenología Médica	Facultad de Ciencias Médicas	177	323	Técnico de Radiología	Técnica de Radiología	GRADO	P	Pregrado	1	100/71	1971-12-01	\N	\N	996	323	Tecnicatura de Radiología	Lote 1
06026	Facultad de Cs Médicas - Escuela de Tenología Médica	Facultad de Ciencias Médicas	177	327	Técnico en Radiología y Terapia Radiante	Técnica en Radiología y Terapia Radiante	GRADO	P	Pregrado	1	100/86	1986-12-01	\N	\N	996	327	Tecnicatura en Radiología y Terapia Radiante	Lote 1
06026	Facultad de Cs Médicas - Escuela de Tenología Médica	Facultad de Ciencias Médicas	177	328	Licenciado en Producción de Bio-imágenes	Licenciada en Producción de Bio-imágenes	GRADO	G	Grado	3	297/00	1995-12-01	\N	\N	4930	328	Licenciatura en Producción de Bio-Imágenes	Lote 1
06026	Facultad de Cs Médicas - Escuela de Tenología Médica	Facultad de Ciencias Médicas	177	328	Licenciado en Producción de Bio-imágenes	Licenciada en Producción de Bio-imágenes	GRADO	G	Grado	3	297/00	1995-12-01	\N	\N	4930	329-A	Licenciatura en Producción en Bio-Imágenes - Ciclo	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	303	Magister en Bioética	Magister en Bioética	GRADO	M	Posgrado	5	84/07	2007-03-01	\N	\N	5869	303	Maestría en Bioética	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	306	Magister en Salud Materno Infantil	Magister en Salud Materno Infantil	GRADO	M	Posgrado	5	\N	\N	\N	\N	6451	306	Maestría en Salud Materno Infantil	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	307	Magister en Gerencia y Administración de Servicios de Salud	Magister en Gerencia y Administración de Servicios de Salud	GRADO	M	Posgrado	5	3798/2007	2007-11-19	1168/97	\N	10586	307	Maestría en Gerencia y Administración de Servicios de Salud	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	308	Magister en Gerontología	Magister en Gerontología	GRADO	M	Posgrado	5	\N	\N	\N	\N	6449	308	Maestría en Gerontología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	309	Doctor en Medicina y Cirugía	Doctora en Medicina y Cirugía	GRADO	D	Posgrado	5	313/07	2007-05-21	\N	\N	1616	309	Doctorado en Medicina y Cirugía	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	310	Doctor en Ciencias de la Salud	Doctora en Ciencias de la Salud	GRADO	D	Posgrado	5	210/2011	2011-05-03	\N	\N	6448	310	Doctorado en Ciencias de la Salud	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	311	Magister en Microbiología con orientación en Investigación en Salud Humana	Magister en Microbiología con orientación en Investigación en Salud Humana	GRADO	M	Posgrado	5	653/2010	2010-03-01	1504/2011	03/01/11	9622	311	Maestría en Microbiología con orientación en Investigación en Salud Humana	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	312	Magister en Salud Sexual y Reproductiva	Magister en Salud Sexual y Reproductiva	GRADO	M	Posgrado	5	613/06	2006-03-01	900/09	03/01/09	12510	312	Maestría en Salud Sexual y Reproductiva	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	313	Especialista en Epidemiología	Especialista en Epidemiología	GRADO	E	Posgrado	5	\N	\N	\N	\N	2923	313	Especialización en Epidemiología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	331	Especialista en Enfermería Familiar y Comunitaria	Especialista en Enfermería Familiar y Comunitaria	GRADO	E	Posgrado	5	\N	\N	\N	\N	6473	331	Especialización en Enfermería Familiar y Comunitaria	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	332	Especialista en Salud Social y Comunitaria	Especialista en Salud Social y Comunitaria	GRADO	E	Posgrado	5	\N	\N	\N	\N	7493	332	Especialización en Salud Social y Comunitaria	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	333	Especialista en Administración y Gestión en Enfermería	Especialista en Administración y Gestión en Enfermería	GRADO	E	Posgrado	5	\N	\N	\N	\N	10775	333	Especialización en Administración y Gestión en Enfermería	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	334P	Especialista en Enfermería en el Cuidado del Paciente Crítico	Especialista en Enfermería en el Cuidado del Paciente Crítico	GRADO	E	Posgrado	5	1031/2012	2012-12-06	193/2013	03/26/13	12466	334P	Especialización en Enfermería en el Cuidado del Paciente Crítico	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	351	Especialista en Alergia e Inmunología	Especialista en Alergia e Inmunología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1618	351	Especialización en Alergia e Inmunología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	352	Especialista en Patología	Especialista en Patología	GRADO	E	Posgrado	5	\N	\N	\N	\N	6459	352	Especialización en Patología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	354	Especialista en Cardiología	Especialista en Cardiología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1623	354	Especialización en Cardiología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	355	Especialista en Clínica Médica	Especialista en Clínica Médica	GRADO	E	Posgrado	5	\N	\N	\N	\N	1631	355	Especialización en Clínica Médica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	357	Especialista en Clínica Dermatológica	Especialista en Clínica Dermatológica	GRADO	E	Posgrado	5	\N	\N	\N	\N	\N	357	Especialización en Clínica Dermatológica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	358	Especialista en Clínica Quirúrgica	Especialista en Clínica Quirúrgica	GRADO	E	Posgrado	5	\N	\N	99	06/06/89	1632	358	Especialización en Clínica Quirúrgica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	359	Especialista en Medicina Transfusional	Especialista en Medicina Transfusional	GRADO	E	Posgrado	5	\N	\N	\N	\N	6887	359	Especialización en Medicina Transfusional	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	360	Especialista en Neumonología	Especialista en Neumonología	GRADO	E	Posgrado	5	\N	\N	\N	\N	2939	360	Especialización en Neumonología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	361	Especialista en Medicina del Trabajo	Especialista en Medicina del Trabajo	GRADO	E	Posgrado	5	\N	\N	\N	\N	1648	361	Especialización en Medicina del Trabajo	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	362	Especialista en Nefrología	Especialista en Nefrología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1651	362	Especialización en Nefrología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	363	Especialista en Neonatología	Especialista en Neonatología	GRADO	E	Posgrado	5	\N	\N	\N	\N	2991	363	Especialización en Neonatología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	364	Especialista en Neurología	Especialista en Neurología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1654	364	Especialización en Neurología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	365	Especialista en Otorrinolaringología	Especialista en Otorrinolaringología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1659	365	Especialización en Otorrinolaringología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	366	Especialista en Oftamología	Especialista en Oftamología	GRADO	E	Posgrado	5	\N	\N	\N	\N	6457	366	Especialización en Oftalmología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	367	Especialista en Oncología Clínica	Especialista en Oncología Clínica	GRADO	E	Posgrado	5	\N	\N	\N	\N	1658	367	Especialización en Oncología Clínica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	368	Especialista en Cirugía Pediátrica	Especialista en Cirugía Pediátrica	GRADO	E	Posgrado	5	\N	\N	\N	\N	6456	368	Especialización en Cirugía Pediátrica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	369	Especialista en Clínica Pediátrica	Especialista en Clínica Pediátrica	GRADO	E	Posgrado	5	\N	\N	\N	\N	4125	369	Especialización en Clínica Pediátrica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	370	Especialista en Psiquiatría	Especialista en Psiquiatría	GRADO	E	Posgrado	5	\N	\N	\N	\N	1662	370	Especialización en Psiquiatría	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	371	Especialista en Reumatología	Especialista en Reumatología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1666	371	Especialización en Reumatología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	372	Especialista en Terapia Intensiva	Especialista en Terapia Intensiva	GRADO	E	Posgrado	5	\N	\N	\N	\N	1668	372	Especialización en Terapia Intensiva	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	373	Especialista en Tocoginecología	Especialista en Tocoginecología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1669	373	Especialización en Tocoginecología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	374	Especialista en Cirugía Plástica	Especialista en Cirugía Plástica	GRADO	E	Posgrado	5	\N	\N	\N	\N	1627	374	Especialización en Cirugía Plástica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	375	Especialista en Endocrinología	Especialista en Endocrinología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1637	375	Especialización en Endocrinología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	376	Especialista en Urología	Especialista en Urología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1670	376	Especialización en Urología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	378	Especialista en Farmacología Clínica	Especialista en Farmacología Clínica	GRADO	E	Posgrado	5	\N	\N	\N	\N	6467	378	Especialización en Farmacología Clínica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	379	Especialista en Flebología y Linfología	Especialista en Flebología y Linfología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1640	379	Especialización en Flebología y Linfología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	380	Magister en Salud Mental	Magister en Salud Mental	GRADO	M	Posgrado	5	209/2010	\N	500/2010	05/18/10	\N	380	Maestría en Salud Mental	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	381	Especialista en Infectología	Especialista en Infectología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1645	381	Especialización en Infectología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	382	Especialista en Medicina Familiar y General	Especialista en Medicina Familiar y General	GRADO	E	Posgrado	5	\N	\N	\N	\N	6470	382	Especialización en Medicina Familiar y General	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	383	Especialista en Medicina del Deporte	Especialista en Medicina del Deporte	GRADO	E	Posgrado	5	\N	\N	\N	\N	1647	383	Especialización en Medicina del Deporte	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	384	Especialista en Medicina Legal	Especialista en Medicina Legal	GRADO	E	Posgrado	5	\N	\N	\N	\N	1650	384	Especialización en Medicina Legal	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	386	Especialista en Neurocirugía	Especialista en Neurocirugía	GRADO	E	Posgrado	5	\N	\N	\N	\N	6476	386	Especialización en Neurocirugía	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	387	Especialista en Radiología y Diagnóstico por Imágenes	Especialista en Radiología y Diagnóstico por Imágenes	GRADO	E	Posgrado	5	\N	\N	\N	\N	6469	387	Especialización en Radiología y Diagnóstico por Imágenes	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	388	Especialista en Gastroenterología	Especialista en Gastroenterología	GRADO	E	Posgrado	5	\N	\N	\N	\N	1641	388	Especialización en Gastroenterología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	389	Especialista en Geriatría	Especialista en Geriatría	GRADO	E	Posgrado	5	\N	\N	\N	\N	1642	389	Especialización en Geriatría	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	390	Especialista en Ortopedia y Traumatología	Especialista en Ortopedia y Traumatología	GRADO	E	Posgrado	5	\N	\N	\N	\N	3710	390	Especialización en Ortopedia y Traumatología	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	391	Especialista en Cirugía de Tórax	Especialista en Cirugía de Tórax	GRADO	E	Posgrado	5	\N	\N	\N	\N	\N	391	Especialización en Cirugía de Tórax	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	392	Especialista en Radioterapia Oncológica	Especialista en Radioterapia Oncológica	GRADO	E	Posgrado	5	\N	\N	\N	\N	6471	392	Especialización en Radioterapia Oncológica	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	393	Magister en Salud Pública	Magister en Salud Pública	GRADO	M	Posgrado	5	490/03	2003-03-01	1609/04	03/01/04	1783	393	Maestría en Salud Pública	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	394	Magister en Drogadependencia	Magister en Drogadependencia	GRADO	M	Posgrado	5	136/97	1997-03-01	2510/1998	03/01/98	6468	394	Maestría en Drogadependencia	Lote 1
06029	Facultad de Ciencias Médicas	Facultad de Ciencias Médicas	175	395	Especialista en Diabetología	Especialista en Diabetología	GRADO	E	Posgrado	5	\N	\N	\N	\N	6888	395	Especialización en Diabetología	Lote 1
\.


--
-- TOC entry 2114 (class 0 OID 1260054)
-- Dependencies: 173 2123
-- Data for Name: resolution; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY resolution (id, state_enable, type_resolution_id, number_resolution, year_resolution, date_resolution) FROM stdin;
f41acfc1-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1189	2012	2012-07-30
f41af6d2-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1712	2013	2013-08-22
f41b44f3-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	987	2013	2013-05-16
f41b6c04-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	907	1996	1996-08-26
f41b6c05-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	228	2000	2000-12-07
f41b6c06-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1191	2012	2012-07-30
f41b6c07-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1552	2012	2011-09-10
f41b6c08-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	753	1998	1998-04-27
f41b6c09-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	755	2013	2013-04-22
f41b6c0a-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	456	2010	2010-04-13
f41b6c0b-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1199	2012	2012-07-30
f41c084c-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	36	2011	2011-12-19
f41c084d-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	192	2003	2003-02-14
f41c084e-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1113	2009	2009-07-17
f41c084f-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	797	2005	2005-07-04
f41c0850-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	852	2013	2013-04-30
f41c0851-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	364	1995	1995-02-27
f41c0852-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	2125	1997	1997-11-05
f41c0853-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1982	2010	2010-12-23
f41c0854-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	889	2002	2002-09-23
f41c0855-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	515	2013	2013-03-21
f41c0856-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	556	2010	\N
f41c0857-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	434	2000	2000-05-22
f41c0858-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	2114	2007	2007-12-07
f41c0859-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	573	1999	1999-04-27
f41c085a-6a90-11e4-bc76-f314bf0101e2	t	d0c48a1a-65ff-401c-a9c1-8d86bee81cd0	1146	2012	\N
f41c085b-6a90-11e4-bc76-f314bf0101e2	t	d0c48a1a-65ff-401c-a9c1-8d86bee81cd0	544	99	\N
f41c085c-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	5	2003	2003-01-06
f41c085d-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1127	1995	1995-11-27
f41c085e-6a90-11e4-bc76-f314bf0101e2	t	d0c48a1a-65ff-401c-a9c1-8d86bee81cd0	1516	2011	\N
f41c085f-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	403	2008	2008-04-11
f41c0860-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	673	1999	1999-08-18
f41c0861-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1118	2009	2009-07-17
f41c0862-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1015	2002	2002-10-03
f41c0863-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	103	1998	1998-01-27
f41c0864-6a90-11e4-bc76-f314bf0101e2	t	d0c48a1a-65ff-401c-a9c1-8d86bee81cd0	98	86	\N
f41c0865-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	236	1995	1995-08-14
f41c0866-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	791	2005	2005-07-04
f41c0867-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1643	2012	2012-09-20
f41c0868-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1774	2010	2010-12-01
f41c0869-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1471	9393	1993-07-06
f41c086a-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	481	2012	2012-04-12
f41c086b-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1188	2005	2005-10-07
f41c086c-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	2258	2012	2012-12-11
f41c086d-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	571	2008	2008-05-16
f41c086e-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	991	2009	2009-06-30
f41c086f-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1194	2012	2012-07-30
f41c0870-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1269	2010	2012-08-02
f41c0871-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1683	2013	2013-08-22
f41c0872-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	693	2002	2002-08-21
f41c0873-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1471	1993	1993-07-06
f41c0874-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	664	2011	2011-04-11
f41c0875-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	739	2007	2007-06-14
f41c0876-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1077	2012	2012-07-20
f41c0877-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1486	2012	2012-08-30
f41c0878-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1117	1993	1993-05-26
f41c0879-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1408	2013	2013-07-01
f41c087a-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1082	1994	1994-05-05
f41c087b-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1106	2008	2008-08-11
f41c087c-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	979	1997	1997-06-13
f41c087d-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	3317	1994	1994-12-16
f41c087e-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	245	2011	2011-12-30
f41c087f-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	47	1999	1999-01-14
f41c0880-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1000	2009	2009-06-30
f41c0881-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	762	2003	2003-12-01
f41c0882-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1190	2012	2012-07-30
f41c0883-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	471	2007	2007-05-07
f41c0884-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1106	2002	2002-11-01
f41c0885-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1184	2012	2012-07-30
f41c0886-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	780	2007	2007-06-25
f41c0887-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	212	2001	2001-03-19
f41c0888-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	1552	2012	2012-09-10
f41c0889-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	477	2000	2000-06-02
f41c088a-6a90-11e4-bc76-f314bf0101e2	t	fe591138-d26c-419e-a004-e76c2306a2cd	789	2012	2012-06-08
\.


--
-- TOC entry 2115 (class 0 OID 1260060)
-- Dependencies: 174 2123
-- Data for Name: resolution_type; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY resolution_type (id, state_enable, code, name, comment) FROM stdin;
9e57c753-13d8-4f84-bf94-2bd89dd6540e	t	1	Resolución Rectoral	\N
d0c48a1a-65ff-401c-a9c1-8d86bee81cd0	t	2	Resolución HCS	RES HCS - Resolución HCS
785c7579-d55e-4b2d-b4a3-72b4951c38e8	t	3	Resolución Decanal	\N
4dbcbccc-a6b3-48e3-893f-51ab781541df	t	4	Resolución HCD	\N
fe591138-d26c-419e-a004-e76c2306a2cd	t	5	Resolución Ministerial	RM - Resolución Ministerial
8a9167ac-1a9d-45b7-8844-5acce6c2db3d	t	6	Resolución CONEAU	\N
\.


--
-- TOC entry 2116 (class 0 OID 1260066)
-- Dependencies: 175 2123
-- Data for Name: title; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY title (id, state_enable, code, title, female_title, title_type_id, title_mode_id, comment, cg, career_id, title_state_id) FROM stdin;
f3d22d79-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Procesos y Prácticas de la Lectura y la Escritura	Especialista en Procesos y Prácticas de la Lectura y la Escritura	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382125e-6a90-11e4-bc76-f314bf0101e2	\N
f3d3b41a-6a90-11e4-bc76-f314bf0101e2	t	10775	Especialista en Administración y Gestión en Enfermería	Especialista en Administración y Gestión en Enfermería	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876980-6a90-11e4-bc76-f314bf0101e2	\N
f3d3db2b-6a90-11e4-bc76-f314bf0101e2	t	333	Licenciado en Astronomía	Licenciada en Astronomía	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a136-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d3db2c-6a90-11e4-bc76-f314bf0101e2	t	3710	Especialista en Ortopedia y Traumatología	Especialista en Ortopedia y Traumatología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae05-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d3db2d-6a90-11e4-bc76-f314bf0101e2	t	3938	Licenciado en Ciencias de la Educación	Licenciada en Ciencias de la Educación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381eb32-6a90-11e4-bc76-f314bf0101e2	\N
f3d3db2e-6a90-11e4-bc76-f314bf0101e2	t	1647	Especialista en Medicina del Deporte	Especialista en Medicina del Deporte	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f78-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d3db2f-6a90-11e4-bc76-f314bf0101e2	t	3224	Doctor en Matemática	Doctora en Matemática	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832378-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d3db30-6a90-11e4-bc76-f314bf0101e2	t	37	Licenciado en Química	Licenciada en Química	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387698d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40241-6a90-11e4-bc76-f314bf0101e2	t	10384	Profesor en Composición Musical	Profesora en Composición Musical	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821272-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40242-6a90-11e4-bc76-f314bf0101e2	t	4934	Profesor en Letras Modernas	Profesora en Letras Modernas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3832377-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40243-6a90-11e4-bc76-f314bf0101e2	t	3732	Especialista en Derecho de los Negocios	Especialista en Derecho de los Negocios	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f69-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40244-6a90-11e4-bc76-f314bf0101e2	t	\N	ESPECIALISTA EN LA ENSEÑANZA DE LAS CIENCIAS EXPERIMENTALES Y LA TECNOLOGÍA	ESPECIALISTA EN LA ENSEÑANZA DE LAS CIENCIAS EXPERIMENTALES Y LA TECNOLOGÍA	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876988-6a90-11e4-bc76-f314bf0101e2	\N
f3d40245-6a90-11e4-bc76-f314bf0101e2	t	1594	Especialista en Psicología Clínica	Especialista en Psicología Clínica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383236c-6a90-11e4-bc76-f314bf0101e2	\N
f3d40246-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Ciencias Económicas	Doctora en Ciencias Económicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832373-6a90-11e4-bc76-f314bf0101e2	\N
f3d40247-6a90-11e4-bc76-f314bf0101e2	t	960	Médico Cirujano	Médica Cirujana	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876971-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d40248-6a90-11e4-bc76-f314bf0101e2	t	8231	Especialista en Bioquímica Clínica en Bromatología	Especialista en Bioquímica Clínica en Bromatología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a13c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40249-6a90-11e4-bc76-f314bf0101e2	t	7300	Especialista en Enseñanza Universitaria de la Arquitectura y el Diseño	Especialista en Enseñanza Universitaria de la Arquitectura y el Diseño	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f65-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4024a-6a90-11e4-bc76-f314bf0101e2	t	6467	Especialista en Farmacología Clínica	Especialista en Farmacología Clínica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821245-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4024b-6a90-11e4-bc76-f314bf0101e2	t	890	Licenciado en Cine y Televisión	Licenciada en Cine y Televisión	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f73-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4024c-6a90-11e4-bc76-f314bf0101e2	t	9594	Especialista en Turismo Alternativo	Especialista en Turismo Alternativo	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f5a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4024d-6a90-11e4-bc76-f314bf0101e2	t	\N	POSTITULO EN LENGUAJE Y COMUNICACION ESPECIAL SUPERIOR	POSTITULO EN LENGUAJE Y COMUNICACION ESPECIAL SUPERIOR	\N	\N	\N	f	f3825fb2-6a90-11e4-bc76-f314bf0101e2	\N
f3d4024e-6a90-11e4-bc76-f314bf0101e2	t	1526	Doctor en Filosofía	Doctora en Filosofía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4024f-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Reproducción Bovina	Especialista en Reproducción Bovina	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825f9d-6a90-11e4-bc76-f314bf0101e2	\N
f3d40250-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Ciencias Antropológicas	Doctora en Ciencias Antropológicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f5e-6a90-11e4-bc76-f314bf0101e2	\N
f3d40251-6a90-11e4-bc76-f314bf0101e2	t	450	Contador Público	Contadora Pública	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825fb9-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40252-6a90-11e4-bc76-f314bf0101e2	t	1670	Especialista en Urología	Especialista en Urología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae00-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40253-6a90-11e4-bc76-f314bf0101e2	t	1526	Doctor en Filosofía	Doctora en Filosofía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821270-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40254-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Enseñanza de las Ciencias Sociales con Mención en Formación Ética y Ciudadana	Especialista en Enseñanza de las Ciencias Sociales con Mención en Formación Ética y Ciudadana	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adf0-6a90-11e4-bc76-f314bf0101e2	\N
f3d40255-6a90-11e4-bc76-f314bf0101e2	t	12239	Profesor en Perfeccionamiento Instrumental (Viola)	Profesora en Perfeccionamiento Instrumental (Viola)	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f72-6a90-11e4-bc76-f314bf0101e2	\N
f3d40256-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Letras	Doctora en Letras	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876991-6a90-11e4-bc76-f314bf0101e2	\N
f3d40257-6a90-11e4-bc76-f314bf0101e2	t	1286	Especialista en Derecho de Familia	Especialista en Derecho de Familia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f38769a0-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40258-6a90-11e4-bc76-f314bf0101e2	t	9585	Doctor en Estudios de Género	Doctora en Estudios de Género	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832362-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d40259-6a90-11e4-bc76-f314bf0101e2	t	8234	Especialista en Gestión de Tecnologías Innovadoras	Especialista en Gestión de Tecnologías Innovadoras	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae01-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4025a-6a90-11e4-bc76-f314bf0101e2	t	9578	Especialista en Interpretación	Especialista en Interpretación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382126d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4025b-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Diseño de Encuestas y Análisis de Datos para la Planificación Social	Especialista en Diseño de Encuestas y Análisis de Datos para la Planificación Social	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae03-6a90-11e4-bc76-f314bf0101e2	\N
f3d4025c-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Gestión y Producción de Medios Audiovisuales	Especialista en Gestión y Producción de Medios Audiovisuales	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821249-6a90-11e4-bc76-f314bf0101e2	\N
f3d4025d-6a90-11e4-bc76-f314bf0101e2	t	1075	Doctor en Ciencias Biológicas	Doctora en Ciencias Biológicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb6-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4025e-6a90-11e4-bc76-f314bf0101e2	t	996	Técnico de Radiología	Técnica de Radiología	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f381c41e-6a90-11e4-bc76-f314bf0101e2	\N
f3d4025f-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Gestión del Turismo Sustentable	Especialista en Gestión del Turismo Sustentable	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fc0-6a90-11e4-bc76-f314bf0101e2	\N
f3d45080-6a90-11e4-bc76-f314bf0101e2	t	959	Médico	Médica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382ae18-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d45081-6a90-11e4-bc76-f314bf0101e2	t	1488	Magíster en Sociología	Magíster en Sociología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821274-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d45082-6a90-11e4-bc76-f314bf0101e2	t	9057	Especialista en Estudios de Asia Oriental	Especialista en Estudios de Asia Oriental	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382125a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d45083-6a90-11e4-bc76-f314bf0101e2	t	8218	Especialista en Bioquímica Clínica en Hematología	Especialista en Bioquímica Clínica en Hematología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c41b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d47794-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Semiótica	Doctora en Semiótica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adef-6a90-11e4-bc76-f314bf0101e2	\N
f3d47795-6a90-11e4-bc76-f314bf0101e2	t	4930	Licenciado en Producción de Bio-imágenes	Licenciada en Producción de Bio-imágenes	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387698a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d47796-6a90-11e4-bc76-f314bf0101e2	t	7301	Especialista en Investigación de la Comunicación	Especialista en Investigación de la Comunicación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa2-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d47797-6a90-11e4-bc76-f314bf0101e2	t	7320	Magister en Ciencias de la Ingeniería - Mención Transporte	Magister en Ciencias de la Ingeniería - Mención Transporte	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb0-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d47798-6a90-11e4-bc76-f314bf0101e2	t	6565	Especialista en Prótesis Fija, Removible e Implantología	Especialista en Prótesis Fija, Removible e Implantología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825f9a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d47799-6a90-11e4-bc76-f314bf0101e2	t	6449	Magister en Gerontología	Magister en Gerontología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa0-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4779a-6a90-11e4-bc76-f314bf0101e2	t	8110	Magister en Análisis y Procesamiento de Imágenes	Magister en Análisis y Procesamiento de Imágenes	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821257-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4779b-6a90-11e4-bc76-f314bf0101e2	t	652	Licenciado en Letras Modernas	Licenciada en Letras Modernas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382ae0c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4779c-6a90-11e4-bc76-f314bf0101e2	t	7197	Técnico en Economía y Administración de Pequeñas y Medianas Empresas	Técnica en Economía y Administración de Pequeñas y Medianas Empresas	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f381eb33-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4779d-6a90-11e4-bc76-f314bf0101e2	t	1405	Especialista en Sindicatura Concursal	Especialista en Sindicatura Concursal	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3887a20-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4779e-6a90-11e4-bc76-f314bf0101e2	t	6220	Licenciado en Español Lengua Materna y Lengua Extranjera	Licenciada en Español Lengua Materna y Lengua Extranjera	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a14d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4779f-6a90-11e4-bc76-f314bf0101e2	t	\N	Técnico Superior Universitario en Administración de Cooperativas y Mutuales	Técnico Superior Universitario en Administración de Cooperativas y Mutuales	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3851f53-6a90-11e4-bc76-f314bf0101e2	\N
f3d477a0-6a90-11e4-bc76-f314bf0101e2	t	7287	Magister en Conservación y Rehabilitación del Patrimonio Arquitectónico	Magister en Conservación y Rehabilitación del Patrimonio Arquitectónico	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876997-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d477a1-6a90-11e4-bc76-f314bf0101e2	t	5390	Ingeniero Biomédico	Ingeniera Biomédica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f6c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477a2-6a90-11e4-bc76-f314bf0101e2	t	11888	Especialista en Intervención Social en Niñez y Adolescencia	Especialista en Intervención Social en Niñez y Adolescencia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383236e-6a90-11e4-bc76-f314bf0101e2	\N
f3d477a3-6a90-11e4-bc76-f314bf0101e2	t	212	Ingeniero Químico	Ingeniera Química	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3885306-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477a4-6a90-11e4-bc76-f314bf0101e2	t	7727	Magister en Educación en Ciencias Experimentales y Tecnología	Magister en Educación en Ciencias Experimentales y Tecnología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388c861-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477a5-6a90-11e4-bc76-f314bf0101e2	t	4623	Profesor de Lengua y Literatura Castellanas	Profesora de Lengua y Literatura Castellanas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3825fb8-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477a6-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Cirugía Buco-Máxilo-Facial	Especialista en Cirugía Buco-Máxilo-Facial	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae04-6a90-11e4-bc76-f314bf0101e2	\N
f3d477a7-6a90-11e4-bc76-f314bf0101e2	t	1651	Especialista en Nefrología	Especialista en Nefrología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876993-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477a8-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Intervención e Investigación Psicosocial	Magister en Intervención e Investigación Psicosocial	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fac-6a90-11e4-bc76-f314bf0101e2	\N
f3d477a9-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Pedagogía de la Formación	Especialista en Pedagogía de la Formación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fba-6a90-11e4-bc76-f314bf0101e2	\N
f3d477aa-6a90-11e4-bc76-f314bf0101e2	t	6268	Ciclo Básico de Teatro	Ciclo Básico de Teatro	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382fc3b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477ab-6a90-11e4-bc76-f314bf0101e2	t	2939	Especialista en Neumonología	Especialista en Neumonología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876994-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477ac-6a90-11e4-bc76-f314bf0101e2	t	2079	Bibliotecólogo	Bibliotecóloga	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f6e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477ad-6a90-11e4-bc76-f314bf0101e2	t	270	Ingeniero en Computación	Ingeniera en Computación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821260-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477ae-6a90-11e4-bc76-f314bf0101e2	t	8217	Especialista en Esterilización	Especialista en Esterilización	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821250-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477af-6a90-11e4-bc76-f314bf0101e2	t	317	Geólogo	Geóloga	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a14c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b0-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Enseñanza de las Ciencias Sociales con Mención en Historia	Especialista en Enseñanza de las Ciencias Sociales con Mención en Historia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a143-6a90-11e4-bc76-f314bf0101e2	\N
f3d477b1-6a90-11e4-bc76-f314bf0101e2	t	\N	Técnico Superior Unversitario en Comercialización	Técnico Superior Universitario en Comercialización	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3821251-6a90-11e4-bc76-f314bf0101e2	\N
f3d477b2-6a90-11e4-bc76-f314bf0101e2	t	1137	Magister en Diseño Arquitectónico y Urbano	Magister en Diseño Arquitectónico y Urbano	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f38286d6-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b3-6a90-11e4-bc76-f314bf0101e2	t	1749	Doctor en Odontología	Doctora en Odontología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f7a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b4-6a90-11e4-bc76-f314bf0101e2	t	10586	Magister en Gerencia y Administración de Servicios de Salud	Magister en Gerencia y Administración de Servicios de Salud	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832379-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b5-6a90-11e4-bc76-f314bf0101e2	t	5192	Profesor en Psicología	Profesora en Psicología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382adfc-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b6-6a90-11e4-bc76-f314bf0101e2	t	9793	Técnico en Gestión Universitaria	Técnica en Gestión Universitaria	a089f661-c0cd-4384-85c8-72299afbcd37	746215b8-756f-4c0f-831a-4da241db161f	\N	f	f387698b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b7-6a90-11e4-bc76-f314bf0101e2	t	7316	Magister en Ciencias de la Ingeniería - Mención en Administración	Magister en Ciencias de la Ingeniería - Mención en Administración	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae11-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b8-6a90-11e4-bc76-f314bf0101e2	t	6222	Técnico en Relaciones Públicas	Técnica en Relaciones Públicas	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382d529-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477b9-6a90-11e4-bc76-f314bf0101e2	t	578	Licenciado en Bibliotecología y Documentación	Licenciada en Bibliotecología y Documentación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832351-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477ba-6a90-11e4-bc76-f314bf0101e2	t	6897	Magister en Enseñanza de Español como Lengua Extranjera	Magister en Enseñanza de Español como Lengua Extranjera	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f68-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477bb-6a90-11e4-bc76-f314bf0101e2	t	2392	Ingeniero Ambiental	Ingeniera Ambiental	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f38769a1-6a90-11e4-bc76-f314bf0101e2	\N
f3d477bc-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Ciencias Químicas	Magister en Ciencias Químicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832364-6a90-11e4-bc76-f314bf0101e2	\N
f3d477bd-6a90-11e4-bc76-f314bf0101e2	t	6448	Doctor en Ciencias de la Salud	Doctora en Ciencias de la Salud	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f38286d5-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477be-6a90-11e4-bc76-f314bf0101e2	t	11278	Doctor en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	Doctora en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Administración	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae02-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477bf-6a90-11e4-bc76-f314bf0101e2	t	1632	Especialista en Clínica Quirúrgica	Especialista en Clínica Quirúrgica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fc3-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477c0-6a90-11e4-bc76-f314bf0101e2	t	572	Técnico Profesional Archivero	Técnica Profesional Archivera	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3887a21-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477c1-6a90-11e4-bc76-f314bf0101e2	t	3713	Magister en Dirección de Negocios	Magister en Dirección de Negocios	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832352-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477c2-6a90-11e4-bc76-f314bf0101e2	t	\N	Técnico Superior Universitario en Administración de Cooperativas y Mutuales	Técnica Superior Universitaria en Administraciónde Cooperativas y Mutuales	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382ae0d-6a90-11e4-bc76-f314bf0101e2	\N
f3d477c3-6a90-11e4-bc76-f314bf0101e2	t	794	Licenciado en Historia	Licenciada en Historia	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382aded-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477c4-6a90-11e4-bc76-f314bf0101e2	t	7290	Magister en Trabajo Social con Mención en Intervención Social	Magister en Trabajo Social con Mención en Intervención Social	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832367-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477c5-6a90-11e4-bc76-f314bf0101e2	t	6456	Especialista en Cirugía Pediátrica	Especialista en Cirugía Pediátrica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adf4-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d477c6-6a90-11e4-bc76-f314bf0101e2	t	1083	Magister en Manejo de Vida Silvestre	Magister en Manejo de Vida Silvestre	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383237a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ed7-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Ciencias Agropecuarias	Doctora en Ciencias Agropecuarias	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3885304-6a90-11e4-bc76-f314bf0101e2	\N
f3d49ed8-6a90-11e4-bc76-f314bf0101e2	t	\N	Magíster en Gestión para la Integración Regional	Magíster en Gestión para la Integración Regional	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f62-6a90-11e4-bc76-f314bf0101e2	\N
f3d49ed9-6a90-11e4-bc76-f314bf0101e2	t	559	Corrector Literario	Correctora Literaria	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382ae09-6a90-11e4-bc76-f314bf0101e2	\N
f3d49eda-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Didáctica de las Lenguas Extranjeras	Especialista en Didáctica de las Lenguas Extranjeras	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876998-6a90-11e4-bc76-f314bf0101e2	\N
f3d49edb-6a90-11e4-bc76-f314bf0101e2	t	12234	Licenciado en Perfeccionamiento Instrumental (Viola)	Licenciada en Perfeccionamiento Instrumental (Viola)	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832372-6a90-11e4-bc76-f314bf0101e2	\N
f3d49edc-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Enseñanza de la Lengua y  la Literatura	Especialista en Enseñanza de la Lengua y  la Literatura	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382124c-6a90-11e4-bc76-f314bf0101e2	\N
f3d49edd-6a90-11e4-bc76-f314bf0101e2	t	572	Técnico Profesional Archivero	Técnica Profesional Archivera	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3832368-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ede-6a90-11e4-bc76-f314bf0101e2	t	538	Licenciado en Comunicación Social	Licenciada en Comunicación Social	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832366-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49edf-6a90-11e4-bc76-f314bf0101e2	t	8227	Especialista en Bioquímica Clínica en Toxicología y Bioquímica Legal	Especialista en Bioquímica Clínica en Toxicología y Bioquímica Legal	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f70-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee0-6a90-11e4-bc76-f314bf0101e2	t	10386	Técnico de Laboratorio Clínico e Histopatología	Técnica de Laboratorio Clínico e Histopatología	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a139-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee1-6a90-11e4-bc76-f314bf0101e2	t	7493	Especialista en Salud Social y Comunitaria	Especialista en Salud Social y Comunitaria	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a14e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee2-6a90-11e4-bc76-f314bf0101e2	t	11229	Técnico Universitario en Jardinería y Floricultura	Técnica Universitaria en Jardinería y Floricultura	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876972-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee3-6a90-11e4-bc76-f314bf0101e2	t	6451	Magister en Salud Materno Infantil	Magister en Salud Materno Infantil	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388c867-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee4-6a90-11e4-bc76-f314bf0101e2	t	2377	Magister en Gestión Ambiental del Desarrollo Urbano	Magister en Gestión Ambiental del Desarrollo Urbano	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a141-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee5-6a90-11e4-bc76-f314bf0101e2	t	6459	Especialista en Patología	Especialista en Patología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876996-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d49ee6-6a90-11e4-bc76-f314bf0101e2	t	6470	Especialista en Medicina Familiar y General	Especialista en Medicina Familiar y General	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fbb-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5f7-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Clínica Dermatológica	Especialista en Clínica Dermatológica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699c-6a90-11e4-bc76-f314bf0101e2	\N
f3d4c5f8-6a90-11e4-bc76-f314bf0101e2	t	1454	Doctor en Ciencia Política	Doctora en Ciencia Política	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821269-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5f9-6a90-11e4-bc76-f314bf0101e2	t	7317	Magister en Ciencias de la Ingeniería Mención Telecomunicaciones	Magister en Ciencias de la Ingeniería Mención Telecomunicaciones	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adea-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5fa-6a90-11e4-bc76-f314bf0101e2	t	11303	Profesor Superior de Educación en  Artes Plásticas: Pintura	Profesora Superior de Educación en Artes Plásticas: Pintura	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3887a25-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5fb-6a90-11e4-bc76-f314bf0101e2	t	7428	Profesor en Educación Musical	Profesora en Educación Musical	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821265-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5fc-6a90-11e4-bc76-f314bf0101e2	t	6896	Magister en Traductología	Magister en Traductología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adfa-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5fd-6a90-11e4-bc76-f314bf0101e2	t	732	Profesor en Ciencias de la Educación	Profesora en Ciencias de la Educación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f63-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5fe-6a90-11e4-bc76-f314bf0101e2	t	8314	Especialista en Comunicación Pública de la Ciencia y Periodismo Científico	Especialista en Comunicación Pública de la Ciencia y Periodismo Científico	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382126f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c5ff-6a90-11e4-bc76-f314bf0101e2	t	11279	Doctor en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	Doctora en Ciencias Económicas con Mención en Ciencias Empresariales - Orientación Contabilidad	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a13e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c600-6a90-11e4-bc76-f314bf0101e2	t	10052	Profesor de Lengua Francesa	Profesora de Lengua Francesa	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382126e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c601-6a90-11e4-bc76-f314bf0101e2	t	12233	Licenciado en Perfeccionamiento Instrumental (Piano)	Licenciada en Perfeccionamiento Instrumental (Piano)	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f6d-6a90-11e4-bc76-f314bf0101e2	\N
f3d4c602-6a90-11e4-bc76-f314bf0101e2	t	4125	Especialista en Clínica Pediátrica	Especialista en Clínica Pediátrica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f384f842-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c603-6a90-11e4-bc76-f314bf0101e2	t	9576	Especialista en Traducción Jurídica y Económica	Especialista en Traducción Jurídica y Económica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383235f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c604-6a90-11e4-bc76-f314bf0101e2	t	1302	Especialista en Derecho Público	Especialista en Derecho Público	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876983-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d4c605-6a90-11e4-bc76-f314bf0101e2	t	7730	Magíster en Procesos Educativos Mediados por Tecnologías	Magíster en Procesos Educativos Mediados por Tecnologías	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876978-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c606-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Sistemas de Radar e Instrumentación	Magister en Sistemas de Radar e Instrumentación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3885308-6a90-11e4-bc76-f314bf0101e2	\N
f3d4c607-6a90-11e4-bc76-f314bf0101e2	t	6887	Especialista en Medicina Transfusional	Especialista en Medicina Transfusional	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae10-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c608-6a90-11e4-bc76-f314bf0101e2	t	2012	Técnico Productor en Medios Audiovisuales	Técnica Productora en Medios Audiovisuales	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f73-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c609-6a90-11e4-bc76-f314bf0101e2	t	4927	Licenciado en Lengua y Literatura Castellanas	Licenciada en Lengua y Literatura Castellanas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f388a138-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c60a-6a90-11e4-bc76-f314bf0101e2	t	10634	Especialista en Administración Pública Provincial y Municipal	Especialista en Administración Pública Provincial y Municipal	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa7-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c60b-6a90-11e4-bc76-f314bf0101e2	t	\N	POSTITULO DOC. EN LENGUAJE Y COMUNICACION DIPLOMAT- SUPERIOR	POSTITULO DOC. EN LENGUAJE Y COMUNICACION DIPLOMAT- SUPERIOR	\N	\N	\N	f	f3851f79-6a90-11e4-bc76-f314bf0101e2	\N
f3d4c60c-6a90-11e4-bc76-f314bf0101e2	t	349	Abogado	Abogada	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f71-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c60d-6a90-11e4-bc76-f314bf0101e2	t	6582	Magister en Inglés con Orientación en Lingüística Aplicada	Magister en Inglés con Orientación en Lingüística Aplicada	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ade9-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c60e-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Naturales	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Naturales	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f74-6a90-11e4-bc76-f314bf0101e2	\N
f3d4c60f-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Salud Mental	Magister en Salud Mental	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c419-6a90-11e4-bc76-f314bf0101e2	\N
f3d4c610-6a90-11e4-bc76-f314bf0101e2	t	6573	Magíster en Comunicación y Cultura Contemporánea	Magíster en Comunicación y Cultura Contemporánea	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae12-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c611-6a90-11e4-bc76-f314bf0101e2	t	9622	Magister en Microbiología con orientación en Investigación en Salud Humana	Magister en Microbiología con orientación en Investigación en Salud Humana	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825faa-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4c612-6a90-11e4-bc76-f314bf0101e2	t	13	Profesor en Matemática	Profesora en Matemática	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a145-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed23-6a90-11e4-bc76-f314bf0101e2	t	4926	Licenciado en Lengua y Literatura Alemanas	Licenciada en Lengua y Literatura Alemanas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821275-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed24-6a90-11e4-bc76-f314bf0101e2	t	3875	Profesor de Portugués	Profesora de Portugués	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825fad-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed25-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Enseñanza de las Ciencias Sociales con Mención en Geografía	Especialista en Enseñanza de las Ciencias Sociales con Mención en Geografía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876981-6a90-11e4-bc76-f314bf0101e2	\N
f3d4ed26-6a90-11e4-bc76-f314bf0101e2	t	10650	Doctor en Administración y Política Pública	Doctora en Administración y Política Pública	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f38286d7-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed27-6a90-11e4-bc76-f314bf0101e2	t	569	Técnico Universitario en Comunicación Social	Técnica Universitaria en Comunicación Social	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3887a23-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed28-6a90-11e4-bc76-f314bf0101e2	t	6226	Técnico en Comunicación para las Organizaciones Sociales	Técnica en Comunicación para las Organizaciones Sociales	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3851f6a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed29-6a90-11e4-bc76-f314bf0101e2	t	6571	Doctor en Semiótica	Doctora en Semiótica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adef-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed2a-6a90-11e4-bc76-f314bf0101e2	t	726	Licenciado en Ciencias de la Educación	Licenciada en Ciencias de la Educación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382adee-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed2b-6a90-11e4-bc76-f314bf0101e2	t	7297	Especialista en Comunicación, Medios y Prácticas Educativas	Especialista en Comunicación, Medios y Prácticas Educativas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382fc3d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed2c-6a90-11e4-bc76-f314bf0101e2	t	8232	Especialista en Bioquímica Clínica en Bacteriología	Especialista en Bioquímica Clínica en Bacteriología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adfb-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed2d-6a90-11e4-bc76-f314bf0101e2	t	7768	Especialista en Farmacia Hospitalaria	Especialista en Farmacia Hospitalaria	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a142-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed2e-6a90-11e4-bc76-f314bf0101e2	t	5364	Doctor en Ciencias de la Ingeniería	Doctora en Ciencias de la Ingeniería	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb3-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed2f-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Producción de Cultivos Extensivos	Especialista en Producción de Cultivos Extensivos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae16-6a90-11e4-bc76-f314bf0101e2	\N
f3d4ed30-6a90-11e4-bc76-f314bf0101e2	t	11352	Magister en Lengua y Cultura Italianas en Perspectiva Intercultural	Magister en Lengua y Cultura Italianas en Perspectiva Intercultural	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f56-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d4ed31-6a90-11e4-bc76-f314bf0101e2	t	1662	Especialista en Psiquiatría	Especialista en Psiquiatría	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed32-6a90-11e4-bc76-f314bf0101e2	t	891	Licenciado en Teatro	Licenciada en Teatro	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825fa1-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed33-6a90-11e4-bc76-f314bf0101e2	t	6476	Especialista en Neurocirugía	Especialista en Neurocirugía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825f9e-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d4ed34-6a90-11e4-bc76-f314bf0101e2	t	1083	Magister en Manejo de Vida Silvestre	Magister en Manejo de Vida Silvestre	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821273-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed35-6a90-11e4-bc76-f314bf0101e2	t	12235	Licenciado en Perfeccionamiento Instrumental (Violín)	Licenciada en Perfeccionamiento Instrumental (Violín)	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825fa6-6a90-11e4-bc76-f314bf0101e2	\N
f3d4ed36-6a90-11e4-bc76-f314bf0101e2	t	890	Licenciado en Cine y Televisión	Licenciada en Cine y Televisión	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381eb31-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d4ed37-6a90-11e4-bc76-f314bf0101e2	t	216	Constructor	Constructora	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a140-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed38-6a90-11e4-bc76-f314bf0101e2	t	190	Ingeniero Mecánico	Ingeniera Mecánica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821271-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed39-6a90-11e4-bc76-f314bf0101e2	t	10764	Técnico Superior Universitario en Recursos Humanos	Técnico Superior Universitario en Recursos Humanos	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3851f54-6a90-11e4-bc76-f314bf0101e2	\N
f3d4ed3a-6a90-11e4-bc76-f314bf0101e2	t	1616	Doctor en Medicina y Cirugía	Doctora en Medicina y Cirugía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388530a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed3b-6a90-11e4-bc76-f314bf0101e2	t	5869	Magister en Bioética	Magister en Bioética	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fbd-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed3c-6a90-11e4-bc76-f314bf0101e2	t	4930	Licenciado en Producción de Bio-imágenes	Licenciada en Producción de Bio-imágenes	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382ae13-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed3d-6a90-11e4-bc76-f314bf0101e2	t	993	Instrumentador Quirúrgico	Instrumentadora Quirúrgica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3876985-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed3e-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Adolescencia con Mención en Psicología del Desarrollo	Especialista en Adolescencia con Mención en Psicología del Desarrollo	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f6f-6a90-11e4-bc76-f314bf0101e2	\N
f3d4ed3f-6a90-11e4-bc76-f314bf0101e2	t	1214	Doctor en Ciencias de la Computación	Doctora en Ciencias de la Computación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3885309-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed40-6a90-11e4-bc76-f314bf0101e2	t	6295	Especialista en Contabilidad Superior y Auditoría	Especialista en Contabilidad Superior y Auditoría	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae15-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed41-6a90-11e4-bc76-f314bf0101e2	t	2012	Técnico Productor en Medios Audiovisuales	Técnica Productora en Medios Audiovisuales	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381eb31-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed42-6a90-11e4-bc76-f314bf0101e2	t	6268	Ciclo Básico de Teatro	Ciclo Básico de Teatro	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382fc3b-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d4ed43-6a90-11e4-bc76-f314bf0101e2	t	10777	Especialista en Producción y Análisis de Información para Políticas Públicas	Especialista en Producción y Análisis de Información para Políticas Públicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387697b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed44-6a90-11e4-bc76-f314bf0101e2	t	1298	Especialista en Derecho Procesal	Especialista en Derecho Procesal	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fc2-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed45-6a90-11e4-bc76-f314bf0101e2	t	990	Licenciado en Enfermería	Licenciada en Enfermería	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a146-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d4ed46-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Psicopedagogía	Especialista en Psicopedagogía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f7b-6a90-11e4-bc76-f314bf0101e2	\N
f3d4ed47-6a90-11e4-bc76-f314bf0101e2	t	9577	Especialista en Traducción Científica y Técnica	Especialista en Traducción Científica y Técnica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832363-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d51458-6a90-11e4-bc76-f314bf0101e2	t	361	Procurador	Procuradora	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f71-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d51459-6a90-11e4-bc76-f314bf0101e2	t	1391	Magister en Comercio Internacional	Magister en Comercio Internacional	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825f99-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5145a-6a90-11e4-bc76-f314bf0101e2	t	1249	Doctor en Astronomía	Doctora en Astronomía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821262-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5145b-6a90-11e4-bc76-f314bf0101e2	t	1623	Especialista en Cardiología	Especialista en Cardiología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382124d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5145c-6a90-11e4-bc76-f314bf0101e2	t	1058	Doctor en Ciencias Químicas	Doctora en Ciencias Químicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821246-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5145d-6a90-11e4-bc76-f314bf0101e2	t	6224	Técnico en Comunicación y Turismo	Técnica en Comunicación y Turismo	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3821247-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b6e-6a90-11e4-bc76-f314bf0101e2	t	990	Licenciado en Enfermería	Licenciada en Enfermería	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382adf6-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b6f-6a90-11e4-bc76-f314bf0101e2	t	60	Biólogo	Bióloga	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3887a24-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b70-6a90-11e4-bc76-f314bf0101e2	t	1040	Doctor en Física	Doctora en Física	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388c85f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b71-6a90-11e4-bc76-f314bf0101e2	t	12240	Profesor en Perfeccionamiento Instrumental (Violín)	Profesora en Perfeccionamiento Instrumental (Violín)	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832359-6a90-11e4-bc76-f314bf0101e2	\N
f3d53b72-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Asesoramiento y Gestión Pedagógica	Especialista en Asesoramiento y Gestión Pedagógica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fbe-6a90-11e4-bc76-f314bf0101e2	\N
f3d53b73-6a90-11e4-bc76-f314bf0101e2	t	\N	POSTITULO DOC. EN LINGUISTICA APLICADA - DIPLOMATURA SUP.	POSTITULO DOC. EN LINGUISTICA APLICADA - DIPLOMATURA SUP.	\N	\N	\N	f	f3851f67-6a90-11e4-bc76-f314bf0101e2	\N
f3d53b74-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Historia	Doctora en Historia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699e-6a90-11e4-bc76-f314bf0101e2	\N
f3d53b75-6a90-11e4-bc76-f314bf0101e2	t	11889	Magister en Ciencias Sociales con Mención en Políticas Sociales	Magister en Ciencias Sociales con Mención en Políticas Sociales	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb1-6a90-11e4-bc76-f314bf0101e2	\N
f3d53b76-6a90-11e4-bc76-f314bf0101e2	t	8229	Especialista en Bioquímica Clínica en Inmunología	Especialista en Bioquímica Clínica en Inmunología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa5-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b77-6a90-11e4-bc76-f314bf0101e2	t	7739	Especialista en Servicios y Sistemas Distribuidos	Especialista en Servicios y Sistemas Distribuidos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387698f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b78-6a90-11e4-bc76-f314bf0101e2	t	264	Analista en Computación	Analista en Computación	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f38769a3-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b79-6a90-11e4-bc76-f314bf0101e2	t	964	Odontólogo	Odontóloga	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387425c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b7a-6a90-11e4-bc76-f314bf0101e2	t	1642	Especialista en Geriatría	Especialista en Geriatría	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f58-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b7b-6a90-11e4-bc76-f314bf0101e2	t	158	Ingeniero Civil	Ingeniera Civil	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876992-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b7c-6a90-11e4-bc76-f314bf0101e2	t	7312	Magister en Derecho y Argumentación	Magister en Derecho y Argumentación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821254-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b7d-6a90-11e4-bc76-f314bf0101e2	t	1666	Especialista en Reumatología	Especialista en Reumatología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae08-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b7e-6a90-11e4-bc76-f314bf0101e2	t	7247	Doctor en Demografía	Doctora en Demografía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c41a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b7f-6a90-11e4-bc76-f314bf0101e2	t	1295	Especialista en Derecho Penal	Especialista en Derecho Penal	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae07-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b80-6a90-11e4-bc76-f314bf0101e2	t	538	Licenciado en Comunicación Social	Licenciada en Comunicación Social	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3887a23-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b81-6a90-11e4-bc76-f314bf0101e2	t	7289	Magíster en Investigación Educativa - Mención Socioantropológica	Magíster en Investigación Educativa - Mención Socioantropológica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b82-6a90-11e4-bc76-f314bf0101e2	t	6245	Técnico en Producción y Realización en Medios Masivos	Técnica en Producción y Realización en Medios Masivos	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f387425e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b83-6a90-11e4-bc76-f314bf0101e2	t	10138	Técnico Superior en Bromatología	Técnico Superior en Bromatología	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388530e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d53b84-6a90-11e4-bc76-f314bf0101e2	t	849	Licenciado en Grabado	Licenciada en Grabado	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821255-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d56195-6a90-11e4-bc76-f314bf0101e2	t	3714	Especialista en Hematología	Especialista en Hematología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832354-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5afb6-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Sociopsicogénesis del Entendimiento Escolar	Especialista en Sociopsicogénesis del Entendimiento Escolar	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383235a-6a90-11e4-bc76-f314bf0101e2	\N
f3d5afb7-6a90-11e4-bc76-f314bf0101e2	t	2021	Licenciatura en Química Farmacéutica / Farmacéutico	Licenciada en Química Farmacéutica / Farmacéutica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3832376-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d5afb8-6a90-11e4-bc76-f314bf0101e2	t	643	Profesor en Filosofía	Profesora en Filosofía	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387697c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5afb9-6a90-11e4-bc76-f314bf0101e2	t	1637	Especialista en Endocrinología	Especialista en Endocrinología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3885305-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5afba-6a90-11e4-bc76-f314bf0101e2	t	10168	Especialista en Gestión de la Innovación y Vinculación Tecnológica	Especialista en Gestión de la Innovación y Vinculación Tecnológica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3874260-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d5afbb-6a90-11e4-bc76-f314bf0101e2	t	990	Licenciado en Enfermería	Licenciada en Enfermería	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382fc3e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5afbc-6a90-11e4-bc76-f314bf0101e2	t	7746	Especialista en Derecho Laboral	Especialista en Derecho Laboral	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388c868-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5afbd-6a90-11e4-bc76-f314bf0101e2	t	11301	Profesor Superior de Educación en Artes Plásticas: Escultura	Profesora Superior de Educación en Artes Plásticas: Escultura	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a13f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5afbe-6a90-11e4-bc76-f314bf0101e2	t	4929	Licenciado en Lengua y Literatura Italianas	Licenciada en Lengua y Literatura Italianas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821256-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6cf-6a90-11e4-bc76-f314bf0101e2	t	6888	Especialista en Diabetología	Especialista en Diabetología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821259-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d0-6a90-11e4-bc76-f314bf0101e2	t	1650	Especialista en Medicina Legal	Especialista en Medicina Legal	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f5b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d1-6a90-11e4-bc76-f314bf0101e2	t	10137	Comunicador Visual	Comunicador Visual	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3821252-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d2-6a90-11e4-bc76-f314bf0101e2	t	569	Técnico Universitario en Comunicación Social	Técnica Universitaria en Comunicación Social	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832366-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d3-6a90-11e4-bc76-f314bf0101e2	t	6582	Magister en Inglés con Orientación en Lingüística Aplicada	Magister en Inglés con Orientación en Lingüística Aplicada	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adf9-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d4-6a90-11e4-bc76-f314bf0101e2	t	890	Licenciado en Cine y Televisión	Licenciada en Cine y Televisión	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f73-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d5d6d5-6a90-11e4-bc76-f314bf0101e2	t	1640	Especialista en Flebología y Linfología	Especialista en Flebología y Linfología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adfe-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d6-6a90-11e4-bc76-f314bf0101e2	t	891	Licenciado en Teatro	Licenciada en Teatro	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832353-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d7-6a90-11e4-bc76-f314bf0101e2	t	11467	Magister en Ciencias Sociales con mención en Metodología de la Investigación Social	Magister en Ciencias Sociales con mención en Metodología de la Investigación Social	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f75-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d8-6a90-11e4-bc76-f314bf0101e2	t	2053	Licenciado en Ciencias de la Computación	Licenciada en Ciencias de la Computación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f38769a3-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6d9-6a90-11e4-bc76-f314bf0101e2	t	29	Profesor en Física	Profesora en Física	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382126b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6da-6a90-11e4-bc76-f314bf0101e2	t	4924	Ciclo Básico Común	Ciclo Básico Común	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3821263-6a90-11e4-bc76-f314bf0101e2	\N
f3d5d6db-6a90-11e4-bc76-f314bf0101e2	t	1654	Especialista en Neurología	Especialista en Neurología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832350-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6dc-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Ortodoncia y Ortopedia Dento-Máxilo-Facial	Especialista en Ortodoncia y Ortopedia Dento-Máxilo-Facial	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb5-6a90-11e4-bc76-f314bf0101e2	\N
f3d5d6dd-6a90-11e4-bc76-f314bf0101e2	t	979	Licenciado en Nutrición	Licenciada en Nutrición	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876982-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6de-6a90-11e4-bc76-f314bf0101e2	t	7327	Doctor en Ciencias del Lenguaje con Mención en Traductología	Doctora en Ciencias del Lenguaje con Mención en Traductología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821266-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6df-6a90-11e4-bc76-f314bf0101e2	t	3008	Doctor en Comunicación Social	Doctora en Comunicación Social	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388c865-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6e0-6a90-11e4-bc76-f314bf0101e2	t	3	Licenciado en Matemática	Licenciada en Matemática	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a14a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6e1-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Antropología	Magister en Antropología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adeb-6a90-11e4-bc76-f314bf0101e2	\N
f3d5d6e2-6a90-11e4-bc76-f314bf0101e2	t	1618	Especialista en Alergia e Inmunología	Especialista en Alergia e Inmunología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383236d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6e3-6a90-11e4-bc76-f314bf0101e2	t	844	Licenciado en Artes Visuales	Licenciada en Artes Visuales	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832358-6a90-11e4-bc76-f314bf0101e2	\N
f3d5d6e4-6a90-11e4-bc76-f314bf0101e2	t	7181	Ciencias Económicas	Ciencias Económicas	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388a148-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d5d6e5-6a90-11e4-bc76-f314bf0101e2	t	144	Ingeniero Agrimensor	Ingeniera Agrimensora	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3851f55-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6e6-6a90-11e4-bc76-f314bf0101e2	t	\N	Analista Universitario en Sistemas Informáticos	Analista Universitario en Sistemas Informáticos	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382126a-6a90-11e4-bc76-f314bf0101e2	\N
f3d5d6e7-6a90-11e4-bc76-f314bf0101e2	t	10223	Traductor Público Nacional de Francés	Traductora Pública Nacional de Francés	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821261-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6e8-6a90-11e4-bc76-f314bf0101e2	t	7319	Magister en Ciencias de la Ingeniería - Mención Estructuras y Geotecnia	Magister en Ciencias de la Ingeniería - Mención Estructuras y Geotecnia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832375-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6e9-6a90-11e4-bc76-f314bf0101e2	t	517	Licenciado en Antropología	Licenciada en Antropología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382adf7-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6ea-6a90-11e4-bc76-f314bf0101e2	t	651	Licenciado en Letras Clásicas	Licenciada en Letras Clásicas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382125b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6eb-6a90-11e4-bc76-f314bf0101e2	t	5329	Licenciado en Dirección Coral	Licenciada en Dirección Coral	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a147-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6ec-6a90-11e4-bc76-f314bf0101e2	t	7246	Magister en Gestión y Desarrollo Habitacional	Magister en Gestión y Desarrollo Habitacional	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c420-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6ed-6a90-11e4-bc76-f314bf0101e2	t	10225	Traductor Público Nacional de Italiano	Traductora Pública Nacional de Italiano	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832365-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6ee-6a90-11e4-bc76-f314bf0101e2	t	11265	Ciclo Básico de Plástica	Ciclo Básico de Plástica	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388a13d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6ef-6a90-11e4-bc76-f314bf0101e2	t	135	Diseñador Industrial	Diseñadora Industrial	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388c864-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f0-6a90-11e4-bc76-f314bf0101e2	t	972	Fonoaudiólogo	Fonoaudióloga	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387697d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f1-6a90-11e4-bc76-f314bf0101e2	t	973	Licenciado en Fonoaudiología	Licenciada en Fonoaudiología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381c418-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f2-6a90-11e4-bc76-f314bf0101e2	t	3877	Licenciado en Archivología	Licenciada en Archivología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832368-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f3-6a90-11e4-bc76-f314bf0101e2	t	6571	Doctor en Semiótica	Doctora en Semiótica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388530b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f4-6a90-11e4-bc76-f314bf0101e2	t	6468	Magister en Drogadependencia	Magister en Drogadependencia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c417-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d5d6f5-6a90-11e4-bc76-f314bf0101e2	t	6457	Especialista en Oftamología	Especialista en Oftamología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f5f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f6-6a90-11e4-bc76-f314bf0101e2	t	317	Geólogo	Geóloga	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825f9b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f7-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Alimentación de Bovinos	Especialista en Alimentación de Bovinos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382126c-6a90-11e4-bc76-f314bf0101e2	\N
f3d5d6f8-6a90-11e4-bc76-f314bf0101e2	t	1407	Especialista en Tributación	Especialista en Tributación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f61-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6f9-6a90-11e4-bc76-f314bf0101e2	t	1659	Especialista en Otorrinolaringología	Especialista en Otorrinolaringología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3801666-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6fa-6a90-11e4-bc76-f314bf0101e2	t	1136	Magister en Desarrollo Urbano	Magister en Desarrollo Urbano	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876973-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6fb-6a90-11e4-bc76-f314bf0101e2	t	959	Médico	Médica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876971-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6fc-6a90-11e4-bc76-f314bf0101e2	t	1631	Especialista en Clínica Médica	Especialista en Clínica Médica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adf1-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5d6fd-6a90-11e4-bc76-f314bf0101e2	t	1669	Especialista en Tocoginecología	Especialista en Tocoginecología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832369-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5fe0e-6a90-11e4-bc76-f314bf0101e2	t	4924	Ciclo Básico Común	Ciclo Básico Común	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388a137-6a90-11e4-bc76-f314bf0101e2	\N
f3d5fe0f-6a90-11e4-bc76-f314bf0101e2	t	6471	Especialista en Radioterapia Oncológica	Especialista en Radioterapia Oncológica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f384f83d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5fe10-6a90-11e4-bc76-f314bf0101e2	t	7333	Especialista en Tecnología Arquitectónica	Especialista en Tecnología Arquitectónica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fae-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5fe11-6a90-11e4-bc76-f314bf0101e2	t	334	Bioquímico	Bioquímica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f383236b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d5fe12-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Exactas	Especialista en Criminalística y Actividades Periciales con mención en Ciencias Exactas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832356-6a90-11e4-bc76-f314bf0101e2	\N
f3d5fe13-6a90-11e4-bc76-f314bf0101e2	t	8331	Especialista en Productividad Organizacional	Especialista en Productividad Organizacional	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825faf-6a90-11e4-bc76-f314bf0101e2	\N
f3d62524-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Antropología Social	Especialista en Antropología Social	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383236a-6a90-11e4-bc76-f314bf0101e2	\N
f3d62525-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Teoría Psicoanalítica Lacaniana	Magister en Teoría Psicoanalítica Lacaniana	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383237b-6a90-11e4-bc76-f314bf0101e2	\N
f3d62526-6a90-11e4-bc76-f314bf0101e2	t	7321	Ingeniero Especialista en Telecomunicaciones Telefónicas	Ingeniera Especialista en Telecomunicaciones Telefónicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62527-6a90-11e4-bc76-f314bf0101e2	t	271	Licenciado en Computación	Licenciada en Computación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3832360-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d62528-6a90-11e4-bc76-f314bf0101e2	t	10051	Profesor de Lengua Italiana	Profesora de Lengua Italiana	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382124f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62529-6a90-11e4-bc76-f314bf0101e2	t	10222	Traductor Público Nacional de Alemán	Traductora Pública Nacional de Alemán	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876990-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6252a-6a90-11e4-bc76-f314bf0101e2	t	10050	Profesor de Lengua Alemana	Profesora de Lengua Alemana	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832357-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6252b-6a90-11e4-bc76-f314bf0101e2	t	1668	Especialista en Terapia Intensiva	Especialista en Terapia Intensiva	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a14b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6252c-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Adolescencia con Mención en Educación	Especialista en Adolescencia con Mención en Educación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383237c-6a90-11e4-bc76-f314bf0101e2	\N
f3d6252d-6a90-11e4-bc76-f314bf0101e2	t	524	Licenciado en Trabajo Social	Licenciada en Trabajo Social	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f66-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6252e-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Psicología del Trabajo y de las Organizaciones	Especialista en Psicología del Trabajo y de las Organizaciones	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae0a-6a90-11e4-bc76-f314bf0101e2	\N
f3d6252f-6a90-11e4-bc76-f314bf0101e2	t	11280	Doctor en Ciencias Económicas con Mención en Economía	Doctora en Ciencias Económicas con Mención en Economía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821253-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62530-6a90-11e4-bc76-f314bf0101e2	t	1242	Doctor en Ciencias Geológicas	Doctora en Ciencias Geológicas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382124e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62531-6a90-11e4-bc76-f314bf0101e2	t	92	Ingeniero Agrónomo	Ingeniera Agrónoma	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876995-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62532-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Ciencias Agropecuarias con Mención en Tecnología de Semillas	Magister en Ciencias Agropecuarias con Mención en Tecnología de Semillas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388530d-6a90-11e4-bc76-f314bf0101e2	\N
f3d62533-6a90-11e4-bc76-f314bf0101e2	t	1752	Especialista en Endondoncia	Especialista en Endondoncia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adf8-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62534-6a90-11e4-bc76-f314bf0101e2	t	1280	Doctor en Derecho y Ciencias Sociales	Doctora en Derecho y Ciencias Sociales	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c41c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62535-6a90-11e4-bc76-f314bf0101e2	t	12238	Profesor en Perfeccionamiento Instrumental (Piano)	Profesora en Perfeccionamiento Instrumental (Piano)	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382ae06-6a90-11e4-bc76-f314bf0101e2	\N
f3d62536-6a90-11e4-bc76-f314bf0101e2	t	2023	Licenciado en Composición Musical	Licenciada en Composición Musical	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f5d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62537-6a90-11e4-bc76-f314bf0101e2	t	7490	Magister en Ciencias de la Ingeniería - Mención Ambiente	Magister en Ciencias de la Ingeniería - Mención Ambiente	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382fc3c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62538-6a90-11e4-bc76-f314bf0101e2	t	7335	Doctor en Ciencias Económicas con Mención Ciencias Empresariales	Doctora en Ciencias Económicas con Mención Ciencias Empresariales	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876976-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62539-6a90-11e4-bc76-f314bf0101e2	t	612	Licenciado en Geografía	Licenciada en Geografía	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387699f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6253a-6a90-11e4-bc76-f314bf0101e2	t	6469	Especialista en Radiología y Diagnóstico por Imágenes	Especialista en Radiología y Diagnóstico por Imágenes	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adff-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6253b-6a90-11e4-bc76-f314bf0101e2	t	848	Licenciado en Escultura	Licenciada en Escultura	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382ae14-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6253c-6a90-11e4-bc76-f314bf0101e2	t	3877	Licenciado en Archivología	Licenciada en Archivología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3887a21-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6253d-6a90-11e4-bc76-f314bf0101e2	t	157	Ingeniero Aeronáutico	Ingeniera Aeronáutica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387697a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6253e-6a90-11e4-bc76-f314bf0101e2	t	989	Enfermero	Enfermera	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382fc3e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6253f-6a90-11e4-bc76-f314bf0101e2	t	118	Arquitecto	Arquitecta	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387698e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62540-6a90-11e4-bc76-f314bf0101e2	t	996	Técnico en Radiología y Terapia Radiante	Técnica en Radiología y Terapia Radiante	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388a13b-6a90-11e4-bc76-f314bf0101e2	\N
f3d62541-6a90-11e4-bc76-f314bf0101e2	t	972	Fonoaudiólogo	Fonoaudióloga	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381c418-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62542-6a90-11e4-bc76-f314bf0101e2	t	6219	Profesor en Español Lengua Materna y Lengua Extranjera	Profesora en Español Lengua Materna y Lengua Extranjera	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825fab-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62543-6a90-11e4-bc76-f314bf0101e2	t	809	Licenciado en Psicología	Licenciada en Psicología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388530f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62544-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Ciencia y Tecnología de los Alimentos	Magister en Ciencia y Tecnología de los Alimentos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383234f-6a90-11e4-bc76-f314bf0101e2	\N
f3d62545-6a90-11e4-bc76-f314bf0101e2	t	973	Licenciado en Fonoaudiología	Licenciada en Fonoaudiología	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387697d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62546-6a90-11e4-bc76-f314bf0101e2	t	77	Profesor en Ciencias Biológicas	Profesora en Ciencias Biológicas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f6b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62547-6a90-11e4-bc76-f314bf0101e2	t	990	Licenciado en Enfermería	Licenciada en Enfermería	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382adfd-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62548-6a90-11e4-bc76-f314bf0101e2	t	524	Licenciado en Trabajo Social	Licenciado en Trabajo Social	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f383235e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d62549-6a90-11e4-bc76-f314bf0101e2	t	890	Licenciado en Cine y Televisión	Licenciada en Cine y Televisión	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381eb31-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6254a-6a90-11e4-bc76-f314bf0101e2	t	1648	Especialista en Medicina del Trabajo	Especialista en Medicina del Trabajo	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382d52a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c5b-6a90-11e4-bc76-f314bf0101e2	t	10053	Profesor de Enseñanza Media y Superior en Ciencias Económicas	Profesora de Enseñanza Media y Superior en Ciencias Económicas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382124b-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d64c5c-6a90-11e4-bc76-f314bf0101e2	t	2923	Especialista en Epidemiología	Especialista en Epidemiología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821276-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c5d-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Semiótica	Doctora en Semiótica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388530b-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c5e-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Cirugía de Tórax	Especialista en Cirugía de Tórax	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f38769a2-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c5f-6a90-11e4-bc76-f314bf0101e2	t	8228	Especialista en Bioquímica Clínica en Parasitología	Especialista en Bioquímica Clínica en Parasitología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383235b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c60-6a90-11e4-bc76-f314bf0101e2	t	1239	Magister en Estadística Aplicada	Magister en Estadística Aplicada	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb7-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c61-6a90-11e4-bc76-f314bf0101e2	t	989	Enfermero	Enfermera	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388a146-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c62-6a90-11e4-bc76-f314bf0101e2	t	6546	Especialista en Planificación y Diseño del Paisaje	Especialista en Planificación y Diseño del Paisaje	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383236f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c63-6a90-11e4-bc76-f314bf0101e2	t	2053	Licenciado en Ciencias de la Computación	Licenciada en Ciencias de la Computación	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f384f83f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c64-6a90-11e4-bc76-f314bf0101e2	t	118	Arquitecto	Arquitecta	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388530c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c65-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Psicología Educacional	Especialista en Psicología Educacional	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fb4-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c66-6a90-11e4-bc76-f314bf0101e2	t	6574	Magíster en Demografía	Magíster en Demografía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387698c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c67-6a90-11e4-bc76-f314bf0101e2	t	639	Licenciado en Filosofía	Licenciada en Filosofía	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3821268-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c68-6a90-11e4-bc76-f314bf0101e2	t	1637	Especialista en Bioquímica Clínica en Endocrinología	Especialista en Bioquímica Clínica en Endocrinología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388a144-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c69-6a90-11e4-bc76-f314bf0101e2	t	11355	Doctor en Ciencias del Lenguaje, Mención en Lingüística Aplicada	Doctora en Ciencias del Lenguaje,  Mención en Lingüística Aplicada	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876989-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c6a-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Psicología Sanitaria	Especialista en Psicología Sanitaria	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa4-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c6b-6a90-11e4-bc76-f314bf0101e2	t	\N	POSTITULO DOCENTE EN LENGUAJE Y COMUNICACION ACTUAL. ACAD.	POSTITULO DOCENTE EN LENGUAJE Y COMUNICACION ACTUAL. ACAD.	\N	\N	\N	f	f3885307-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c6c-6a90-11e4-bc76-f314bf0101e2	t	4924	Ciclo Básico Común	Ciclo Básico Común	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f388c862-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c6d-6a90-11e4-bc76-f314bf0101e2	t	6576	Magíster en Sociosemiótica	Magíster en Sociosemiótica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387425f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c6e-6a90-11e4-bc76-f314bf0101e2	t	2727	Especialista en Química Clínica	Especialista en Química Clínica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa9-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c6f-6a90-11e4-bc76-f314bf0101e2	t	9536	Profesor Universitario en Comunicación Social	Profesora Universitaria en Comunicación Social	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876974-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c70-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Ciencias Agropecuarias	Magister en Ciencias Agropecuarias	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f59-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c71-6a90-11e4-bc76-f314bf0101e2	t	1305	Especialista en Derecho Tributario	Especialista en Derecho Tributario	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832361-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c72-6a90-11e4-bc76-f314bf0101e2	t	695	Profesor de Lengua Inglesa	Profesora de Lengua Inglesa	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387425d-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d64c73-6a90-11e4-bc76-f314bf0101e2	t	464	Licenciado en Economía	Licenciada en Economía	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a149-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c74-6a90-11e4-bc76-f314bf0101e2	t	192	Ingeniero Mecánico Electricista	Ingeniera Mecánica Electricista	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f384f840-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c75-6a90-11e4-bc76-f314bf0101e2	t	\N	Especialista en Tecnologías Multimedia para Desarrollos Educativos	Especialista en Tecnologías Multimedia para Desarrollos Educativos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fa3-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c76-6a90-11e4-bc76-f314bf0101e2	t	\N	POSTITULO DOC. EN LINGUISTICA APLICADA - ESPECIALIZ SUPERIOR	POSTITULO DOC. EN LINGUISTICA APLICADA - ESPECIALIZ SUPERIOR	\N	\N	\N	f	f3876975-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c77-6a90-11e4-bc76-f314bf0101e2	t	10776	Especialista en Hidráulica	Especialista en Hidráulica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382adf3-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c78-6a90-11e4-bc76-f314bf0101e2	t	7288	Magíster en Políticas y Gestión del Desarrollo Local	Magíster en Políticas y Gestión del Desarrollo Local	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821248-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d64c79-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Pedagogía	Magister en Pedagogía	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f384f841-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c7a-6a90-11e4-bc76-f314bf0101e2	t	386	Licenciado en Administración	Licenciada en Administración	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f381c41f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c7b-6a90-11e4-bc76-f314bf0101e2	t	8226	Especialista en Bioquímica Clínica en Virología	Especialista en Bioquímica Clínica en Virología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f76-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c7c-6a90-11e4-bc76-f314bf0101e2	t	1783	Magister en Salud Pública	Magister en Salud Pública	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382124a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c7d-6a90-11e4-bc76-f314bf0101e2	t	2991	Especialista en Neonatología	Especialista en Neonatología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3887a22-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c7e-6a90-11e4-bc76-f314bf0101e2	t	8109	Magister en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	Magister en Aplicaciones Espaciales de Alerta y Respuesta Temprana a Emergencias	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae0b-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c7f-6a90-11e4-bc76-f314bf0101e2	t	2006	Técnico Mecánico Electricista	Técnica Mecánica Electricista	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832371-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c80-6a90-11e4-bc76-f314bf0101e2	t	8333	Magister en Lenguajes e Interculturalidad	Magister en Lenguajes e Interculturalidad	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fc4-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c81-6a90-11e4-bc76-f314bf0101e2	t	24	Licenciado en Física	Licenciada en Física	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3876979-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c82-6a90-11e4-bc76-f314bf0101e2	t	7318	Magister en Ciencias de la Ingeniería - Mención Aeroespacial.	Magister en ciencias de la Ingeniería - Mención Aeroespacial.	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876987-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c83-6a90-11e4-bc76-f314bf0101e2	t	60	Biólogo	Bióloga	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f64-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c84-6a90-11e4-bc76-f314bf0101e2	t	7315	Magister en Ciencias de la Ingeniería, Mención Recursos Hídricos	Magister en Ciencias de la Ingeniería, Mención Recursos Hídricos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821267-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c85-6a90-11e4-bc76-f314bf0101e2	t	2390	Magister en Administración Pública	Magister en Administración Pública	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f38286d8-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c86-6a90-11e4-bc76-f314bf0101e2	t	850	Licenciado en Pintura	Licenciada en Pintura	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382ae0e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c87-6a90-11e4-bc76-f314bf0101e2	t	8219	Doctor en Neurociencias	Doctora en Neurociencias	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381eb34-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c88-6a90-11e4-bc76-f314bf0101e2	t	7729	Doctor en Estudios Sociales de América Latina	Doctora en Estudios Sociales de América Latina	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876977-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c89-6a90-11e4-bc76-f314bf0101e2	t	264	Analista en Computación	Analista en Computación	a089f661-c0cd-4384-85c8-72299afbcd37	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f384f83f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c8a-6a90-11e4-bc76-f314bf0101e2	t	8313	Especialista en Sistemas de Radar e Instrumentación	Especialista en Sistemas de Radar e Instrumentación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f383235d-6a90-11e4-bc76-f314bf0101e2	\N
f3d64c8b-6a90-11e4-bc76-f314bf0101e2	t	9058	Magister en Reproducción Bovina	Magister en Reproducción Bovina	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876986-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c8c-6a90-11e4-bc76-f314bf0101e2	t	252	Ingeniero Industrial	Ingeniera Industrial	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3851f60-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d64c8d-6a90-11e4-bc76-f314bf0101e2	t	976	Licenciado en Kinesiología y Fisioterapia	Licenciada en Kinesiología y Fisioterapia	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388c866-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6739e-6a90-11e4-bc76-f314bf0101e2	t	1472	Magíster en Relaciones Internacionales	Magíster en Relaciones Internacionales	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825f9c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d6739f-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Ciencias de la Educación	Doctora en Ciencias de la Educación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f387699e-6a90-11e4-bc76-f314bf0101e2	\N
f3d673a0-6a90-11e4-bc76-f314bf0101e2	t	\N	Magíster en Formulación y Desarrollo de Estrategias Públicas y Privadas	Magíster en Formulación y Desarrollo de Estrategias Públicas y Privadas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825f9f-6a90-11e4-bc76-f314bf0101e2	\N
f3d673a1-6a90-11e4-bc76-f314bf0101e2	t	6473	Especialista en Enfermería Familiar y Comunitaria	Especialista en Enfermería Familiar y Comunitaria	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3821258-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a2-6a90-11e4-bc76-f314bf0101e2	t	4770	Martillero y Corredor Público	Martillero y Corredor Público	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382adf5-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a3-6a90-11e4-bc76-f314bf0101e2	t	2367	Profesor en Letras Clásicas	Profesora en Letras Clásicas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f388c863-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a4-6a90-11e4-bc76-f314bf0101e2	t	7298	Doctor en Estudios Sociales Agrarios	Doctora en Estudios Sociales Agrarios	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae17-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a5-6a90-11e4-bc76-f314bf0101e2	t	652	Licenciado en Letras Modernas	Licenciada en Letras Modernas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382125d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a6-6a90-11e4-bc76-f314bf0101e2	t	11302	Profesor Superior de Educación en Artes Plásticas: Grabado	Profesora Superior de Educación en Artes Plásticas: Grabado	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f388a13a-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a7-6a90-11e4-bc76-f314bf0101e2	t	360	Notario	Notaria	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387697f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a8-6a90-11e4-bc76-f314bf0101e2	t	6581	Magister en Inglés con Orientación en Literatura Angloamericana	Magister en Inglés con Orientación en Literatura Angloamericana	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876999-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673a9-6a90-11e4-bc76-f314bf0101e2	t	\N	Técnico Superior Universitario en Gestión Financiera	Técnico Superior Universitario en Gestión Financiera	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3851f5c-6a90-11e4-bc76-f314bf0101e2	\N
f3d673aa-6a90-11e4-bc76-f314bf0101e2	t	\N	Doctor en Historia	Doctora en Historia	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382ae0f-6a90-11e4-bc76-f314bf0101e2	\N
f3d673ab-6a90-11e4-bc76-f314bf0101e2	t	77	Profesor en Ciencias Biológicas	Profesora en Ciencias Biológicas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f387697e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673ac-6a90-11e4-bc76-f314bf0101e2	t	12466	Especialista en Enfermería en el Cuidado del Paciente Crítico	Especialista en Enfermería en el Cuidado del Paciente Crítico	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f77-6a90-11e4-bc76-f314bf0101e2	\N
f3d673ad-6a90-11e4-bc76-f314bf0101e2	t	4886	Licenciado en Lengua y Literatura Inglesas	Licenciada en Lengua y Literatura Inglesas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3821264-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673ae-6a90-11e4-bc76-f314bf0101e2	t	337	Farmacéutico	Farmacéutica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f382125c-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673af-6a90-11e4-bc76-f314bf0101e2	t	1658	Especialista en Oncología Clínica	Especialista en Oncología Clínica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f382125f-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673b0-6a90-11e4-bc76-f314bf0101e2	t	1591	Doctor en Psicología	Doctora en Psicología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f381c41d-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673b1-6a90-11e4-bc76-f314bf0101e2	t	1645	Especialista en Infectología	Especialista en Infectología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f388c860-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673b2-6a90-11e4-bc76-f314bf0101e2	t	1627	Especialista en Cirugía Plástica	Especialista en Cirugía Plástica	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3823887-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673b3-6a90-11e4-bc76-f314bf0101e2	t	10224	Traductor Público Nacional de Inglés	Traductora Pública Nacional de Inglés	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3832355-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d673b4-6a90-11e4-bc76-f314bf0101e2	t	2022	Licenciado en Bioquímica Clínica / Bioquímico Clínico	Licenciada en Bioquímica Clínica / Bioquímica Clínica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f382adec-6a90-11e4-bc76-f314bf0101e2	c051501a-c32d-47ea-a578-8c82ff1f21a4
f3d673b5-6a90-11e4-bc76-f314bf0101e2	t	\N	Magister en Patrimonio Cultural Material, Administración, Conservación y Legislación	Magister en Patrimonio Cultural Material, Administración, Conservación y Legislación	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fc1-6a90-11e4-bc76-f314bf0101e2	\N
f3d673b6-6a90-11e4-bc76-f314bf0101e2	t	173	Ingeniero Electrónico	Ingeniera Electrónica	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825fa8-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673b7-6a90-11e4-bc76-f314bf0101e2	t	12510	Magister en Salud Sexual y Reproductiva	Magister en Salud Sexual y Reproductiva	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3832370-6a90-11e4-bc76-f314bf0101e2	\N
f3d673b8-6a90-11e4-bc76-f314bf0101e2	t	\N	POSTITULO DOC. EN LINGUISTICA APLICADA - ACTUAL. ACADEMICA	POSTITULO DOC. EN LINGUISTICA APLICADA - ACTUAL. ACADEMICA	\N	\N	\N	f	f383235c-6a90-11e4-bc76-f314bf0101e2	\N
f3d673b9-6a90-11e4-bc76-f314bf0101e2	t	11353	Doctor en Ciencias del Lenguaje,  Mención en Culturas y Literaturas Comparadas	Doctora en Ciencias del Lenguaje, Mención en Culturas y Literaturas Comparadas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3825fbc-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673ba-6a90-11e4-bc76-f314bf0101e2	t	4924	Ciclo Básico Común	Ciclo Básico Común	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f382adf2-6a90-11e4-bc76-f314bf0101e2	\N
f3d673bb-6a90-11e4-bc76-f314bf0101e2	t	7728	Magister en Culturas y Literaturas Comparadas	Magister en Culturas y Literaturas Comparadas	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3851f57-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673bc-6a90-11e4-bc76-f314bf0101e2	t	800	Profesor en Historia	Profesora en Historia	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	\N	\N	f	f3825fbf-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673bd-6a90-11e4-bc76-f314bf0101e2	t	4928	Licenciado en Lengua y Literatura Francesas	Licenciada en Lengua y Literatura Francesas	aaf55ad0-3218-4d7f-bfdc-abeb02afff89	64055936-85b0-4228-9231-e83fc3c760b8	\N	f	f3825f98-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673be-6a90-11e4-bc76-f314bf0101e2	t	1641	Especialista en Gastroenterología	Especialista en Gastroenterología	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f3876984-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673bf-6a90-11e4-bc76-f314bf0101e2	t	6575	Magíster en Partidos Políticos	Magíster en Partidos Políticos	c73a87b9-df21-4373-85c6-d3d8a1551994	\N	\N	f	f384f83e-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
f3d673c0-6a90-11e4-bc76-f314bf0101e2	t	6230	Técnico en Periodismo Deportivo	Técnica en Periodismo Deportivo	a089f661-c0cd-4384-85c8-72299afbcd37	\N	\N	f	f3832374-6a90-11e4-bc76-f314bf0101e2	ba0ca558-8fd9-4cb2-a48e-7be093ba1882
\.


--
-- TOC entry 2117 (class 0 OID 1260072)
-- Dependencies: 176 2123
-- Data for Name: title_mode; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY title_mode (id, state_enable, code, name, comment) FROM stdin;
64055936-85b0-4228-9231-e83fc3c760b8	t	1	Presencial	\N
746215b8-756f-4c0f-831a-4da241db161f	t	2	A Distancia	\N
\.


--
-- TOC entry 2118 (class 0 OID 1260078)
-- Dependencies: 177 2123
-- Data for Name: title_resolution; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY title_resolution (id, state_enable, title_id, resolution_id) FROM stdin;
f4381b0b-6a90-11e4-bc76-f314bf0101e2	t	f3d3db2b-6a90-11e4-bc76-f314bf0101e2	f41c0885-6a90-11e4-bc76-f314bf0101e2
f4381b0c-6a90-11e4-bc76-f314bf0101e2	t	f3d3db2d-6a90-11e4-bc76-f314bf0101e2	f41c084c-6a90-11e4-bc76-f314bf0101e2
f4381b0d-6a90-11e4-bc76-f314bf0101e2	t	f3d3db30-6a90-11e4-bc76-f314bf0101e2	f41c0851-6a90-11e4-bc76-f314bf0101e2
f4381b0e-6a90-11e4-bc76-f314bf0101e2	t	f3d40241-6a90-11e4-bc76-f314bf0101e2	f41b6c06-6a90-11e4-bc76-f314bf0101e2
f438421f-6a90-11e4-bc76-f314bf0101e2	t	f3d4024b-6a90-11e4-bc76-f314bf0101e2	f41c0871-6a90-11e4-bc76-f314bf0101e2
f4384220-6a90-11e4-bc76-f314bf0101e2	t	f3d40251-6a90-11e4-bc76-f314bf0101e2	f41c0861-6a90-11e4-bc76-f314bf0101e2
f4384221-6a90-11e4-bc76-f314bf0101e2	t	f3d40255-6a90-11e4-bc76-f314bf0101e2	f41acfc1-6a90-11e4-bc76-f314bf0101e2
f4384222-6a90-11e4-bc76-f314bf0101e2	t	f3d45080-6a90-11e4-bc76-f314bf0101e2	f41c0877-6a90-11e4-bc76-f314bf0101e2
f4384223-6a90-11e4-bc76-f314bf0101e2	t	f3d47795-6a90-11e4-bc76-f314bf0101e2	f41c0852-6a90-11e4-bc76-f314bf0101e2
f4384224-6a90-11e4-bc76-f314bf0101e2	t	f3d4779b-6a90-11e4-bc76-f314bf0101e2	f41c0854-6a90-11e4-bc76-f314bf0101e2
f4384225-6a90-11e4-bc76-f314bf0101e2	t	f3d4779b-6a90-11e4-bc76-f314bf0101e2	f41c086b-6a90-11e4-bc76-f314bf0101e2
f4384226-6a90-11e4-bc76-f314bf0101e2	t	f3d4779e-6a90-11e4-bc76-f314bf0101e2	f41c0884-6a90-11e4-bc76-f314bf0101e2
f4384227-6a90-11e4-bc76-f314bf0101e2	t	f3d477a1-6a90-11e4-bc76-f314bf0101e2	f41c0879-6a90-11e4-bc76-f314bf0101e2
f4384228-6a90-11e4-bc76-f314bf0101e2	t	f3d477a1-6a90-11e4-bc76-f314bf0101e2	f41c087b-6a90-11e4-bc76-f314bf0101e2
f4384229-6a90-11e4-bc76-f314bf0101e2	t	f3d477a3-6a90-11e4-bc76-f314bf0101e2	f41c0858-6a90-11e4-bc76-f314bf0101e2
f438422a-6a90-11e4-bc76-f314bf0101e2	t	f3d477ac-6a90-11e4-bc76-f314bf0101e2	f41b6c04-6a90-11e4-bc76-f314bf0101e2
f438422b-6a90-11e4-bc76-f314bf0101e2	t	f3d477ad-6a90-11e4-bc76-f314bf0101e2	f41c0887-6a90-11e4-bc76-f314bf0101e2
f438422c-6a90-11e4-bc76-f314bf0101e2	t	f3d477af-6a90-11e4-bc76-f314bf0101e2	f41c0865-6a90-11e4-bc76-f314bf0101e2
f438422d-6a90-11e4-bc76-f314bf0101e2	t	f3d477b6-6a90-11e4-bc76-f314bf0101e2	f41b6c09-6a90-11e4-bc76-f314bf0101e2
f438422e-6a90-11e4-bc76-f314bf0101e2	t	f3d477b8-6a90-11e4-bc76-f314bf0101e2	f41c085c-6a90-11e4-bc76-f314bf0101e2
f438422f-6a90-11e4-bc76-f314bf0101e2	t	f3d477b9-6a90-11e4-bc76-f314bf0101e2	f41b6c04-6a90-11e4-bc76-f314bf0101e2
f4384230-6a90-11e4-bc76-f314bf0101e2	t	f3d477c3-6a90-11e4-bc76-f314bf0101e2	f41c086f-6a90-11e4-bc76-f314bf0101e2
f4384231-6a90-11e4-bc76-f314bf0101e2	t	f3d49edb-6a90-11e4-bc76-f314bf0101e2	f41c087e-6a90-11e4-bc76-f314bf0101e2
f4384232-6a90-11e4-bc76-f314bf0101e2	t	f3d49ede-6a90-11e4-bc76-f314bf0101e2	f41c0859-6a90-11e4-bc76-f314bf0101e2
f4384233-6a90-11e4-bc76-f314bf0101e2	t	f3d49ee0-6a90-11e4-bc76-f314bf0101e2	f41c0870-6a90-11e4-bc76-f314bf0101e2
f4384234-6a90-11e4-bc76-f314bf0101e2	t	f3d49ee2-6a90-11e4-bc76-f314bf0101e2	f41c0853-6a90-11e4-bc76-f314bf0101e2
f4384235-6a90-11e4-bc76-f314bf0101e2	t	f3d4c5fb-6a90-11e4-bc76-f314bf0101e2	f41c0882-6a90-11e4-bc76-f314bf0101e2
f4384236-6a90-11e4-bc76-f314bf0101e2	t	f3d4c5fd-6a90-11e4-bc76-f314bf0101e2	f41c0881-6a90-11e4-bc76-f314bf0101e2
f4384237-6a90-11e4-bc76-f314bf0101e2	t	f3d4c600-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f4384238-6a90-11e4-bc76-f314bf0101e2	t	f3d4c601-6a90-11e4-bc76-f314bf0101e2	f41c087e-6a90-11e4-bc76-f314bf0101e2
f4384239-6a90-11e4-bc76-f314bf0101e2	t	f3d4c608-6a90-11e4-bc76-f314bf0101e2	f41c0871-6a90-11e4-bc76-f314bf0101e2
f438423a-6a90-11e4-bc76-f314bf0101e2	t	f3d4c612-6a90-11e4-bc76-f314bf0101e2	f41c0863-6a90-11e4-bc76-f314bf0101e2
f438423b-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed23-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f438423c-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed24-6a90-11e4-bc76-f314bf0101e2	f41c0889-6a90-11e4-bc76-f314bf0101e2
f438423d-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed27-6a90-11e4-bc76-f314bf0101e2	f41c0859-6a90-11e4-bc76-f314bf0101e2
f438423e-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed2a-6a90-11e4-bc76-f314bf0101e2	f41c0881-6a90-11e4-bc76-f314bf0101e2
f438423f-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed32-6a90-11e4-bc76-f314bf0101e2	f41c0878-6a90-11e4-bc76-f314bf0101e2
f4384240-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed35-6a90-11e4-bc76-f314bf0101e2	f41c087e-6a90-11e4-bc76-f314bf0101e2
f4384241-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed36-6a90-11e4-bc76-f314bf0101e2	f41c0871-6a90-11e4-bc76-f314bf0101e2
f4384242-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed37-6a90-11e4-bc76-f314bf0101e2	f41c0872-6a90-11e4-bc76-f314bf0101e2
f4384243-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed38-6a90-11e4-bc76-f314bf0101e2	f41c085f-6a90-11e4-bc76-f314bf0101e2
f4384244-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed3c-6a90-11e4-bc76-f314bf0101e2	f41c0852-6a90-11e4-bc76-f314bf0101e2
f4384245-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed41-6a90-11e4-bc76-f314bf0101e2	f41c0871-6a90-11e4-bc76-f314bf0101e2
f4384246-6a90-11e4-bc76-f314bf0101e2	t	f3d4ed45-6a90-11e4-bc76-f314bf0101e2	f41c087a-6a90-11e4-bc76-f314bf0101e2
f4384247-6a90-11e4-bc76-f314bf0101e2	t	f3d5145d-6a90-11e4-bc76-f314bf0101e2	f41c085c-6a90-11e4-bc76-f314bf0101e2
f4384248-6a90-11e4-bc76-f314bf0101e2	t	f3d53b6e-6a90-11e4-bc76-f314bf0101e2	f41c087a-6a90-11e4-bc76-f314bf0101e2
f4384249-6a90-11e4-bc76-f314bf0101e2	t	f3d53b6f-6a90-11e4-bc76-f314bf0101e2	f41c087d-6a90-11e4-bc76-f314bf0101e2
f438424a-6a90-11e4-bc76-f314bf0101e2	t	f3d53b71-6a90-11e4-bc76-f314bf0101e2	f41acfc1-6a90-11e4-bc76-f314bf0101e2
f438424b-6a90-11e4-bc76-f314bf0101e2	t	f3d53b78-6a90-11e4-bc76-f314bf0101e2	f41c0860-6a90-11e4-bc76-f314bf0101e2
f438424c-6a90-11e4-bc76-f314bf0101e2	t	f3d53b79-6a90-11e4-bc76-f314bf0101e2	f41b6c0b-6a90-11e4-bc76-f314bf0101e2
f438424d-6a90-11e4-bc76-f314bf0101e2	t	f3d53b7b-6a90-11e4-bc76-f314bf0101e2	f41c0875-6a90-11e4-bc76-f314bf0101e2
f438424e-6a90-11e4-bc76-f314bf0101e2	t	f3d53b80-6a90-11e4-bc76-f314bf0101e2	f41c0859-6a90-11e4-bc76-f314bf0101e2
f438424f-6a90-11e4-bc76-f314bf0101e2	t	f3d53b82-6a90-11e4-bc76-f314bf0101e2	f41c085c-6a90-11e4-bc76-f314bf0101e2
f4384250-6a90-11e4-bc76-f314bf0101e2	t	f3d53b84-6a90-11e4-bc76-f314bf0101e2	f41c0888-6a90-11e4-bc76-f314bf0101e2
f4384251-6a90-11e4-bc76-f314bf0101e2	t	f3d5afb8-6a90-11e4-bc76-f314bf0101e2	f41c084f-6a90-11e4-bc76-f314bf0101e2
f4384252-6a90-11e4-bc76-f314bf0101e2	t	f3d5afb8-6a90-11e4-bc76-f314bf0101e2	f41c0876-6a90-11e4-bc76-f314bf0101e2
f4384253-6a90-11e4-bc76-f314bf0101e2	t	f3d5afbb-6a90-11e4-bc76-f314bf0101e2	f41c087a-6a90-11e4-bc76-f314bf0101e2
f4384254-6a90-11e4-bc76-f314bf0101e2	t	f3d5afbe-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f4384255-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6d2-6a90-11e4-bc76-f314bf0101e2	f41c0859-6a90-11e4-bc76-f314bf0101e2
f4384256-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6d4-6a90-11e4-bc76-f314bf0101e2	f41c0871-6a90-11e4-bc76-f314bf0101e2
f4384257-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6d6-6a90-11e4-bc76-f314bf0101e2	f41c0878-6a90-11e4-bc76-f314bf0101e2
f4384258-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6d8-6a90-11e4-bc76-f314bf0101e2	f41c0860-6a90-11e4-bc76-f314bf0101e2
f4384259-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6d9-6a90-11e4-bc76-f314bf0101e2	f41c0863-6a90-11e4-bc76-f314bf0101e2
f438425a-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6dd-6a90-11e4-bc76-f314bf0101e2	f41b6c08-6a90-11e4-bc76-f314bf0101e2
f438425b-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6e0-6a90-11e4-bc76-f314bf0101e2	f41c086c-6a90-11e4-bc76-f314bf0101e2
f438425c-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6e3-6a90-11e4-bc76-f314bf0101e2	f41b44f3-6a90-11e4-bc76-f314bf0101e2
f438425d-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6e7-6a90-11e4-bc76-f314bf0101e2	f41c0869-6a90-11e4-bc76-f314bf0101e2
f438425e-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6e9-6a90-11e4-bc76-f314bf0101e2	f41c0880-6a90-11e4-bc76-f314bf0101e2
f438425f-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6ea-6a90-11e4-bc76-f314bf0101e2	f41c088a-6a90-11e4-bc76-f314bf0101e2
f4384260-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6eb-6a90-11e4-bc76-f314bf0101e2	f41c086a-6a90-11e4-bc76-f314bf0101e2
f4384261-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6ed-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f4384262-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6ef-6a90-11e4-bc76-f314bf0101e2	f41c085d-6a90-11e4-bc76-f314bf0101e2
f4384263-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6f0-6a90-11e4-bc76-f314bf0101e2	f41c0883-6a90-11e4-bc76-f314bf0101e2
f4384264-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6f1-6a90-11e4-bc76-f314bf0101e2	f41c0883-6a90-11e4-bc76-f314bf0101e2
f4384265-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6f2-6a90-11e4-bc76-f314bf0101e2	f41b6c05-6a90-11e4-bc76-f314bf0101e2
f4384266-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6f6-6a90-11e4-bc76-f314bf0101e2	f41c0865-6a90-11e4-bc76-f314bf0101e2
f4384267-6a90-11e4-bc76-f314bf0101e2	t	f3d5d6fb-6a90-11e4-bc76-f314bf0101e2	f41c0877-6a90-11e4-bc76-f314bf0101e2
f4384268-6a90-11e4-bc76-f314bf0101e2	t	f3d5fe11-6a90-11e4-bc76-f314bf0101e2	f41c0867-6a90-11e4-bc76-f314bf0101e2
f4384269-6a90-11e4-bc76-f314bf0101e2	t	f3d62528-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f438426a-6a90-11e4-bc76-f314bf0101e2	t	f3d62529-6a90-11e4-bc76-f314bf0101e2	f41c0869-6a90-11e4-bc76-f314bf0101e2
f438426b-6a90-11e4-bc76-f314bf0101e2	t	f3d6252a-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f438426c-6a90-11e4-bc76-f314bf0101e2	t	f3d6252d-6a90-11e4-bc76-f314bf0101e2	f41c0866-6a90-11e4-bc76-f314bf0101e2
f438426d-6a90-11e4-bc76-f314bf0101e2	t	f3d62531-6a90-11e4-bc76-f314bf0101e2	f41c086e-6a90-11e4-bc76-f314bf0101e2
f438426e-6a90-11e4-bc76-f314bf0101e2	t	f3d62535-6a90-11e4-bc76-f314bf0101e2	f41acfc1-6a90-11e4-bc76-f314bf0101e2
f438426f-6a90-11e4-bc76-f314bf0101e2	t	f3d62536-6a90-11e4-bc76-f314bf0101e2	f41c087e-6a90-11e4-bc76-f314bf0101e2
f4384270-6a90-11e4-bc76-f314bf0101e2	t	f3d62539-6a90-11e4-bc76-f314bf0101e2	f41c084d-6a90-11e4-bc76-f314bf0101e2
f4384271-6a90-11e4-bc76-f314bf0101e2	t	f3d6253b-6a90-11e4-bc76-f314bf0101e2	f41c0888-6a90-11e4-bc76-f314bf0101e2
f4384272-6a90-11e4-bc76-f314bf0101e2	t	f3d6253c-6a90-11e4-bc76-f314bf0101e2	f41b6c05-6a90-11e4-bc76-f314bf0101e2
f4384273-6a90-11e4-bc76-f314bf0101e2	t	f3d6253d-6a90-11e4-bc76-f314bf0101e2	f41c087c-6a90-11e4-bc76-f314bf0101e2
f4384274-6a90-11e4-bc76-f314bf0101e2	t	f3d6253f-6a90-11e4-bc76-f314bf0101e2	f41c0874-6a90-11e4-bc76-f314bf0101e2
f4386985-6a90-11e4-bc76-f314bf0101e2	t	f3d62541-6a90-11e4-bc76-f314bf0101e2	f41c0883-6a90-11e4-bc76-f314bf0101e2
f4386986-6a90-11e4-bc76-f314bf0101e2	t	f3d62542-6a90-11e4-bc76-f314bf0101e2	f41c0884-6a90-11e4-bc76-f314bf0101e2
f4386987-6a90-11e4-bc76-f314bf0101e2	t	f3d62545-6a90-11e4-bc76-f314bf0101e2	f41c0883-6a90-11e4-bc76-f314bf0101e2
f4386988-6a90-11e4-bc76-f314bf0101e2	t	f3d62546-6a90-11e4-bc76-f314bf0101e2	f41c087d-6a90-11e4-bc76-f314bf0101e2
f4386989-6a90-11e4-bc76-f314bf0101e2	t	f3d62547-6a90-11e4-bc76-f314bf0101e2	f41c087a-6a90-11e4-bc76-f314bf0101e2
f438698a-6a90-11e4-bc76-f314bf0101e2	t	f3d62548-6a90-11e4-bc76-f314bf0101e2	f41c0866-6a90-11e4-bc76-f314bf0101e2
f438698b-6a90-11e4-bc76-f314bf0101e2	t	f3d62549-6a90-11e4-bc76-f314bf0101e2	f41c0871-6a90-11e4-bc76-f314bf0101e2
f438698c-6a90-11e4-bc76-f314bf0101e2	t	f3d64c5b-6a90-11e4-bc76-f314bf0101e2	f41c0855-6a90-11e4-bc76-f314bf0101e2
f438698d-6a90-11e4-bc76-f314bf0101e2	t	f3d64c63-6a90-11e4-bc76-f314bf0101e2	f41c0860-6a90-11e4-bc76-f314bf0101e2
f438698e-6a90-11e4-bc76-f314bf0101e2	t	f3d64c64-6a90-11e4-bc76-f314bf0101e2	f41c0874-6a90-11e4-bc76-f314bf0101e2
f438698f-6a90-11e4-bc76-f314bf0101e2	t	f3d64c6f-6a90-11e4-bc76-f314bf0101e2	f41c0868-6a90-11e4-bc76-f314bf0101e2
f4386990-6a90-11e4-bc76-f314bf0101e2	t	f3d64c72-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f4386991-6a90-11e4-bc76-f314bf0101e2	t	f3d64c73-6a90-11e4-bc76-f314bf0101e2	f41c0861-6a90-11e4-bc76-f314bf0101e2
f4386992-6a90-11e4-bc76-f314bf0101e2	t	f3d64c74-6a90-11e4-bc76-f314bf0101e2	f41c0886-6a90-11e4-bc76-f314bf0101e2
f4386993-6a90-11e4-bc76-f314bf0101e2	t	f3d64c7a-6a90-11e4-bc76-f314bf0101e2	f41c0861-6a90-11e4-bc76-f314bf0101e2
f4386994-6a90-11e4-bc76-f314bf0101e2	t	f3d64c7f-6a90-11e4-bc76-f314bf0101e2	f41c087f-6a90-11e4-bc76-f314bf0101e2
f4386995-6a90-11e4-bc76-f314bf0101e2	t	f3d64c81-6a90-11e4-bc76-f314bf0101e2	f41c084e-6a90-11e4-bc76-f314bf0101e2
f4386996-6a90-11e4-bc76-f314bf0101e2	t	f3d64c83-6a90-11e4-bc76-f314bf0101e2	f41c087d-6a90-11e4-bc76-f314bf0101e2
f4386997-6a90-11e4-bc76-f314bf0101e2	t	f3d64c86-6a90-11e4-bc76-f314bf0101e2	f41b6c07-6a90-11e4-bc76-f314bf0101e2
f4386998-6a90-11e4-bc76-f314bf0101e2	t	f3d64c89-6a90-11e4-bc76-f314bf0101e2	f41c0860-6a90-11e4-bc76-f314bf0101e2
f4386999-6a90-11e4-bc76-f314bf0101e2	t	f3d64c8c-6a90-11e4-bc76-f314bf0101e2	f41af6d2-6a90-11e4-bc76-f314bf0101e2
f438699a-6a90-11e4-bc76-f314bf0101e2	t	f3d64c8c-6a90-11e4-bc76-f314bf0101e2	f41c086d-6a90-11e4-bc76-f314bf0101e2
f438699b-6a90-11e4-bc76-f314bf0101e2	t	f3d64c8d-6a90-11e4-bc76-f314bf0101e2	f41c0862-6a90-11e4-bc76-f314bf0101e2
f438699c-6a90-11e4-bc76-f314bf0101e2	t	f3d673a5-6a90-11e4-bc76-f314bf0101e2	f41c0854-6a90-11e4-bc76-f314bf0101e2
f438699d-6a90-11e4-bc76-f314bf0101e2	t	f3d673a5-6a90-11e4-bc76-f314bf0101e2	f41c086b-6a90-11e4-bc76-f314bf0101e2
f438699e-6a90-11e4-bc76-f314bf0101e2	t	f3d673a7-6a90-11e4-bc76-f314bf0101e2	f41c0857-6a90-11e4-bc76-f314bf0101e2
f438699f-6a90-11e4-bc76-f314bf0101e2	t	f3d673ab-6a90-11e4-bc76-f314bf0101e2	f41c087d-6a90-11e4-bc76-f314bf0101e2
f43869a0-6a90-11e4-bc76-f314bf0101e2	t	f3d673ad-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f43869a1-6a90-11e4-bc76-f314bf0101e2	t	f3d673ae-6a90-11e4-bc76-f314bf0101e2	f41c0850-6a90-11e4-bc76-f314bf0101e2
f43869a2-6a90-11e4-bc76-f314bf0101e2	t	f3d673b3-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f43869a3-6a90-11e4-bc76-f314bf0101e2	t	f3d673b6-6a90-11e4-bc76-f314bf0101e2	f41b6c0a-6a90-11e4-bc76-f314bf0101e2
f43869a4-6a90-11e4-bc76-f314bf0101e2	t	f3d673bd-6a90-11e4-bc76-f314bf0101e2	f41c0873-6a90-11e4-bc76-f314bf0101e2
f43869a5-6a90-11e4-bc76-f314bf0101e2	t	f3d673c0-6a90-11e4-bc76-f314bf0101e2	f41c085c-6a90-11e4-bc76-f314bf0101e2
\.


--
-- TOC entry 2119 (class 0 OID 1260084)
-- Dependencies: 178 2123
-- Data for Name: title_state; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY title_state (id, state_enable, code, name, comment) FROM stdin;
5686c2c1-9161-4d21-b10b-5c10fad9fc8a	t	1	Pendientes Alta	\N
8c91eadd-705f-4606-9537-885257a150f9	t	2	Pendiente Modificación	\N
ba0ca558-8fd9-4cb2-a48e-7be093ba1882	t	3	Vigente	\N
c051501a-c32d-47ea-a578-8c82ff1f21a4	t	4	No Vigente	\N
6bb98821-c0da-44f4-86a0-96093bda4433	t	5	No Vigente con Actividad	\N
\.


--
-- TOC entry 2120 (class 0 OID 1260090)
-- Dependencies: 179 2123
-- Data for Name: title_type; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY title_type (id, state_enable, code, name, career_type_id, comment) FROM stdin;
a089f661-c0cd-4384-85c8-72299afbcd37	t	1	Pregrado Final	58897c40-6dcf-47ca-af98-ed02991b0892	\N
4d47a8fd-3de5-4871-bfe1-f2f6475d9f5e	t	2	Pregrado Intermedio	a3f32ceb-a2be-4254-a3a9-466f789b262b	\N
aaf55ad0-3218-4d7f-bfdc-abeb02afff89	t	3	Grado	a3f32ceb-a2be-4254-a3a9-466f789b262b	\N
c73a87b9-df21-4373-85c6-d3d8a1551994	t	4	Posgrado	bd5cbf93-b078-4950-89ab-acaf109fac66	\N
\.


--
-- TOC entry 2121 (class 0 OID 1260096)
-- Dependencies: 180 2123
-- Data for Name: version_career; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY version_career (id, comment, career_id, url_serialized_object, user_id, user_name, name_physical_person, last_name_physical_person, code_identification_type_person, identification_type_person, identification_person, type_event_version, event_type, date_event, version_label, version) FROM stdin;
\.


--
-- TOC entry 2122 (class 0 OID 1260102)
-- Dependencies: 181 2123
-- Data for Name: version_title; Type: TABLE DATA; Schema: model; Owner: postgres
--

COPY version_title (id, comment, title_id, url_serialized_object, user_id, user_name, name_physical_person, last_name_physical_person, code_identification_type_person, identification_type_person, identification_person, type_event_version, event_type, date_event, version_label, version) FROM stdin;
\.


--
-- TOC entry 1946 (class 2606 OID 1260109)
-- Dependencies: 162 162 2124
-- Name: academic_unit_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY academic_unit
    ADD CONSTRAINT academic_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 1948 (class 2606 OID 1260111)
-- Dependencies: 163 163 2124
-- Name: agreement_title_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY agreement_title
    ADD CONSTRAINT agreement_title_pkey PRIMARY KEY (id);


--
-- TOC entry 1950 (class 2606 OID 1260113)
-- Dependencies: 164 164 2124
-- Name: au_type_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY au_type
    ADD CONSTRAINT au_type_pkey PRIMARY KEY (id);


--
-- TOC entry 1952 (class 2606 OID 1260115)
-- Dependencies: 165 165 2124
-- Name: career_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY career
    ADD CONSTRAINT career_pkey PRIMARY KEY (id);


--
-- TOC entry 1954 (class 2606 OID 1260117)
-- Dependencies: 166 166 2124
-- Name: career_state_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY career_state
    ADD CONSTRAINT career_state_pkey PRIMARY KEY (id);


--
-- TOC entry 1956 (class 2606 OID 1260119)
-- Dependencies: 167 167 2124
-- Name: career_type_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY career_type
    ADD CONSTRAINT career_type_pkey PRIMARY KEY (id);


--
-- TOC entry 1958 (class 2606 OID 1260121)
-- Dependencies: 168 168 2124
-- Name: edu_institution_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY edu_institution
    ADD CONSTRAINT edu_institution_pkey PRIMARY KEY (id);


--
-- TOC entry 1960 (class 2606 OID 1260123)
-- Dependencies: 173 173 2124
-- Name: resolution_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resolution
    ADD CONSTRAINT resolution_pkey PRIMARY KEY (id);


--
-- TOC entry 1962 (class 2606 OID 1260125)
-- Dependencies: 174 174 2124
-- Name: resolution_type_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resolution_type
    ADD CONSTRAINT resolution_type_pkey PRIMARY KEY (id);


--
-- TOC entry 1966 (class 2606 OID 1260127)
-- Dependencies: 176 176 2124
-- Name: title_mode_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY title_mode
    ADD CONSTRAINT title_mode_pkey PRIMARY KEY (id);


--
-- TOC entry 1964 (class 2606 OID 1260129)
-- Dependencies: 175 175 2124
-- Name: title_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY title
    ADD CONSTRAINT title_pkey PRIMARY KEY (id);


--
-- TOC entry 1968 (class 2606 OID 1260131)
-- Dependencies: 177 177 2124
-- Name: title_resolution_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY title_resolution
    ADD CONSTRAINT title_resolution_pkey PRIMARY KEY (id);


--
-- TOC entry 1970 (class 2606 OID 1260133)
-- Dependencies: 178 178 2124
-- Name: title_state_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY title_state
    ADD CONSTRAINT title_state_pkey PRIMARY KEY (id);


--
-- TOC entry 1972 (class 2606 OID 1260135)
-- Dependencies: 179 179 2124
-- Name: title_type_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY title_type
    ADD CONSTRAINT title_type_pkey PRIMARY KEY (id);


--
-- TOC entry 1974 (class 2606 OID 1260137)
-- Dependencies: 180 180 2124
-- Name: version_career_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY version_career
    ADD CONSTRAINT version_career_pkey PRIMARY KEY (id);


--
-- TOC entry 1976 (class 2606 OID 1260139)
-- Dependencies: 181 181 2124
-- Name: version_title_pkey; Type: CONSTRAINT; Schema: model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY version_title
    ADD CONSTRAINT version_title_pkey PRIMARY KEY (id);


--
-- TOC entry 1977 (class 2606 OID 1260140)
-- Dependencies: 162 1945 162 2124
-- Name: academic_unit_academic_unit_parent_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY academic_unit
    ADD CONSTRAINT academic_unit_academic_unit_parent_id_fkey FOREIGN KEY (academic_unit_parent_id) REFERENCES academic_unit(id);


--
-- TOC entry 1978 (class 2606 OID 1260145)
-- Dependencies: 162 164 1949 2124
-- Name: academic_unit_au_type_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY academic_unit
    ADD CONSTRAINT academic_unit_au_type_id_fkey FOREIGN KEY (au_type_id) REFERENCES au_type(id);


--
-- TOC entry 1979 (class 2606 OID 1260150)
-- Dependencies: 162 168 1957 2124
-- Name: academic_unit_edu_institution_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY academic_unit
    ADD CONSTRAINT academic_unit_edu_institution_id_fkey FOREIGN KEY (edu_institution_id) REFERENCES edu_institution(id);


--
-- TOC entry 1980 (class 2606 OID 1260155)
-- Dependencies: 163 1945 162 2124
-- Name: agreement_title_academic_unit_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY agreement_title
    ADD CONSTRAINT agreement_title_academic_unit_id_fkey FOREIGN KEY (academic_unit_id) REFERENCES academic_unit(id);


--
-- TOC entry 1981 (class 2606 OID 1260160)
-- Dependencies: 168 163 1957 2124
-- Name: agreement_title_edu_institution_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY agreement_title
    ADD CONSTRAINT agreement_title_edu_institution_id_fkey FOREIGN KEY (edu_institution_id) REFERENCES edu_institution(id);


--
-- TOC entry 1982 (class 2606 OID 1260165)
-- Dependencies: 1963 163 175 2124
-- Name: agreement_title_title_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY agreement_title
    ADD CONSTRAINT agreement_title_title_id_fkey FOREIGN KEY (title_id) REFERENCES title(id);


--
-- TOC entry 1983 (class 2606 OID 1260170)
-- Dependencies: 165 1945 162 2124
-- Name: career_academic_unit_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY career
    ADD CONSTRAINT career_academic_unit_id_fkey FOREIGN KEY (academic_unit_id) REFERENCES academic_unit(id);


--
-- TOC entry 1984 (class 2606 OID 1260175)
-- Dependencies: 1953 165 166 2124
-- Name: career_career_state_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY career
    ADD CONSTRAINT career_career_state_id_fkey FOREIGN KEY (career_state_id) REFERENCES career_state(id);


--
-- TOC entry 1985 (class 2606 OID 1260180)
-- Dependencies: 167 1955 165 2124
-- Name: career_career_type_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY career
    ADD CONSTRAINT career_career_type_id_fkey FOREIGN KEY (career_type_id) REFERENCES career_type(id);


--
-- TOC entry 1986 (class 2606 OID 1260185)
-- Dependencies: 168 1957 165 2124
-- Name: career_edu_institution_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY career
    ADD CONSTRAINT career_edu_institution_id_fkey FOREIGN KEY (edu_institution_id) REFERENCES edu_institution(id);


--
-- TOC entry 1987 (class 2606 OID 1260190)
-- Dependencies: 173 1961 174 2124
-- Name: resolution_type_resolution_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY resolution
    ADD CONSTRAINT resolution_type_resolution_id_fkey FOREIGN KEY (type_resolution_id) REFERENCES resolution_type(id);


--
-- TOC entry 1988 (class 2606 OID 1260195)
-- Dependencies: 165 175 1951 2124
-- Name: title_career_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title
    ADD CONSTRAINT title_career_id_fkey FOREIGN KEY (career_id) REFERENCES career(id);


--
-- TOC entry 1992 (class 2606 OID 1260200)
-- Dependencies: 1959 173 177 2124
-- Name: title_resolution_resolution_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title_resolution
    ADD CONSTRAINT title_resolution_resolution_id_fkey FOREIGN KEY (resolution_id) REFERENCES resolution(id);


--
-- TOC entry 1993 (class 2606 OID 1260205)
-- Dependencies: 1963 177 175 2124
-- Name: title_resolution_title_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title_resolution
    ADD CONSTRAINT title_resolution_title_id_fkey FOREIGN KEY (title_id) REFERENCES title(id);


--
-- TOC entry 1989 (class 2606 OID 1260210)
-- Dependencies: 175 176 1965 2124
-- Name: title_title_mode_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title
    ADD CONSTRAINT title_title_mode_id_fkey FOREIGN KEY (title_mode_id) REFERENCES title_mode(id);


--
-- TOC entry 1990 (class 2606 OID 1260215)
-- Dependencies: 178 1969 175 2124
-- Name: title_title_state_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title
    ADD CONSTRAINT title_title_state_id_fkey FOREIGN KEY (title_state_id) REFERENCES title_state(id);


--
-- TOC entry 1991 (class 2606 OID 1260220)
-- Dependencies: 179 1971 175 2124
-- Name: title_title_type_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title
    ADD CONSTRAINT title_title_type_id_fkey FOREIGN KEY (title_type_id) REFERENCES title_type(id);


--
-- TOC entry 1994 (class 2606 OID 1260225)
-- Dependencies: 179 167 1955 2124
-- Name: title_type_career_type_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY title_type
    ADD CONSTRAINT title_type_career_type_id_fkey FOREIGN KEY (career_type_id) REFERENCES career_type(id);


--
-- TOC entry 1995 (class 2606 OID 1260230)
-- Dependencies: 165 180 1951 2124
-- Name: version_career_career_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY version_career
    ADD CONSTRAINT version_career_career_id_fkey FOREIGN KEY (career_id) REFERENCES career(id);


--
-- TOC entry 1996 (class 2606 OID 1260235)
-- Dependencies: 1963 181 175 2124
-- Name: version_title_title_id_fkey; Type: FK CONSTRAINT; Schema: model; Owner: postgres
--

ALTER TABLE ONLY version_title
    ADD CONSTRAINT version_title_title_id_fkey FOREIGN KEY (title_id) REFERENCES title(id);


-- Completed on 2015-07-30 00:55:23 ART

--
-- PostgreSQL database dump complete
--

