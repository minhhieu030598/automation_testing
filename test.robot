*** Settings ***
Library           DatabaseLibrary
Library           String
Library           SeleniumLibrary
Library           RequestsLibrary


*** Variables ***
${KPI_URL}   https://vtp-control-tower-dev.web.app/#/report/kpi-toan-trinh
${BROWSER}   Chrome
${order_code_query}  //input[@placeholder="Nhập đơn hàng để tìm kiếm"]
${created_at_from_query}  //input[@placeholder="Ngày bắt đầu"]
${created_at_to_query}  //input[@placeholder="Ngày kết thúc"]


*** Test Cases ***
Create Order
    CONNECT ORACLE
    #generate random id phieu gui
    ${idPhieuGui}=    Generate random string    4    0123456789
    log to console  \nid phieu gui = ${idPhieuGui}
    Execute Sql String  INSERT INTO DEBEZIUM.PHIEU_GUI (ID_PHIEUGUI, MA_PHIEUGUI, GUI_TRONGNUOC, MA_KHGUI, TEN_KHGUI, DIACHI_KHGUI, TEL_KHGUI, MA_BUUCUC_GOC, TEN_KHNHAN, DIACHI_KHNHAN, TEL_KHNHAN, MA_BUUCUC_PHAT, MA_VUNG_PHAT, MA_DV_VIETTEL, MA_DV_KETNOI, NOI_DUNG, NGAY_GUI_BP, TONG_TIEN, MA_NT, TY_GIA, DA_THANH_TOAN, NGAY_NHAP_MAY, NGUOI_NHAP_MAY, PHU_PHI, PHU_PHI_COMMENT, TONG_TIEN_NGUYEN_TE, TONG_VAT, THUE_SUAT_VAT, MA_PHIEU_KETNOI, TONG_CUOC_VND, TRANGTHAI_CONGNO, MA_LOAI_HANGHOA, MA_KIEU_THANHTOAN, MA_KHNHAN, DV_CONNECT, PHUPHI_XANGDAU, PHUPHI_KHAC, GIA_GOC, GIA_DIEUCHINH, LAN_DIEUCHINH, NGUOI_DIEUCHINH, NGAY_DIEUCHINH, PHI_DV_DACBIET, MANUAL, TRONG_LUONG, DIEUCHINHGIA, HANH_TRINH, KHOASO_DT, MA_TUYENBUUTA, ID_QUANHUYEN, ID_LOCATION, MA_TUYEN_QP, MA_QUANHUYEN, ID_PHUONGXA1111, ID_PHUONGXA, TEN_TUYEN, ID_TUYEN, MA_PHUONGXA, KHAI_GIA, THU_HO, VTP_ID, MA_KH_VTP, ID_BUUCUC, ID_KHACHHANG, ID_SHOP, ID_DOITAC, ID_NGUON, LOAI_PG, KPI_TG_QD, ORDER_ID, ORDER_NUM, TL_THUC, QD_DAI, QD_RONG, QD_CAO, TL_QUYDOI, ID_STREET, STREET_NAME, HOME_NO) VALUES (${idPhieuGui}, '${idPhieuGui}', 1, '812091', 'Bùi Nhài', 'Số 2 Đ.Chợ Gạo, P.Hàng Buồm, Q.Hoàn Kiếm, TP.Hà Nội', '0378098938', '81209', 'Trang Trịnh', '154, Đ.Cộng Hoà, PHƯỜNG 12, QUẬN TÂN BÌNH, THÀNH PHỐ HỒ CHÍ MINH', '0985909488', 'HBHCTB', 'HCM', 'VHT', '-1', 'FĐFDSFGS', TO_DATE('2022-01-19 15:10:59', 'YYYY-MM-DD HH24:MI:SS'), 211151.0000, 'VN', 1.0000, 0, TO_DATE('2022-01-19 15:10:59', 'YYYY-MM-DD HH24:MI:SS'), 812907, 0.0000, null, 115455.0000, 19196.0000, 10.0000, null, 115455.0000, 0, 'HH', 'HD', null, 0, 0.0000, 0.0000, 0.0000, 0.0000, 0, null, null, 76500.0000, 0, 1000.0000, 0.0000, null, 1, 0, 492, null, null, null, null, 8563, '273852,7360,736008,SỐ TUYẾN CÙNG PHƯỜNG XÃ: 21,PHƯỜNG 12,QUẬN TÂN BÌNH,HUBTAB', null, null, 0.0000, 20000000.0000, 0, 'VTP1298047', 5500, 0, 0, 0, 0, 0, null, 0, '0', 1000, 0, 0, 0, 0, 'ST49268', 'Đ.Cộng Hoà', '154')
    check if exists in database  select * from DEBEZIUM.PHIEU_GUI where ID_PHIEUGUI = ${idPhieuGui}
    Execute Sql String  INSERT INTO DEBEZIUM.VC_PHIEUGUI (ID_PHIEUGUI, MA_PHIEUGUI, ID_PHIEUGUI_CHA, MA_PHIEUGUI_CHA, MA_BUUCUC_GOC, MA_BUUCUC_PHAT, MA_DV_VIETTEL, TRONG_LUONG, TONG_TIEN, GHI_CHU, NGAY_NHAP_MAY, NGUOI_NHAP_MAY, BC_NHAP_MAY, DONG_BO, SO_KIEN, NGAY_GUI_BP, MA_VUNG_PHAT, PG_CON, SYNC_STATUS, ID_QUANHUYEN, ID_PHUONGXA, MA_LOAI_HANGHOA, ID_STREET, STREET_NAME, HOME_NO) VALUES (${idPhieuGui}, '${idPhieuGui}', null, null, 'PCLKD', 'HBAGCP', 'ABC', 801, 59510, 'Quà tết gồm: 01 Thư chúc tết, 01 Nội san, 20 Phong bao lì xì, 1.000.000 Tiền mặt, 01 túi đựng', TO_DATE('2022-01-18 16:08:59', 'YYYY-MM-DD HH24:MI:SS'), 208458, 'PCLKD', 1, 1, TO_DATE('2022-01-18 16:08:59', 'YYYY-MM-DD HH24:MI:SS'), 'AGG', 0, 0, 596, 614, 'HH', null, null, null)
    disconnect from database
    Sleep  2s
    CONNECT POSTGRESQL
    check if exists in database  select id,code from "order" where id =${idPhieuGui}
    [Teardown]    disconnect from database

