# <div style="text-align: center;"><span style="font-size: 140%; color: black;">ドキュメント一覧</span></div>

既存のメソッドやクラスについての情報集

### :fontawesome-solid-arrow-circle-right: **[power_network](../power_network)**：電力系統モデルについて


### :fontawesome-solid-arrow-circle-right: **[bus](../power_network)**：バスについて


### :fontawesome-solid-arrow-circle-right: **[component](../component)**：コンポーネント（バスに接続する機器）について


### :fontawesome-solid-arrow-circle-right: **[controller](../controller)**：コントローラについて

<br>

---
### <div style="text-align: center;"><span style="font-size: 130%; color: black;">クラスの全体構成図</span></div>

以下にpower_simulator上でのクラスの全体構成を示しておきます。チュートリアルを進めていく中や作業中に自身の使っている関数が何をするためのコマンドかわからなくなった際に目次代わりに利用してください。

[](TODO_link→以下の図のリンクを正しいリンクへ変更)
```mermaid
graph LR

base{power_simulator}---power_network
base---bus
base---component
base---controller

power_network---network_68bus
power_network---network_70bus
power_network---network_3bus
subgraph 電力系統モデル
    power_network
    network_68bus
    network_70bus
    network_3bus
end


bus---bus_non_unit
bus---bus_PQ
bus---bus_PV
bus---bus_slack
subgraph バス
    bus
    bus_non_unit
    bus_PQ
    bus_PV
    bus_slack
end

component---component_empty
component---generator_AGC
generator_AGC---generator
component---load_varying_impedance
load_varying_impedance---load_const_impedance
component---load_varying_power
load_varying_power---load_const_power
component---solar_farm
component---wind_farm
subgraph 機器
    component
    component_empty
    generator_AGC
    generator
    load_varying_impedance
    load_const_impedance
    load_varying_power
    load_const_power
    solar_farm
    wind_farm
end

controller---controller_broadcast_PI_AGC
controller_broadcast_PI_AGC---controller_broadcast_PI_AGC_normal
controller---controller_generator
controller_generator---controller_LQR
controller_generator---controller_retrofit_LQR
subgraph コントローラ
    controller
    controller_broadcast_PI_AGC
    controller_broadcast_PI_AGC_normal
    controller_generator
    controller_LQR
    controller_retrofit_LQR
end

click base "https://www.google.com/"
click power_network "https://www.google.com/"
click network_68bus "https://www.google.com/"
click network_70bus "https://www.google.com/"
click network_3bus "https://www.google.com/"
click bus "https://www.google.com/"
click bus_non_unit "https://www.google.com/"
click bus_PQ "https://www.google.com/"
click bus_PV "https://www.google.com/"
click bus_slack "https://www.google.com/"
click component "https://www.google.com/"
click component_empty "https://www.google.com/"
click generator_AGC "https://www.google.com/"
click generator "https://www.google.com/"
click load_varying_impedance "https://www.google.com/"
click load_const_impedance "https://www.google.com/"
click load_varying_power "https://www.google.com/"
click load_const_power "https://www.google.com/"
click solar_farm "https://www.google.com"
click wind_farm "https://www.google.com"
click controller "https://www.google.com/"
click controller_broadcast_PI_AGC "https://www.google.com/"
click controller_broadcast_PI_AGC_normal "https://www.google.com/"
click controller_generator "https://www.google.com/"
click controller_LQR "https://www.google.com/"
click controller_retrofit_LQR "https://www.google.com/"

```