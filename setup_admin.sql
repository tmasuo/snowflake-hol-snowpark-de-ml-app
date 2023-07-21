-- 管理者用 Setup SQL

-- Sysadmin で操作をします
USE ROLE SYSADMIN;

-- 最初の管理者のみ Warehouse/Database を作成して共有します
CREATE OR REPLACE WAREHOUSE SHARED_HOL_WH; -- 共有するため MCW してもいいが Edition 次第。ある程度のグループで共有するようにするなどロジに応じて検討する
CREATE OR REPLACE DATABASE SHARED_HOL_DB;

-- ユーザごとに Schema を作成します
-- メールアドレスなどからユーザを一意に特定する ID を作成
-- .(ドット)を_(アンダースコア)などに変換してください
-- e.g. JOHN.DOE -> JOHN_DOE
SET USER_ID = '**FIXME**'; -- FIXME 
SET SCHEMA_NAME = CONCAT($USER_ID, '_HOL_SCHEMA');
CREATE OR REPLACE SCHEMA IDENTIFIER($SCHEMA_NAME);

-- コンテクストの指定
USE WAREHOUSE SHARED_HOL_WH;
USE DATABASE SHARED_HOL_DB;
USE SCHEMA IDENTIFIER($SCHEMA_NAME);

-- CAMPAIGN_SPEND テーブルを作成してデータをロード
CREATE or REPLACE file format csvformat
  skip_header = 1
  type = 'CSV';

CREATE or REPLACE stage campaign_data_stage
  file_format = csvformat
  url = 's3://sfquickstarts/ad-spend-roi-snowpark-python-scikit-learn-streamlit/campaign_spend/';

CREATE or REPLACE TABLE CAMPAIGN_SPEND (
  CAMPAIGN VARCHAR(60), 
  CHANNEL VARCHAR(60),
  DATE DATE,
  TOTAL_CLICKS NUMBER(38,0),
  TOTAL_COST NUMBER(38,0),
  ADS_SERVED NUMBER(38,0)
);

COPY into CAMPAIGN_SPEND
  from @campaign_data_stage;

-- MONTHLY_REVENUE テーブルを作成してデータをロード
CREATE or REPLACE stage monthly_revenue_data_stage
  file_format = csvformat
  url = 's3://sfquickstarts/ad-spend-roi-snowpark-python-scikit-learn-streamlit/monthly_revenue/';

CREATE or REPLACE TABLE MONTHLY_REVENUE (
  YEAR NUMBER(38,0),
  MONTH NUMBER(38,0),
  REVENUE FLOAT
);

COPY into MONTHLY_REVENUE
  from @monthly_revenue_data_stage;

-- BUDGET_ALLOCATIONS_AND_ROI テーブルを作成してデータをロード
CREATE or REPLACE TABLE BUDGET_ALLOCATIONS_AND_ROI (
  MONTH varchar(30),
  SEARCHENGINE integer,
  SOCIALMEDIA integer,
  VIDEO integer,
  EMAIL integer,
  ROI float
);

INSERT INTO BUDGET_ALLOCATIONS_AND_ROI (MONTH, SEARCHENGINE, SOCIALMEDIA, VIDEO, EMAIL, ROI)
VALUES
('January',35,50,35,85,8.22),
('February',75,50,35,85,13.90),
('March',15,50,35,15,7.34),
('April',25,80,40,90,13.23),
('May',95,95,10,95,6.246),
('June',35,50,35,85,8.22);

-- Stored Procedures, UDFs, モデルを配置するためのステージを作成
CREATE OR REPLACE STAGE sprocs;
CREATE OR REPLACE STAGE models;
CREATE OR REPLACE STAGE udfs;

-- ここまで。以下は環境削除用
-- DROP WAREHOUSE SHARED_HOL_WH;
-- DROP DATABASE SHARED_HOL_DB;