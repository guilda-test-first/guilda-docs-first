net = power_network();
net.bus = cell(3, 1);

branch_array = [
    1 2	0	0.0576	0	1	0;
    3 2 0	0.0625	0	1	0;
    ];

branch = array2table(branch_array, 'VariableNames', ...
    {'bus_from', 'bus_to', 'x_real', 'x_imag', 'y', 'tap', 'phase'}...
    );

net.branch = branch;
%% slack
net.bus{1} = bus_slack(1.0, 0.0, [0, 0]);

% mac
Xd = 1.6;
Xdp = 0.32;
Xq = 1.59;
Tdo = 6.0;
M = 100;
d = 2;
mac = table(Xd, Xdp, Xq, Tdo, M, d);

% exc
Ka = 2.0;
Te = 0.05;
exc = table(Ka, Te);

% pss
Kpss = 200;
Tpss = 10;
TL1p = 0.05;
TL1 = 0.015;
TL2p = 0.08;
TL2 = 0.01;
pss = table(Kpss, Tpss, TL1p, TL1, TL2p, TL2);

net.bus{1}.add_component(generator_AGC(mac, exc, pss));

%% generator
net.bus{2} = bus_PV(1.0, 1.7, [0, 0]);

% mac
Xd = 1.6;
Xdp = 0.23;
Xq = 1.59;
Tdo = 6.0;
M = 18;
d = 2;
mac = table(Xd, Xdp, Xq, Tdo, M, d);

% exc
Ka = 2.0;
Te = 0.05;
exc = table(Ka, Te);

% pss
Kpss = 200;
Tpss = 10;
TL1p = 0.05;
TL1 = 0.015;
TL2p = 0.08;
TL2 = 0.01;
pss = table(Kpss, Tpss, TL1p, TL1, TL2p, TL2);

net.bus{2}.add_component(generator_AGC(mac, exc, pss));
%% load
net.bus{3} = bus_PQ(-1.25, -0.5, [0, 0]);
net.bus{3}.add_component(load_varying_impedance())

%%
net.initialize();
% option = struct();
% option.fault = {{[0, 0.01], 1}, {[10, 10.01], 2}};
% out = net.simulate([0, 100], option);
%
% sys = net.get_sys();

%% controller
cg = controller_broadcast_PI_AGC_normal(net, [2], [2], -10, -5000);
net.add_controller_global(cg)


option = struct();
option.fault = {{[0, 0.01], 1}, {[10, 10.01], 2}};

out = net.simulate([0, 100], option);

names = {'\delta', '\Delta\omega', 'E', 'V_{fd}', '\xi_1', '\xi_2', '\xi_3'};
for j = 1:7
    subplot(7, 1, j), plot(out.t, out.X{2}(:, j));
    title(names{j}, 'Interpreter', 'tex');
end