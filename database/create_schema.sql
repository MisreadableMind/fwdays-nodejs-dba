-- this is database ROLE for back-end services

CREATE SEQUENCE db_schema_log_id START WITH 1;

CREATE TABLE db_schema_log
(
    id             BIGINT    NOT NULL DEFAULT nextval('db_schema_log_id'),
    execution_time TIMESTAMP NOT NULL DEFAULT current_timestamp,
    name           VARCHAR   NOT NULL,
    PRIMARY KEY (id)
);

ALTER SEQUENCE db_schema_log_id OWNED BY db_schema_log.id;

INSERT INTO db_schema_log (name)
VALUES ('create_schema.sql');

COMMIT;

-- COMMON FUNCTIONS
CREATE FUNCTION tg_timing_rows_handler()
    RETURNS TRIGGER AS
$$
BEGIN
    IF (OLD IS NULL) THEN
        BEGIN
            NEW.created_at = current_timestamp;
            NEW.updated_at = NULL;
        END;
    ELSE
        NEW.created_at = OLD.created_at;
        NEW.updated_at = current_timestamp;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
