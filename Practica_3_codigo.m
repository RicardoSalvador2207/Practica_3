function Practica_3_codigo
    tspan = [0 10];
    x0 = [0, 0, 0, 0];  % Condiciones iniciales en cero

    % Resolver el sistema de ecuaciones diferenciales para ambas entradas
    [t1, x1] = ode45(@(t, x) sistema_masas(t, x, 0.05 * sin(0.5 * pi * t)), tspan, x0);
    [t2, x2] = ode45(@(t, x) sistema_masas(t, x, 0.05 * sin(20 * pi * t)), tspan, x0);

    % Graficar los resultados
    figure;
    subplot(2,1,1);
    plot(t1, x1(:, [1,2]));
    xlabel('Tiempo (s)');
    ylabel('Estados');
    legend('x_1', 'dx_1');
    title('Simulación con z_1(t) = 0.05 sin(0.5\pi t)');
    grid on;
    
    subplot(2,1,2);
    plot(t2, x2(:, [1,2]));
    xlabel('Tiempo (s)');
    ylabel('Estados');
    legend('x_1', 'dx_1');
    title('Simulación con z_2(t) = 0.05 sin(20\pi t)');
    grid on;
end

function dx = sistema_masas(~, x, z)
    % Definición de parámetros según la tabla
    m1 = 290;   % Masa 1 
    m2 = 59;    % Masa 2 
    k1 = 16182; % Constante del resorte 1 
    k2 = 19000; % Constante del resorte 2 
    b1 = 1000;  % Coeficiente de amortiguamiento
    f = 0;      % Fuerza externa

    % Variables de estado
    x1 = x(1); % Posición de m1
    x2 = x(2); % Velocidad de m1
    x3 = x(3); % Posición de m2
    x4 = x(4); % Velocidad de m2

    % Ecuaciones en espacio de estados
    dx = zeros(4,1);
    dx(1) = x2;
    dx(2) = (f - b1*x2 + b1*x4 - k1*x1 + k1*x3) / m1;
    dx(3) = x4;
    dx(4) = (-f + k2*z + b1*x2 - b1*x4 + k1*x1 - (k1+k2)*x3) / m2;
end