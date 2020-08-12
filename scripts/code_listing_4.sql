CREATE OR REPLACE FUNCTION f (
    x IN VARCHAR2
) RETURN NUMBER authid definer
    DETERMINISTIC
AS
BEGIN
    dbms_application_info.set_client_info(userenv('client_info') + 1);
    RETURN length(x);
END;
/

BEGIN
    :cpu := dbms_utility.get_cpu_time;
    dbms_application_info.set_client_info(0);
END;
/

SELECT
    owner,
    f(owner)
FROM
    all_objects;
/

SELECT
    dbms_utility.get_cpu_time -:cpu cpu_hsecs,
    userenv('client_info')
FROM
    dual;
--267	2
