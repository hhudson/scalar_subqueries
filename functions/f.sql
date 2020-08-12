CREATE OR REPLACE FUNCTION f (
    x IN VARCHAR2
) RETURN NUMBER AS
BEGIN
    dbms_application_info.set_client_info(userenv('client_info') + 1);
    RETURN length(x);
END;
