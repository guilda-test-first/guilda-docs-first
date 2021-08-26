# <div style="text-align: center;"><span style="font-size: 140%; color: black;">チュートリアル一覧</span></div>

以下に本サイトで紹介しているチュートリアルの一覧をまとめておきます。  
power_simulatorの全体構成については [**Abstract**](../../abstract)を、チュートリアル内で使用するメソッドやクラスなどの詳しい説明は [**Docs**](../../Docs/docs)をご覧ください。

<br><br>

---
まずは、power_simulatorの一連の流れを追うことができる2種類のチュートリアルはこちら

### <span style="font-size: 130%; color: black;">:material-arrow-right-bold-circle:**[「教科書に沿って学ぶ」ベース](../withText)**</span>

- テキストで初めに紹介されていた 3bus システムの制作と解析を目標としたチュートリアルです。
    - 定義してから解析するまでの流れが１本のストーリーとなるような構成となっています。
- 対象者
    - テキストの内容に対応づけながら進めたい方
    - 電力システムを定義し、解析していく流れを掴みたい方

<br><br>

### <span style="font-size: 130%; color: black;">:material-arrow-right-bold-circle:**[「シミュレータを動かす」ベース](../withSimulation)**</span>

- 電力システムの「制作part」,「解析part」に分け各機能の操作方法を解説するチュートリアルです。
    - 前者のチュートリアルより、少し深く踏み込んだ内容まで示しています。
- 対象者
    - シュミレータの動かし方、仕組みの理解に重きを置きたい方
    - 前者のチュートリアルを終え、さらに詳しいシュミレータの操作を知りたい方

<br><br>

---
次に、テーマ別のチュートリアルはこちら

### <span style="font-size: 130%; color: black;">:material-arrow-right-drop-circle:**[【第一回】既存の系統モデルのシミュレーション](../step1)**</span>

- 対象者：制御工学についての知識はあるが，電力系統については知識がない技術者
- できるようになること：
    - 既存の電力系統モデルに対して，初期値応答・外乱応答・入力応答などのシミュレーションを実行する

<br><br>

### <span style="font-size: 130%; color: black;">:material-arrow-right-drop-circle:**[【第二回】線形化したシステムを使う](../step2)**</span>

- 対象者：制御工学の技術者
- できるようになること：
    - 線形化したシステムでのシミュレーションを行う
    - 線形化したシステムの状態空間表現を取得する

<br><br>

### <span style="font-size: 130%; color: black;">:material-arrow-right-drop-circle:**[【第三回】制御器の導入](../step3)**</span>

- 対象者：レトロフィット制御の論文を読み，実際にシミュレーションを行いたい技術者
- できるようになること：
    - システムに既存のコントローラを付加してシミュレーションを行う
    - 既存のコントローラを付加されたシステムの状態空間表現を取得する

<br><br>

### <span style="font-size: 130%; color: black;">:material-arrow-right-drop-circle:**[【第四回】電力系統の自作](../step4)**</span>

- 対象者：シミュレーション用の電力系統を自作したい技術者
- できるようになること：
    - 電力系統の自作
        - バスの定義
        - ブランチの定義
        - 機器の定義

<br><br>

### <span style="font-size: 130%; color: black;">:material-arrow-right-drop-circle:**[【第五回】機器の自作](../step5)**</span>

- 対象者：既存の種類以外の機器を使用したい技術者
- できるようになること：
    - 機器の自作

<br><br>

### <span style="font-size: 130%; color: black;">:material-arrow-right-drop-circle:**[【第六回】制御器の自作](../step6)**</span>

- 対象者：既存の種類以外の制御器を使いたい技術者
- できるようになること：
    - 制御器の自作

<br><br>

### <span style="font-size: 120%; color: black;">今後追加予定のチュートリアル</span>

- レトロフィット制御器の自作
- 電力系統のシステム同定
