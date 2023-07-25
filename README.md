# Snowflake におけるデータエンジニアリング、機械学習、アプリケーション開発ハンズオン
Snowpark と Streamlit を利用した Snowflake によるデータエンジニアリング、機械学習およびアプリケーション開発ハンズオン（HOL）用アセットです。
Quickstart [Getting Started with Data Engineering and ML using Snowpark for Python](https://quickstarts.snowflake.com/guide/getting_started_with_dataengineering_ml_using_snowpark_python/index.html) にインスピレーションを受けて制作されていますが、なるべくローカル環境に依存せずクラウドで展開されるサービスを利用することで誰もがとっつきやすいように意識してアレンジを加えています。

## HOL 想定ユーザ
- データエンジニア
- データサイエンティスト
- 機械学習エンジニア
- アプリケーション開発者
- Snowflake が好きな/興味のあるみなさま

## 必要な環境
- Snowflake
  - アプリケーション開発で基盤として使用します
  - Streamlit in Snowflake（SiS）利用を前提とします
  - SiS が利用できない場合 Streamlit をローカルで起動する必要があります。その場合のコードは[こちら](https://github.com/Snowflake-Labs/sfguide-getting-started-dataengineering-ml-snowpark-python/blob/main/Snowpark_Streamlit_Revenue_Prediction.py)を参照してください
- SageMaker Studio
  - データエンジニアリングおよび機械学習のための Notebook 実行環境として使用します
  - SageMaker Studio の準備などはカバーしません
  - ローカルの Notebook 環境でも OK ですが、設定方法はカバーしません

## 実行手順
1. SageMaker Studio の Terminal から `git clone https://github.com/tmasuo/snowflake-hol-snowpark-de-ml-app` でこのリポジトリの内容を取得
2. Snowflake で `setup_admin.sql` を実行してウェアハウス、DB、スキーマおよびデータを準備
3. SageMaker Studio で `connection.json` を編集
4. SageMaker Studio で `Snowpark_For_Python_DE.ipynb` を実行
5. SageMaker Studio で `Snowpark_For_Python_ML.ipynb` を実行
6. Snowflake で Streamlit アプリを作成し、`Snowpark_Streamlit_Revenue_Prediction_SiS.py` をコピペして実行

### 注意点
- 予め[利用許諾への合意](https://docs.snowflake.com/ja/developer-guide/udf/python/udf-python-packages#getting-started)を済ませてください
- `Snowpark_For_Python_DE.ipynb` のタスク実行には `EXECUTE TASK` 権限が必要なので、Accountadmin で実行するなりカスタムロールで対応してください
- SiS で利用するウェアハウス、DB、Schema はセットアップで作成したものを使用してください
- 複数人で実行する場合、ハンズオンのガイドや環境を準備する人が `setup_admin.sql` を実行して共用のウェアハウス、DB を準備して参加者に利用させることができます
  - 参加者は `setup.sql` を実行して自身のスキーマを作成し、その中で作業してゆきます
  - `connections.json` も忘れずに適切な値に編集してください

## Bucket List
- Zenn で解説記事を書く
- Python Worksheet での実行（全部 Snowflake で完結）
