fprintf('EE280 Exam 1 Matlab Solvers and Plotters\n');

%Input validation while loop
validInput = false;
while ~validInput
    %User input and call function for that problem
    problemNum = input('Which problem in the exam would you like to solve? (1-6): ');
    switch problemNum
        case 1
            validInput=true;
            ProbOne();
        case 2
            validInput=true;
            ProbTwo();
        case 3
            validInput=true;
            ProbThree();
        case 4
            validInput=true;
            ProbFour();
        case 5
            validInput=true;
            ProbFive();
        case 6
            validInput=true;
            ProbSix();
        otherwise
            fprintf('Invalid input, try again\n');
    end
end

%Problem 1
function ProbOne()
    %Input
    Vs = input('What is the voltage of the voltage supply (in volts)?: ');
    R1 = input('What is the resistance of the first resistor (in ohms)?: ');
    R2 = input('What is the resistance of the second resistor (in ohms)?: ');
    R3 = input('What is the resistance of the third resistor (in ohms)?: ');
    R4 = input('What is the resistance of the fourth resistor (in ohms)?: ');
    L = input('What is the inductance of the inductor (in henry)?: ');
    
    %A
    initialInductorCurrent = -(R2/(R2+R3))*(Vs/(R1+(1/((1/R2)+(1/R3)))))
    
    %B
    timeConstant = L/R4
    
    %C
    t = linspace(0, 5*timeConstant, 1000);
    currentEquation = initialInductorCurrent*exp(-t/timeConstant);
    fprintf('currentEquation = \n\n    %.2f * e^(-t/%.3f)\n\n',initialInductorCurrent,timeConstant);
    
    %Graphing 
    plot(t, currentEquation, 'b', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Current (A)');
    title('Natural Response of RL Circuit');
    grid on;
end

%Problem 2
function ProbTwo()
    %Input
    Vs = input('What is the voltage of the voltage supply (in volts)?: ');
    R1 = input('What is the resistance of the first resistor (in ohms)?: ');
    R2 = input('What is the resistance of the second resistor (in ohms)?: ');
    R3 = input('What is the resistance of the third resistor (in ohms)?: ');
    R4 = input('What is the resistance of the fourth resistor (in ohms)?: ');
    C = input('What is the capacitance of the capacitor (in farads)?: ');

    %A
    initialCapacitorVoltage = Vs

    %B
    timeConstant = (R2+(1/(1/R3+1/R4)))*C

    %C
    t = linspace(0, 5*timeConstant, 1000);
    voltageEquation = initialCapacitorVoltage*exp(-t/timeConstant);
    fprintf('voltageEquation = \n\n    %.2f*e^(-t/%.3f)\n\n',initialCapacitorVoltage,timeConstant);

    %Graphing 
    plot(t, voltageEquation, 'b', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Natural Response of RC Circuit');
    grid on;
end

%Problem 3
function ProbThree()
    %Input
    Vs = input('What is the voltage of the voltage supply (in volts)?: ');
    Is = input('What is the current of the current supply (in amps)?: ');
    R1 = input('What is the resistance of the first resistor (in ohms)?: ');
    R2 = input('What is the resistance of the second resistor (in ohms)?: ');
    L = input('What is the inductance of the inductor (in henry)?: ');

    %A
    initialInductorCurrent = (Is*(R2/(R1+R2)))-(Vs/(R1+R2))

    %B
    finalInductorCurrent = Is

    %C
    timeConstant = L/R2

    %D
    t = linspace(0, 5*timeConstant, 1000);
    currentEquation = finalInductorCurrent+(initialInductorCurrent-finalInductorCurrent)*exp(-t/timeConstant);
    fprintf('currentEquation = \n\n    %.3f+(%.3f)*e^(-t/%.6f)\n\n',finalInductorCurrent,(initialInductorCurrent-finalInductorCurrent),timeConstant);

    %Graphing 
    plot(t, currentEquation, 'b', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Current (A)');
    title('Step Response of RL Circuit');
    grid on;
end

%Problem 4
function ProbFour()
    %Input
    Vs1 = input('What is the voltage of the first voltage supply (in volts)?: ');
    Vs2 = input('What is the voltage of the second voltage supply (in volts)?: ');
    R1 = input('What is the resistance of the first resistor (in ohms)?: ');
    R2 = input('What is the resistance of the second resistor (in ohms)?: ');
    R3 = input('What is the resistance of the third resistor (in ohms)?: ');
    R4 = input('What is the resistance of the fourth resistor (in ohms)?: ');
    C = input('What is the capacitance of the capacitor (in farads)?: ');

    %A
    initialCapacitorVoltage = Vs1
    finalCapacitorVoltage = (R3/(R3+R4))*-Vs2

    %B
    timeConstant = (R2+(1/(1/R3+1/R4)))*C

    %C
    t = linspace(0, 5*timeConstant, 1000);
    voltageEquation = finalCapacitorVoltage+(initialCapacitorVoltage-finalCapacitorVoltage)*exp(-t/timeConstant);
    fprintf('voltageEquation = \n\n    %.2f+(%.2f)*e^(-t/%.3f)\n\n',finalCapacitorVoltage,(initialCapacitorVoltage-finalCapacitorVoltage),timeConstant);

    %Graphing 
    plot(t, voltageEquation, 'b', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Step Response of RC Circuit');
    grid on;
end

%Problem 5
function ProbFive()
    %Input
    C = input('What is the capacitance of the capacitor (in farads)?: ');
    L = input('What is the inductance of the inductor (in henry)?: ');
    R = input('What is the resistance of the resistor (in ohms)?: ');
    initialCapacitorVoltage = input('What is the capacitors initial voltage (in volts)?: ');
    initialInductorCurrent = input('What is the inductors initial current (in amps)?: ');

    %A
    a = 1/(2*R*C)
    w0 = sqrt(1/(L*C))
    zeta = (R/2)*sqrt(C/L);

    %Overdamped
    if a^2>w0^2
        %Computing S1 and S2
        response = 'overdamped'
        s1 = -a+sqrt(a^2-w0^2)
        s2 = -a-sqrt(a^2-w0^2)

        %Solving the system of equations for A1 and A2
        syms A1 A2;
        eq1 = A1+A2==initialCapacitorVoltage;
        eq2 = s1*A1+s2*A2==((-initialCapacitorVoltage/R)-initialInductorCurrent)/C;
        sol = solve([eq1,eq2],[A1,A2]);
        A1sol = sol.A1
        A2sol = sol.A2

        %Setting linspace
        t = linspace(0,5/(zeta*w0),1000);

        %Compute Equation
        voltageEquation = A1sol*exp(s1*t)+A2sol*exp(s2*t);
        fprintf('voltageEquation = \n\n    %.2fe^(%.2f*t)+%.2fe^(%.2f*t)\n\n',A1sol,s1,A2sol,s2);

        %Plot Graph
        plot(t, voltageEquation, 'b', 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        title('Overdamped Natural Response of Parallel RLC Circuit');
        grid on;

    %Underdamped
    elseif a^2<w0^2
        %Computing wd
        response = 'underdamped'
        wd = sqrt(w0^2-a^2)

        %Solving the system of equations for B1 and B2
        syms B1 B2;
        eq1 = B1==initialCapacitorVoltage;
        eq2 = -a*B1+wd*B2==((-initialCapacitorVoltage/R)-initialInductorCurrent)/C;
        sol = solve([eq1,eq2],[B1,B2]);
        B1sol = sol.B1
        B2sol = sol.B2

        %Setting linspace
        t = linspace(0,5/(w0),1000);

        %Compute Equation
        voltageEquation = B1sol*exp(-a*t).*cos(wd*t)+B2sol*exp(-a*t).*sin(wd*t);
        fprintf('voltageEquation = \n\n    %.2fe^(%.2f*t)*cos(%.2f*t)+%.2fe^(%.2f*t)*sin(%.2f*t)\n\n',B1sol,-a,wd,B2sol,-a,wd);

        %Plot Graph
        plot(t, voltageEquation, 'b', 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        title('Underdamped Natural Response of Parallel RLC Circuit');
        grid on;

    %Critically Damped    
    else
        response = 'critically damped'

        %Solving the system of equations for D1 and D2
        syms D1 D2;
        eq1 = D2==initialCapacitorVoltage;
        eq2 = D1-a*D2==((-initialCapacitorVoltage/R)-initialInductorCurrent)/C;
        sol = solve([eq1,eq2],[D1,D2]);
        D1sol = sol.D1
        D2sol = sol.D2

        %Setting linespace
        t = linspace(0,5/(zeta*w0),1000);

        %Compute Equation
        voltageEquation = D1sol*t*exp(-a*t)+D2sol*exp(-a*t);
        fprintf('voltageEquation = \n\n    %.2f*t*e^(%.2f*t)+%.2fe^(%.2f*t)\n\n',D1sol,-a,D2sol,-a);

        %Plot Graph
        plot(t, voltageEquation, 'b', 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        title('Critically Damped Natural Response of Parallel RLC Circuit');
        grid on;
    end
end

%Problem 6
function ProbSix()
    %Input
    C = input('What is the capacitance of the capacitor (in farads)?: ');
    L = input('What is the inductance of the inductor (in henry)?: ');
    R = input('What is the resistance of the resistor (in ohms)?: ');
    initialCapacitorVoltage = input('What is the capacitors initial voltage (in volts)?: ');
    
    %A
    initialInductorCurrent = 0
    a = R/(2*L)
    w0 = sqrt(1/(L*C))
    zeta = R/(2*sqrt(L/C));

    %Overdamped
    if a^2>w0^2
        %Computing S1 and S2
        response = 'overdamped'
        s1 = -a+sqrt(a^2-w0^2)
        s2 = -a-sqrt(a^2-w0^2)

        %Solving the system of equations for A1 and A2
        syms A1 A2;
        eq1 = A1+A2==initialInductorCurrent;
        eq2 = s1*A1+s2*A2==(-R*initialInductorCurrent-initialCapacitorVoltage)/L;
        sol = solve([eq1,eq2],[A1,A2]);
        A1sol = sol.A1
        A2sol = sol.A2

        %Setting linspace
        t = linspace(0,5/(zeta*w0),1000);

        %Compute Equation
        currentEquation = A1sol*exp(s1*t)+A2sol*exp(s2*t);
        fprintf('currentEquation = \n\n    %.2fe^(%.2f*t)+%.2fe^(%.2f*t)\n\n',A1sol,s1,A2sol,s2);

        %Plot Graph
        plot(t, currentEquation, 'b', 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Current (A)');
        title('Overdamped Natural Response of Series RLC Circuit');
        grid on;

    %Underdamped
    elseif a^2<w0^2
        %Computing wd
        response = 'underdamped'
        wd = sqrt(w0^2-a^2)

        %Solving the system of equations for B1 and B2
        syms B1 B2;
        eq1 = B1==initialInductorCurrent;
        eq2 = -a*B1+wd*B2==(-R*initialInductorCurrent-initialCapacitorVoltage)/L;
        sol = solve([eq1,eq2],[B1,B2]);
        B1sol = sol.B1
        B2sol = sol.B2

        %Setting linspace
        t = linspace(0,5/w0,1000);

        %Compute Equation
        currentEquation = B1sol*exp(-a*t).*cos(wd*t)+B2sol*exp(-a*t).*sin(wd*t);
        fprintf('currentEquation = \n\n    %.2fe^(%.2f*t)*cos(%.2f*t)+%.2fe^(%.2f*t)*sin(%.2f*t)\n\n',B1sol,-a,wd,B2sol,-a,wd);

        %Plot Graph
        plot(t, currentEquation, 'b', 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Current (A)');
        title('Underdamped Natural Response of Series RLC Circuit');
        grid on;

    %Critically Damped    
    else
        response = 'critically damped'

        %Solving the system of equations for D1 and D2
        syms D1 D2;
        eq1 = D2==initialInductorCurrent;
        eq2 = D1-a*D2==(-R*initialInductorCurrent-initialCapacitorVoltage)/L;
        sol = solve([eq1,eq2],[D1,D2]);
        D1sol = sol.D1
        D2sol = sol.D2

        %Setting linspace
        t = linspace(0,5/(zeta*w0),1000);

        %Computing Equation
        currentEquation = D1sol*t*exp(-a*t)+D2sol*exp(-a*t);
        fprintf('currentEquation = \n\n    %.2f*t*e^(%.2f*t)+%.2fe^(%.2f*t)\n\n',D1sol,-a,D2sol,-a);

        %Plot Graph
        plot(t, currentEquation, 'b', 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Current (A)');
        title('Critically Damped Natural Response of Series RLC Circuit');
        grid on;
    end
end