<div style="text-align: center;">
<img src="../../Figures/tuto-newSystem.jpg" width=60%;>
</div>

### <span style="font-size: 130%; color: black;">power_simulatorを使うためのステップ</span>
power_simulatorで解析するには大きく分けて２つのステップがあります。
<div style="text-align: center;">
```mermaid
graph LR
作る((電力システム<br>を定義する))
作る-->解析((電力システム<br>を解析する))
```
</div>
以下に各ステップごとに説明していきます。

取り敢えず解析をしてみたいという方は、「解析編」から読み進めていただいて大丈夫です。  
既にいくつかの電力システム(9bus,68bus,70busシステム)を定義するための一連のコードを記述したmファイルを用意してあり、そちらを利用する方法は「解析編」でも示しています。

<div style="text-align: center;">
<span style="font-size: 180%; color: black;">【電力システムを作成/定義する click↓】</span></div>
[<img src="../../Figures/index-1.jpg" width=100%; style="border: 3px pink solid;">](../make_net)

<div style="text-align: center;">
<span style="font-size: 180%; color: black;">【作成した電力システムを解析する click↓】</span></div>
[<img src="../../Figures/index-2.jpg" width=100%; style="border: 3px pink solid;">](../analysis_net)