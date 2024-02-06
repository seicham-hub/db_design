## ディレクトリ構成

doc/schema DB の ER 図が保存されています  
query_tuning_exercises 　クエリチューニングの練習  
sql_exercises いろいろな SQL 文の練習  
payrollCulculateService.sql 　データベースのテーブル定義ファイル

## tbls(ER 図自動生成ツール)

公式 github  
https://github.com/k1LoW/tbls

wsl だと curl でインストールできなかったので手動でインストールする必要があります。

deb ファイルをカレントディレクトリにおいたら

```
 dpkg -i tbls.deb
```

インストール先確認

```
 dpkg -L tbls
```

.tbls.yml ファイルを以下のように作成

```
# .tbls.yml

# DSN (Database Source Name) to connect database
dsn: postgres://dbuser:dbpass@localhost:5432/dbname

# Path to generate document
# Default is `dbdoc`
docPath: doc/schema
```

以下コマンドで ER 図自動作成

```
tbls doc
```
