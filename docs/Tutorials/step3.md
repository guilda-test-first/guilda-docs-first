# 【第三回】制御器の導入

- 本ステップでできるようになること  
    システムにコントローラを導入してシミュレーションできるようになる


## 解説
### コントローラの作成

コントローラの作成について説明する．  


#### グローバルコントローラの作成

グローバルコントローラの作成は次のように行う．
```
cg = controller_broadcast_PI_AGC_normal(net, y_idx, u_idx, Kp, Ki);
```

- 入力引数`net`  
    コントローラを追加する予定のネットワークのインスタンス（ *power_network* クラス）  
    詳細は[Step1](../step1)・[Power Network](../../Docs/power_network)を参照のこと．
- 入力引数`y_idx`  
    出力を観測するバスの番号．
- 入力引数`u_idx`  
    入力を印加するバスの番号．
- 入力引数`Kp` `Ki`  
    コントローラのPIゲイン．
- 出力引数`cg`  
    コントローラの状態空間モデルなどの情報が含まれるインスタンス（*controller*クラス）  
    詳細は[controller_broadcast_PI_AGC_normal](../../Docs/controller/#controller_broadcast_pi_agc_normal)を参照のこと

power_simulatorではグローバルコントローラがすでにいくつか定義されている．  
詳細は[Controller](../../Docs/controller)を参照のこと．  
本チュートリアルでは，[controller_broadcast_PI_AGC_normal](../../Docs/controller/#controller_broadcast_pi_agc_normal)を使用する．  
[controller_broadcast_PI_AGC_normal](../../Docs/controller/#controller_broadcast_pi_agc_normal)はブロードキャストコントローラ（PIコントローラ）の実装で，ゲインを電力に比例させているものである（generatorの規模に比例して調整電力を分配している）

#### コントローラの作成

コントローラの作成は次のように行う．
```
c = controller_retrofit_LQR(net, idx, Q, R, model_uv, vbar, ubar, out, varargin);
```

- 入力引数`net`  
    コントローラを追加する予定のネットワークのインスタンス（ *power_network* クラス）  
    詳細は[Step1](../step1)・[Power Network](../../Docs/power_network)を参照のこ
- 入力引数`idx`  
    出力を観測するバスの番号．
- 第3入力引数以降は今回は使用しないので省略．[controller_retrofit_LQR](../../Docs/controller/#controller_retrofit_lqr)を参照のこと．
- 出力引数`c`  
    コントローラの状態空間モデルなどの情報が含まれるインスタンス（*controller*クラス）
    - K_inter: 内部コントローラのK行列
    - sys_design: サブシステムの状態空間モデル
    - sys_fb: 内部コントローラとsys_designからなるフィードバックシステムの状態空間モデル
    - Q, R: LQR設計のためのQ行列とR行列

power_simulator ではコントローラがすでにいくつか定義されている．  
詳細は[Controller](../../Docs/controller)を参照のこと．  
本チュートリアルでは，[controller_retrofit_LQR](../../Docs/controller/#controller_retrofit_lqr)を使用した．  
[controller_retrofit_LQR](../../Docs/controller/#controller_retrofit_lqr)はレトロフィットコントローラの実装で，コントローラ設計をLQRで行うものである．


### 電力系統モデルに対するコントローラの追加

システムに対するコントローラの追加について説明する．

#### グローバルコントローラの追加

グローバルコントローラの付加は次のように行う
```
net.add_controller_global(controller);
```

- (クラス)インスタンス `net`  
    *power_network* クラスのインスタンスを使用する
- 入力引数`controller`  
    作成したグローバルコントローラのインスタンス（ *controller* クラス）  
    一つのバスに複数のグローバルコントローラを付加することができる．

#### コントローラの追加

コントローラの付加は次のように行う．
```
net.add_controller(controller);
```

- (クラス)インスタンス `net`  
    *power_network* クラスのインスタンスを使用する
- 入力引数`controller`  
    作成したコントローラのインスタンス（ *controller* クラス）  
    一つのバスに複数のコントローラを付加した際には，最後に付加したコントローラが使用される．

### コントローラの除去

システムに付加されているコントローラの除去について説明する．

#### グローバルコントローラの除去

グローバルコントローラの除去は次のように行う
```
net.remove_controller_global(idx);
```

- (クラス)インスタンス `net`  
    *power_network* クラスのインスタンスを使用する
- 入力引数`idx`  
    除去するグローバルコントローラが追加されているバスの番号  
    `idx`をベクトル形式で指定すると複数のグローバルコントローラを除去できる．

#### コントローラの除去

コントローラの除去は次のように行う．
```
net.remove_controller(idx);
```

- (クラス)インスタンス `net`  
    *power_network* クラスのインスタンスを使用する
- 入力引数`idx`  
    除去するコントローラが追加されているバスの番号  
    `idx`をベクトル形式で指定すると複数のコントローラを除去できる．


### システムの状態空間モデル（線形化システム）の取得

システムの状態空間モデルの取得は次のように行う．
```
sys = net.get_sys(with_controller);
```

- 入力引数`with_controller`  
    取得するシステムに制御器を含めるかどうか．  
    *false*：コントローラなし，*true*：コントローラあり（省略した場合は*false*）  
    今回はコントローラを含めたモデルを取得したいので、**true** で設定．
- 出力引数`sys`  
    システムの状態空間モデル（matlab既存の ***ss*** クラスのインスタンス）  
    詳細は[Step2](../step2)・[Power Network](../../Docs/power_network)を参照のこと．


## 例1：コントローラを付加したシミュレーション

コントローラを付加したシステムに対して，外乱を印加した時の応答．
```
% 電力系統モデルの作成
net = network_68bus_AGC_varying_impedance();

% システムへのコントローラの付加
cg = controller_broadcast_PI_AGC_normal(net, 1:16, 1:16, -10, -500); % グローバルコントローラの作成
net.add_controller_global(cg); % グローバルコントローラの付加
c = controller_retrofit_generator_nonlinear_AGC_LQR(net, 1); % コントローラの作成
net.add_controller(c); % コントローラの付加

% シミュレーションのためのオプションを定義・決定
option = struct();
option.fault = {{[0 0.07], 1}, {[10 10.05], 10}}; % 地絡の設定

% シミュレーションの実行
out = net.simulate([0 20], option); % 0~20s
```

## 例2：線形化システムの取得

コントローラを付加した電力系統モデル`net`を定義した後に以下を追記すると，状態空間表現（線形化システム）`sys`が得られる．
```
% 線形化システムの取得
with_controller = true; % 制御器あり
sys = net.get_sys(with_controller);
```
