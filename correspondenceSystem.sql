CREATE TABLE "adjuntos" (
  "id_adjuntos" serial8,
  "adjunto" bytea,
  "id_derivación" serial8,
  PRIMARY KEY ("id_adjuntos")
);

CREATE TABLE "asignaciones" (
  "id_asignación" serial8,
  "idcarnet" varchar(10),
  "id_derivación" serial8,
  PRIMARY KEY ("id_asignación")
);

CREATE TABLE "cargos" (
  "id_cargo" int4 NOT NULL,
  "cargo_nombre" varchar(100),
  "idcarnet" varchar(10) NOT NULL,
  PRIMARY KEY ("id_cargo")
);

CREATE TABLE "dependencias" (
  "id_dependencia" serial4,
  "nombre" varchar(50),
  PRIMARY KEY ("id_dependencia")
);

CREATE TABLE "derivaciones" (
  "id_derivación" serial8,
  "idcarnet" varchar(10),
  "reg_fojas" int4,
  "instrucción" varchar(255),
  "observación" varchar(255),
  "fecha_recepción" timestamp,
  "fecha_derivación" timestamp,
  "estado" jsonb,
  "id_hr" serial8,
  PRIMARY KEY ("id_derivación")
);

CREATE TABLE "hojas de ruta" (
  "id_hr" serial8,
  "numero_registro" varchar(100) NOT NULL,
  "proc_ext" varchar(100),
  "fecha_reg" timestamp,
  "fecha_ingreso" date,
  "fecha_salida " date,
  "reg_cite" varchar(100),
  "reg_docAdj" varchar(255),
  "reg_referencia" varchar(500) NOT NULL,
  "estado" jsonb,
  "tipo" json,
  "proveido_guia" jsonb,
  "cod_qr" bytea,
  "idcarnet" varchar(10),
  PRIMARY KEY ("id_hr")
);
COMMENT ON COLUMN "hojas de ruta"."proc_ext" IS 'Procedencia externa';
COMMENT ON COLUMN "hojas de ruta"."fecha_reg" IS 'Fecha de registro';
COMMENT ON COLUMN "hojas de ruta"."reg_docAdj" IS 'Documentos adjuntos';

CREATE TABLE "roles" (
  "id_rol" serial4,
  "nombre" varchar(100),
  "estado" varchar(100),
  PRIMARY KEY ("id_rol")
);

CREATE TABLE "usuarios" (
  "idcarnet" varchar(10) NOT NULL,
  "expedido" varchar(20),
  "nombres" varchar(100),
  "appaterno" varchar(100),
  "apmaterno" varchar(100),
  "usuario" varchar(50),
  "clave" varchar(500),
  "permisos" jsonb,
  "theme" varchar(50),
  "estado" varchar(50),
  "editar" bool,
  "id_dependencia" serial4,
  "id_rol" serial4,
  PRIMARY KEY ("idcarnet")
);

ALTER TABLE "adjuntos" ADD CONSTRAINT "id_derivación" FOREIGN KEY ("id_derivación") REFERENCES "derivaciones" ("id_derivación") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "asignaciones" ADD CONSTRAINT "idcarnet" FOREIGN KEY ("idcarnet") REFERENCES "usuarios" ("idcarnet") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "asignaciones" ADD CONSTRAINT "id_derivación" FOREIGN KEY ("id_derivación") REFERENCES "derivaciones" ("id_derivación") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "cargos" ADD CONSTRAINT "idcarnet" FOREIGN KEY ("idcarnet") REFERENCES "usuarios" ("idcarnet") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "derivaciones" ADD CONSTRAINT "id_hr" FOREIGN KEY ("id_hr") REFERENCES "hojas de ruta" ("id_hr") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "derivaciones" ADD CONSTRAINT "idcarnet" FOREIGN KEY ("idcarnet") REFERENCES "usuarios" ("idcarnet") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "hojas de ruta" ADD CONSTRAINT "idcarnet" FOREIGN KEY ("idcarnet") REFERENCES "usuarios" ("idcarnet") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "usuarios" ADD CONSTRAINT "id_dependencia" FOREIGN KEY ("id_dependencia") REFERENCES "dependencias" ("id_dependencia") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "usuarios" ADD CONSTRAINT "id_rol" FOREIGN KEY ("id_rol") REFERENCES "roles" ("id_rol") ON DELETE CASCADE ON UPDATE CASCADE;