Check Order
    CONNECT POSTGRESQL
    ${order_code}=  set variable  VTP1650526122156
    ${queryResults}  Query  select * from "order" where code = '${order_code}' limit 1  returnAsDict=true
    log to console   ${queryResults[0]['kpi_duration'].getHours()}
    Open Browser    ${KPI_URL}   ${BROWSER}  options=add_argument("--start-maximized")
    Wait Until Element Is Visible  ${order_code_query}
    Input Text      ${created_at_from_query}   2022-05-01
    Input Text      ${created_at_to_query}   2022-05-30
    Input Text      ${order_code_query}   ${order_code}
    Sleep  1.5s
    ${order_code_cell}=  Get Text  //table[@class="table-fixed"]/tr[2]/td[1]
    Should Be Equal  ${order_code_cell}  ${order_code}
    ${service_code_cell}=  Get Text  //table[@class="table-fixed"]/tr[2]/td[3]
    Should Be Equal  ${service_code_cell}  ${queryResults[0]}[service_code]
    ${kpi_duration_cell}=  Get Text  //table[@class="table-fixed"]/tr[2]/td[16]
    Should Be Equal  ${kpi_duration_cell}  ${queryResults[0]['kpi_duration'].getHours()} giờ ${queryResults[0]['kpi_duration'].getMinutes()} phút
    ${kpi_result_cell}=  Get Text  //table[@class="table-fixed"]/tr[2]/td[19]
    IF    '${kpi_result_cell}' == 'Đạt'
        should be equal    PASS  ${queryResults[0]}[kpi_result]
    ELSE IF  '${kpi_result_cell}' == 'Không đạt'
        should be equal    FAIL  ${queryResults[0]}[kpi_result]
    ELSE IF   '${kpi_result_cell}' == 'N/A'
        should be equal    NA  ${queryResults[0]}[kpi_result]
    END
    [Teardown]    Close All Browsers

Get Order API
    ${response}=    GET   http://54.255.207.175:8071/hermes-core/v1/orders  params=page=0&size=150&createdAtFrom=2022-04-30T03:52:44.600Z&createdAtTo=2022-05-31T03:52:44.600Z&code=VTP1650526122156  expected_status=200
    log to console   ${response}
    Should Be Equal As Strings    VTP1650526122156  ${response.json()}[data][0][code]
    Should Be Equal As Strings    FAST_DELIVERY  ${response.json()}[data][0][serviceType]

*** Keywords ***
CONNECT POSTGRESQL
    Connect To Database Using Custom Params  jaydebeapi  'org.postgresql.Driver', 'jdbc:postgresql://drapiadb-instance-1.cql1rashcqjj.ap-southeast-1.rds.amazonaws.com:51032/hermesdb', ['vtp', 'vtpKuGKU7TdI'], ['./lib/ojdbc8.jar', './lib/postgresql-42.3.6.jar']
    ${DatabaseLibrary}    Get library instance    DatabaseLibrary
    Evaluate    $DatabaseLibrary._dbconnection.jconn.setAutoCommit(False)
CONNECT ORACLE
    Connect To Database Using Custom Params  jaydebeapi  'oracle.jdbc.driver.OracleDriver', 'jdbc:oracle:thin:@159.223.81.203:1522:XE', ['DEBEZIUM', 'dbz'], ['./lib/ojdbc8.jar', './lib/postgresql-42.3.6.jar']
    ${DatabaseLibrary}    Get library instance    DatabaseLibrary
    Evaluate    $DatabaseLibrary._dbconnection.jconn.setAutoCommit(False)