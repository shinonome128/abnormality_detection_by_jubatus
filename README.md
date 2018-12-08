# README.md  
  
## 目的  
  
Jubatus による異常検知方法を試す  
  
## 参照  
  
ドキュメント管理  
https://github.com/shinonome128/abnormality_detection_by_jubatus  
  
データサイエンティスト養成読本  
オンライン機械学習入門、第2部、特集5  
  
Jubatus 本家、　インストールガイド  
http://jubat.us/ja/quickstart.html  
  
Jubatus インストール方法、　tee で分岐して sudo でリダイレクションする方法  
https://qiita.com/kmaehashi/items/6e953e42ae7c09d5ba51  
  
## オンライン機械学習とは  
  
オンライン機械学習では学習対象の学習対象となるデータの全貌は見えず徐々に追加されてゆくとういう前提で設計  
  
メリット  
既存のモデルと新たな追加データからモデルを継続的に改善できる  
学習のために大規模なデータを保持するストレージを用意する必要がない  
学習済みのモデルから少ない計算コストで再学習できる  
  
## Jubatus とは  
  
NTT と PEN が共同開発、オープンソースとして公開しているオンライン機械学習基盤  
  
特徴  
オンライン機械学習のアルゴリズムを複数搭載  
複数の計算機に処理を分散させることで耐障害性とスケールアウト性を両立  
C++ で実装されたことによる高速性  
クライアント・サーバモデルを採用し、クライアント側に SDK を用いることで C++, Ruby, Python, Java, Go で記述できる  
  
サポートアルゴリズム  
  
線形分類  
Perceptron  
PA, PA1, PA2  
CW  
AROW  
NHERD  
  
非線形分類  
k近傍( コサイン距離ベース、ユークリッド距離ベース)  
  
線形回帰  
PA  
  
推薦  
k近傍( コサイン距離ベース、ユークリッド距離ベース)  
  
グラフ分析  
最短距離経路探索  
グラフ中心算出  
  
異常検知  
コサイン距離ベース  
ユークリッド距離ベース  
  
バンティット  
Epslon-Greedy  
softmaz  
exp3  
ucb1  
  
バースト検知  
kleinberg  
  
全てが並列・分散・スケールアウト可能な形で利用できる  
  
## 環境構築  
  
依存しているライブラリ  
jubbatus-mpio  
MessagePack  
jubatus-msgpack-rp  
orniguruma  
ux  
zookeeper(Cクライアント)  
log4cxx  
  
最新版をそれぞれ手動でインストールした後で Jubaus 本体をビルド  
Jubatus チームが提供しているリポジトリを利用するのもおすすめ  
  
## リポジトリからインストール  
  
apt-get でインスト  
```  
apt-get install -y jubatus  
```  
  
ここから再開  
cicd-demo の terraform の仕組みを流用  
GCP 上にインストする  
  
## 環境準備  
  
cicddemo のテンプレートをそのまま使う  
  
.gitignore の追記  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
echo *.swp>>.gitignore  
echo *.swo>>.gitignore  
echo *.json>>.gitignore  
echo .terraform/>>.gitignore  
echo *.tfstate>>.gitignore  
echo *.tfstate.backup>>.gitignore  
echo identity>>.gitignore  
echo identity.pub>>.gitignore  
git add .gitignore  
git commit -m "Add files"  
git push  
```  
  
SSH キーをコピー  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
copy C:\Users\shino\doc\cicddemo\identity .  
copy C:\Users\shino\doc\cicddemo\identity.pub .  
```  
  
Terraform 設定ファイルをコピー  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
mkdir terraform  
cd terraform  
copy C:\Users\shino\doc\cicddemo\terraform\gcp_firewall.tf  .  
copy C:\Users\shino\doc\cicddemo\terraform\gcp_instances.tf  .  
copy C:\Users\shino\doc\cicddemo\terraform\gcp_network.tf  .  
copy C:\Users\shino\doc\cicddemo\terraform\gcp_provider.tf  .  
git add *tf  
git commit -m "Add first commit"  
git push  
```  
  
GCP プロジェクト作成  
```  
jubatus  
```  
  
Compute Engine API の有効化  
  
GCP クレデンシャルファイルの作成  
全部、GUIから作成  
GCP コンソール上からプロジェクト選択  
APIとサービス 選択  
認証情報を選択  
認証情報を作成 クリック  
サービスアカントキー クリック  
Compute Engine default service account を選択  
JSON をチェック  
作成をクリック  
クレデンシャルファイルがブラウザ経由でダウンロードされるので移動  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
move "C:\Users\shino\Downloads\jubatus  -d418843cdf68.json" .  
```  
  
ここから再開  
  
gcp_provider.tf 修正  
  
gcp_network.tf 修正  
  
gcp_firewall.tf 修正  
  
gcp_instances.tf 修正  
  
初期セットアップコマンドを実行  
.terraform ディレクトリが作成されここにプラグインが管理される  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
terraform init terraform  
```  
  
プラン  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
terraform plan terraform  
```  
  
ディプロイ  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
terraform apply terraform  
```  
  
GCP コンソール経由でのアクセステスト  
  
SSH 経由でのアクセステスト  
  
デストロイ  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
terraform plan -destroy terraform  
terraform destroy terraform  
```  
  
## jubatus の apt-get のインストールをイニシャルコマンドに追加  
  
ディプロイ、デストロイシェルの作成  
WoX 起動シェルと gcloud ツールを参考に作成  
```  
cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
copy C:\Users\shino\doc\own_dashboard\deploy.bat .  
copy C:\Users\shino\doc\own_dashboard\destroy.bat .  
```  
  
ディプロイバッチの編集  
  
デストロイバッチの編集  
  
インスタンスのディスクリプションを修正  
  
ディプロイ  
Ubuntu に OS 変更、とりあえず、本家に従って、18.04  
```  
// Ubuntu 12.04 (Precise) の場合 - サポート対象外  
// Ubuntu 14.04 (Trusty) の場合  
// Ubuntu 16.04 (Xenial) の場合  
// Ubuntu 18.04 (Bionic) の場合  
```  
  
コマンド流し込みでうまくゆくかテスト  
```  
echo 'deb [trusted=yes] http://download.jubat.us/apt/ubuntu/bionic/binary /' | sudo tee /etc/apt/sources.list.d/jubatus.list  
sudo apt-get update  
sudo apt-get install -y --allow-unauthenticated jubatus  
export PATH=/opt/jubatus/bin:${PATH}  
```  
  
デストロイ  
  
インスタンスのイニシャルコマンドに追加  
  
ディプロイ  
正常にインストできたか確認  
cli_ts コマンドで確認  
```  
* google_compute_instance.development: invalid variable syntax: "PATH". Did you mean 'var.PATH'? If this is part of inline `template` parameter  
then you must escape the interpolation with two dollar signs. For  
example: ${a} becomes $${a}.  
```  
アプライチェックで失敗、 Terraform で $ 使う場合は2回必要  
  
export コマンドが通ってない、 root で実行しているから  
su でユーザ変更してから実行するようにしてみる  
だめだね、  
  
shinonome128 の bash設定で定義する  
```  
echo 'export PATH=/opt/jubatus/bin:${PATH}' | tee /home/shinonome128/.bash_profile  
```  
だめ、色がおかしくなる、追加する場所が違う  
```  
# ~/.profile: executed by the command interpreter for login shells.  
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login  
# exists.  
```  
  
多分、.profile に追記するのが正解  
```  
echo 'export PATH=/opt/jubatus/bin:${PATH}' >> /home/shinonome128/.profile  
```  
  
デストロイ  
  
EOF  
