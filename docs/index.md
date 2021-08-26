# <div style="text-align: center;"><span style="font-size: 140%; color: black;">電力系統に対する</br>レトロフィット制御シミュレータ</span></div>
本サイトはpower_simulator の公式ドキュメントです.

<br>

---
### <div style="text-align: center;"><span style="font-size: 130%; color: black;">【power_simulatorとは？】</span></div>
power_simulatorは、各人で電力系統システムの設計・解析するために作られたMATLAB言語のプログラムです。具体的には、以下の事などをシュミレーター上で行え様々な状況を想定した解析を補助します。

- 解析したい電力ネットワークを定義する
- その初期応答や外乱応答、線形化システムの導出などの解析を行う
     - 落雷などによって地絡が起きた際の状態の解析
     - コントローラを新しく設計し導入した時の応答の解析
     - etc...

<br><br>

### <div style="text-align: center;"><span style="font-size: 130%; color: black;">【power_simulatorの数理モデル】</span></div>
power_simulatorを制作する背景に使われている数理モデル等は「**参考書：電力システム制御理論**」の内容に即しており、こちらで紹介された理論をもとに構築されたものとなっております。理論に基づいてシュミレーションを進めて行きたい方は [**参考書の内容にそれぞれ対応付けながら進めていくチュートリアル**](./Tutorials/withText) も設けているので、そちらを見ていただくと分かりやすいかと思います。

<br><br>

---

### <div style="text-align: center;"><span style="font-size: 130%; color: black;">【そもそも電力システムって何で構成されてるの？】</span></div>
まず、シュミレータのチュートリアルの前に電力システムについて簡単に説明します。(__イラストをclick↓__)

<br>
[<img src="./Figures/index-3.jpg" width=100%; style="border: 3px pink solid;">](./abstract)

<br><br>

### <div style="text-align: center;"><span style="font-size: 130%; color: black;"><div style="text-align: center;">【チュートリアル】</span></div>
本サイトでは２つのタイプでのチュートリアルを用意しました。  
どちらを先に読んでいただいても構いません。(__イラストをclick↓__)

[<img src="./Figures/tuto-withText.jpg" width=49.5%; style="border: 3px pink solid;">](./Tutorials/withText)
[<img src="./Figures/tuto-newSystem.jpg" width=49.5%; style="border: 3px pink solid;">](./Tutorials/withSimulation)

「教科書に沿って学ぶ」ベースのチュートリアル(左側)
> テキストではじめに紹介されていた3busシステムの制作と解析を目標とする、定義してから解析するまでの流れが１本のストーリーとなるような構成となっています。
>
> - テキストの内容に対応付けながら進めたい方
> - 電力システムを定義し解析していく流れを掴みたい方

「シュミレータを動かす」ベースのチュートリアル(右側)
> 電力システムの「制作part」,「解析part」に分け各機能ごとにテーマを設けそれぞれの操作方法を解説していきます。前者のチュートリアルより、もう少し詳しく踏み込んだ内容まで示しています。
>
> - シュミレータの動かし方、仕組みの理解に重きを置きたい方
> - 前者のチュートリアルを終え、さらに詳しいシュミレータの操作を知りたい方
<br><br><br>

---
### <div style="text-align: center;"><span style="font-size: 130%; color: black;">【Docs】</span></div>
- [__既存のメソッドやクラスについての情報集__](./Docs/docs)  
Tutorial内にDocのリンクが必要に応じて貼られているので基本はそちらを見て頂き、適宜このページを参照していただければいいと思います。

<br><br>

### <div style="text-align: center;"><span style="font-size: 130%; color: black;">【Require】</span><div style="text-align: center;">
このシュミレータを動かすにあたって必要なToolbox。

- Optimization Toolbox
- Control System Toolbox
- Robust Control Toolbox