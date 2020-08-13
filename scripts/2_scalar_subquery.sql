BEGIN
    :cpu := dbms_utility.get_cpu_time;
    dbms_application_info.set_client_info(0);
END;
/

SET SERVEROUTPUT ON

DECLARE
    TYPE stage IS RECORD ( own         VARCHAR2(100),
    len         NUMBER );
    TYPE stage_t IS
        TABLE OF stage;
    l_stage_t   stage_t := stage_t ();
BEGIN
    SELECT
        owner,
        (--used scalar subquery to dramatically increase performance
            SELECT
                f(owner)
            FROM
                dual
        ) f
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
--836	52
