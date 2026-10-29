% Create some data
x = 0:0.1:10;
y1 = sin(x);
y2 = cos(x);

% Create a figure with subplots
figure;

% First subplot
subplot(2, 1, 1);
hold on;
h1 = plot(x, y1, 'r', 'DisplayName', 'sin(x)');
h2 = plot(x, y2, 'b', 'DisplayName', 'cos(x)');
title('Subplot 1');

% Second subplot
subplot(2, 1, 2);
hold on;
h3 = plot(x, y1, 'g', 'DisplayName', 'sin(x)');
h4 = plot(x, y2, 'm', 'DisplayName', 'cos(x)');
title('Subplot 2');

% Create a shared legend
legend([h1, h2], 'Location', 'best');