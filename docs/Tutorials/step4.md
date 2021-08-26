# 【第四回】電力系統の自作

- 本ステップでできるようになること  
    自分で用意したシステムをpower_simulatorに実装できるようになる

## 解説

### ネットワークの定義

今回はネットワークの情報を`net`と名付けた変数に定義していきます。  
まずはじめに以下のようにして電力系統クラスを定義します。全ての電力系統システムは`power_network`クラスを用いて実装されます。

```matlab
net = power_network(); % 何も定義されていないネットワーク
```
この動作はイメージでいうと、空のテンプレート表のようなものを変数`net`にあてはめており、これからこの表に機器の情報やブランチ・バスの情報を書き込んでいくための準備のようなプロセスです。

### バスの変数

一般的にバスに関係する変数として以下の6つのものがあります。  
これについては、[「電力ネットワークの構成」](../../abstract)のページでも簡単に解説しているので参考にしてください。

- $P$: 有効電力
- $Q$: 無効電力
- $|V|$: 電圧
- $\delta$: 位相角
- $G_{shunt}, B_{shunt}$: 地面に繋がっているシャント抵抗のインピーダンス

以下の３つのバスは$P,Q,V,\delta$のうち2つの変数とシャント抵抗の値を指定します．

### バスの定義

バスの定義は次のように、構造体となっている変数`net`の中の`bus`というフィールドにデータを代入することで定義します。
```matlab
net.bus = cell(3, 1);
net.bus{1} = bus_slack(…);
net.bus{2} = bus_PV(…);
net.bus{3} = bus_PQ(…);
```
ここでは`bus_slack,bus_PV,bus_PQ`の引数を`...`と省略していますが、実行する際はここにパラメータを代入する必要があります。  
それでは、以下にこの引数に必要なパラメータの設定について解説していきます。

#### ・slack bus

電力ネットワーク内の発電機バスは基本全てPVバスに分類されますが、一つだけ電圧の位相を指定し基準として機能するような特殊なバスが存在します。それがslackバスです。  
slackバスでは電圧の絶対値と位相角を指定します。そのため、slackバスの定義は以下のように`V_abs,V_angle`を引数としています。

```matlab
net.bus{idx} = bus_slack(V_abs, V_angle, [G_shunt, B_shunt]);
```

- 入力引数
    - V_abs
        電圧．
    - V_angle
        位相角。通常0となる．
    - [G_shunt, B_shunt]
        地面に繋がっているシャント抵抗のインピーダンスの実部と虚部．

#### ・PV bus

PVバスには、slackバスを除いた全ての発電機バスが分類されます。  
このバスでは、その名の通り有効電力Pと電圧の絶対値|V|を指定します。

```matlab
net.bus{idx} = bus_PV(V_abs, P_gen, [G_shunt, B_shunt]);
```

- 入力引数
    - V_abs
        電圧
    - P_gen
        有効電力
    - [G_shunt, B_shunt]
        地面に繋がっているシャント抵抗のインピーダンスの実部と虚部．

#### ・non-unit bus

non-unitバスとは機器が接続されていないようなバスのことをさし、他のバスとバスをつなぐ送電網の中継点のような役割を持つポイントです。このバスでは他のバスのように消費電力や電圧のパラメータは指定しません。

```matlab
net.bus{idx} = bus_non_unit([G_shunt, B_shunt]);
```

- 入力引数
    - [G_shunt, B_shunt]
        地面に繋がっているシャント抵抗のインピーダンスの実部と虚部．

#### ・PQ bus

PQバスは基本的に負荷バスが分類されるバスです。  
このバスでは、有効電力Pと有効電力Qを指定します。

```matlab
net.bus{idx} = bus_PQ(-Pload, -Qload, [G_shunt, B_shunt]);
```

- 入力引数
    - Pload
        有効電力．
    - Qload
        無効電力．
    - [G_shunt, B_shunt]
        地面に繋がっているシャント抵抗のインピーダンスの実部と虚部．

#### 例: IEEE 9busのbusの定義

ここまでで、バスの各種類とそれぞれの定義方法をしめしたので、ここまでのまとめとして、バスを定義するコードをまとめておきます。
```matlab
net.bus{1} = bus_slack(1.040000, 0.000000, [0.000000, 0.000000])
net.bus{2} = bus_PV(1.025000, 1.630000, [0.000000, 0.000000])
net.bus{3} = bus_PV(1.025000, 0.850000, [0.000000, 0.000000])
net.bus{4} = bus_non_unit([0.000000, 0.000000])
net.bus{5} = bus_PQ(-1.250000, -0.500000, [0.000000, 0.000000])
net.bus{6} = bus_PQ(-0.900000, -0.300000, [0.000000, 0.000000])
net.bus{7} = bus_non_unit([0.000000, 0.000000])
net.bus{8} = bus_PQ(-1.000000, -0.350000, [0.000000, 0.000000])
net.bus{9} = bus_non_unit([0.000000, 0.000000])
```

### ブランチの定義

ブランチの情報は変数`net`の中の`branch`というフィールドに定義していきます。
```matlab
net.branch = branch;
```
この右側の`branch`という変数には、ブランチの情報を含んだ`table`型のデータを格納します。例えばIEEE 9busだと以下のように定義したデータを`net.branch`に代入しています。

