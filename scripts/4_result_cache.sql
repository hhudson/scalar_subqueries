CREATE OR REPLACE FUNCTION f (
    x IN VARCHAR2
) RETURN NUMBER
    AUTHID definer
    RESULT_CACHE
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

DECLARE
    TYPE stage IS RECORD ( own         VARCHAR2(100),
    len         NUMBER );
    TYPE stage_t IS
        TABLE OF stage;
    l_stage_t   stage_t := stage_t ();
BEGIN
    SELECT
        owner,
        f(owner)
    BULK COLLECT
    INTO l_stage_t
    FROM
        all_objects;

    dbms_output.put_line(l_stage_t.count);
END;
/

SELECT
    dbms_utility.get_cpu_time -:cpu cpu_hsecs,
    userenv('client_info')
FROM
    dual;
--292	2
