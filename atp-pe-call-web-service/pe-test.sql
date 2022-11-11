-- Create an Access Control List for the host
BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
         host => 'reqres.in',
         ace =>  xs$ace_type(privilege_list => xs$name_list('http'),
                             principal_name => 'ADMIN',
                             principal_type => xs_acl.ptype_db));
END;
/
-- Set Oracle Wallet location (no arguments needed)
BEGIN
   UTL_HTTP.SET_WALLET('');
END;
/
-- Submit an HTTP request
SELECT UTL_HTTP.REQUEST(url => 'https://reqres.in/api/users?page=2 ') FROM dual;

SELECT j.*
FROM dual, 
JSON_TABLE(
(SELECT UTL_HTTP.REQUEST(url => 'https://reqres.in/api/users?page=2') FROM dual),
    '$.data[*]'
    NULL ON ERROR 
    COLUMNS(
        id VARCHAR2(100) PATH '$.id',
        email VARCHAR2(255) PATH '$.email',
        first_name VARCHAR2(255) PATH '$.first_name',
        last_name VARCHAR2(255) PATH '$.last_name',
        avatar VARCHAR2(1024) PATH '$.avatar'
    )
) j

select DBMS_RANDOM.string('L',TRUNC(DBMS_RANDOM.value(10,100))) from dual


DECLARE
  resp DBMS_CLOUD_TYPES.resp;
BEGIN
  -- Send request
  dbms_output.put_line('Send Request');
  resp := DBMS_CLOUD.send_request(
            uri => 'https://reqres.in/api/users?page=2',
            method => DBMS_CLOUD.METHOD_GET,
            headers => JSON_OBJECT('opc-request-id' value 'list-compartments')
          );
  dbms_output.put_line('Body: ' || '------------' || CHR(10) || DBMS_CLOUD.get_response_text(resp) || CHR(10));
  dbms_output.put_line('Headers: ' || CHR(10) || '------------' || CHR(10) || DBMS_CLOUD.get_response_headers(resp).to_clob || CHR(10));
  dbms_output.put_line('Status Code: ' || CHR(10) || '------------' || CHR(10) || DBMS_CLOUD.get_response_status_code(resp));
  dbms_output.put_line(CHR(10));
END;
/