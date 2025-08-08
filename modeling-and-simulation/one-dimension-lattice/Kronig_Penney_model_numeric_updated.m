function Kronig_Penney_model_numeric_updated

clear
global fL fR u0 a b

% Physical constants
h = 6.62606896e-34;         % Planck's constant (J.s)
hbar = h / (2 * pi);        % Reduced Planck's constant (J.s)
me = 9.10938215e-31;        % Electron mass (kg)
e = 1.602176487e-19;        % Elementary charge (C)
ab = 1e-10;                 % 1 angstrom in meters
kb = 1 / ab;                % Wavevector unit
Eb = hbar^2 * kb^2 / (2 * me);  % Energy unit in J
Eb_eV = Eb / e;             % Energy unit in eV
u0 = 150;                   % Potential height in Eb units

% Prompt user for plotting mode
mode = input('Plot in 2D or 3D? Enter 2 or 3 [default: 2]: ', 's');
if isempty(mode)
    mode = '2';
end

% Suggest default values for a and b
a_str = input('Enter the distance between atoms in the chain a (default 2): ', 's');
if isempty(a_str)
    a = 2;
else
    a = str2double(a_str);
end

b_str = input('Enter the width of the barrier b (default 0.025): ', 's');
if isempty(b_str)
    b = 0.025;
else
    b = str2double(b_str);
end

kp = (0:0.005:3) * pi / (a + b);  % k' values
k = (-6:0.05:6) * pi / a;         % k values

% Define LHS and RHS functions
fR = @(kv,x,y) cos(kv * (x + y));
fL = @(xE,V,x,y) ((V - 2 * xE) ./ (2 * sqrt(u0 - xE) .* sqrt(xE))) .* ...
      sinh(sqrt(V - xE) * y) .* sin(sqrt(xE) * x) + ...
      cosh(sqrt(V - xE) * y) .* cos(sqrt(xE) * x);

yR = fR(kp, a, b);

% Check for 3D plot mode
if strcmp(mode, '3')
    u = 100:10:600;
    for i = 1:length(u)
        yL(i, :) = fL(k.^2, u(i), a, b);
    end
    j = k * a;
    surf(j, u, yL)
    xlabel('ka', 'FontSize', 14)
    zlabel('LHS, RHS', 'FontSize', 14)
    ylabel('Barrier Height')
    title(['Kronig-Penney Model: u0=', num2str(u0), ...
           ', a=', num2str(a), ', b=', num2str(b)])

else
    % 2D plot mode
    yL = fL(k.^2, u0, a, b);
    subplot(1, 2, 1)
    line([min(k * a), max(k * a)], [max(yR), max(yR)], 'Color', 'k', 'LineStyle', '--')
    hold on
    plot(k * a, yL, 'k')
    for i = 1:length(k)
        if yL(i) <= max(yR) && yL(i) >= min(yR)
            plot(k(i) * a, yL(i), 'k.', 'MarkerSize', 5)
        end
    end
    line([min(k * a), max(k * a)], [min(yR), min(yR)], 'Color', 'k', 'LineStyle', '--')
    legend('RHS', 'LHS', 'roots')
    xlabel('ka', 'FontSize', 14)
    ylabel('LHS, RHS', 'FontSize', 14)
    title(['Kronig-Penney Model: u0=', num2str(u0), ...
           ', a=', num2str(a), ', b=', num2str(b)])
    axis tight
    hold off

    % Energy vs k'
    subplot(1, 2, 2)
    eps_guess = searchguess(1e-3, kp(1));
    nr = 0;
    test_old = 0.0;
    for i = 1:length(kp)
        yRi = fR(kp(i), a, b);
        if yRi <= 1 && yRi >= -1
            nr = nr + 1;
            kr(nr) = kp(i);
            eps(nr) = fzero(@(xE) FofE(xE, kp(i)), eps_guess);
            eps_guess = eps(nr);
            test_new = mod(kp(i) * (a + b) / pi, 1);
            if test_new < test_old
                eps_guess = searchguess(eps_guess, kp(i));
            end
            test_old = test_new;
        end
    end

    kp_a = kr * (a + b);
    ep_a = eps;
    n = floor(length(kp_a) / 200);
    kp_b = kp_a - kp_a(end);
    ep_b = ep_a(end:-1:1);
    plot(kp_a, ep_a, 'k.', 'MarkerSize', 1)
    hold on
    plot(kp_b, ep_b, 'k.', 'MarkerSize', 1)
    xlabel('k''(a+b)', 'FontSize', 14)
    ylabel('\epsilon(k'') (\epsilon_b)', 'FontSize', 14)
    for i = 1:n
        x = i * 200 + 1;
        y = x + 1;
        yline(ep_a(x), 'red');
        if i ~= n
            yline(ep_a(y), 'blue');
        end
    end
    title(['\epsilon_b = ', num2str(Eb_eV, '%5.2f'), ' eV'])
  end
end

function [y] = searchguess(x, kk)
global u0 a
del = 13.2e-3 * u0 / a + 0.2 * x;
xi = x;
xf = xi;
for i = 1:50 * del
    xf = xf + del;
    if FofE(xi, kk) * FofE(xf, kk) <= 0
        y = xf;
        return
    end
    xi = xf;
end
end

function [y] = FofE(eps, kk)
global fL fR u0 a b
y = fL(eps, u0, a, b) - fR(kk, a, b);
end