```matlab

  9×7 table

    bus_from    bus_to    x_real    x_imag      y       tap    phase
    ________    ______    ______    ______    ______    ___    _____

       1          4            0    0.0576         0     1       0  
       2          7            0    0.0625         0     1       0  
       3          9            0    0.0586         0     1       0  
       4          5         0.01     0.085     0.088     0       0  
       4          6        0.017     0.092     0.079     0       0  
       5          7        0.032     0.161     0.153     0       0  
       6          9        0.039      0.17     0.179     0       0  
       7          8       0.0085     0.072    0.0745     0       0  
       8          9       0.0119    0.1008    0.1045     0       0  
```
どのような電力ネットワークを定義する際も`branch`が7列であることは不変ですが、行数は各バス間をつなぐブランチ(送電網)の本数によって変わります。


- bus_from_phase
    接続元のバスの番号
- bus_to
    接続先のバスの番号
- x_real , x_imag
    ブランチ上のインピーダンスの実部と虚部の値  
    この値の逆数がアドミタンスになります。
- y
    対地静電容量の値
- tap , phase
    位相調整変圧器のパラメータ

#### branchを定義する際のサンプルコード。

この`branch`という変数はtable型になっており、さらに各列の変数名は以下のコードのようにそれぞれ「`bus_from`,・・・,`phase`」となっていることが重要です。本シュミレーション内ではこの変数名をもとにデータの抽出を行っています。以下のコードを参考にしてください。

```matlab
branch_array = [ここにデータを入れる];
branch = array2table(branch_array, 'VariableNames', ...
    {'bus_from', 'bus_to', 'x_real', 'x_imag', 'y', 'tap', 'phase'}...
    );
```
  
  
---
ここまでの作業で電力ネットワークの

- バスの個数
- それぞれのバスの種類
- 各バス間の送電網の接続
- 送電網状の抵抗などの値

を定義してきました。最後に各バスに発電機バスには発電機を、負荷バスには負荷を接続してあげることで、電力ネットワークは完成します。その後に各バスにコントローラを追加で接続する工程等もありますが、それは次のパートで紹介します。それでは以下に機器(発電機や負荷など)を接続する方法を示していきます。  

---


### 機器の定義

バスへの機器接続は以下のように行います．

```matlab
net.bus{i}.add_component(component);
```
以下の解説で機器を定義する関数の解説を行いますが、機器の定義の方法の流れとしては、変数`component`に関数を用いて機器のモデルを格納する。そのcomponent変数を上のコードでi番目(i=1,2,...)のバスに接続する。といった流れです。  

それでは各componentの定義を行っていきます。  
componentの定義には以下のような関数があります。

- generator_AGC
- load_varying_impedance
<span style="color: red; ">他のcomponentの子クラスも載せるべき？</span>


#### <u>発電機の定義</u>

発電気の定義には`generator_AGC`という関数を用います。この関数は同期発電機のモデルを各パラメータを引数として得ることで定義する関数です。

```matlab
component = generator(mac, exc, pss);
```
##### ・mac

6個のフィールドをもつtableとなります．以下その例です。branchのパラメータの設定のときと同様にmacもtable型で各列の変数は以下のようになっている必要があります。

```matlab
1×6 table

  Xd     Xdp     Xq     Tdo     M     d
 ____   _____   ____   _____   ___   ___

1.569   0.324   1.548   5.14   100    2

```

- `Xd, Xdp, Xq`
    d軸、q軸回りの同期リアクタンス
- `Tdo`
    ｄ軸回りの回路時定数
- `M`
    慣性定数
- `ｄ`
    制動係数

##### ・exc、pss

2個のフィールドをもつtableとなります．以下その例です．

```matlab
mac  =  
1×2 table

 Ka     Te
____   ____

  2    0.05   

pss =  
1×6 table

Kpss   Tpss   TL1p    TL1    TL2p   TL2
____   ____   ____   _____   ____   ___

  0     10    0.05   0.015   0.08  0.01
```

変数`mac`は発電機のパラメータであったのに対し、このmac,pssのパラメータはAVRやPSSの制御器のパラメータです。  
**<span style="color: red; font-size: 140%">この辺のパラメータについて</span>**


#### <u>負荷の定義</u>

負荷の定義には`load_varying_impedance`という関数を用います。この関数は以下の様に定義します。

```matlab
component = load_varying_impedance(net.bus{i}(1,:))
```
コードを見て分かるように負荷を接続するときは、既に定義しているバスのパラメータを用いるため、新しく定義する必要のあるパラメータはありません。  
なおコード内の変数`i`は接続するバスの番号であり、例えば６番目のバスに負荷を接続したい場合は、
```matlab
component = load_varying_impedance(bus(i,:))
net.bus{6}.add_component(component)
```
**<span style="color: red; font-size: 140%">load_varying_impedanceの引数はどうなっている?</span>**


という様にして負荷を接続することができます。

---

これで電力ネットワークの定義が一通り終わりました。ここで作成した変数`net`を持って[解析編](../analysis_net)のシュミレーションや線形化などを行うこともできます。次のパートではこの電力ネットワークにコントローラを追加する方法などを解説していきます。
