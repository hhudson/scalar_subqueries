BEGIN
    :cpu := dbms_utility.get_cpu_time;
    dbms_application_info.set_client_info(0);
END;
/
SELECT
    owner,
    (
        SELECT
            f(owner)
        FROM
            dual
    ) f
FROM
    all_objects;
/

SELECT
    dbms_utility.get_cpu_time -:cpu cpu_hsecs,
    userenv('client_info')
FROM
    dual;
--836	52
