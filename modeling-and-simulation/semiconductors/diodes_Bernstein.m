function diodes_Bernstein()

load('DiodeData.mat')

clear yi

choice=menu('What would you like to explore?','Temperature Dependance','Changing Parameters','Interpolation of Data');

if choice==1 %%Temp Dependance
    
    volt=[-.1:0.01:0.1]; %%Set Voltage range
    temp=[300:2:400]; %Set Temp range and density
    Vtherm=temp/11586;
    ideal=1.5; %Set ideality Factor
    sat=1e-8; %Set Saturation Current
    
    %Calculates I-V curve at each temperature
    for i=1:length(Vtherm)
        curr(i,:)=sat*(exp((volt/(ideal*Vtherm(i))))-1);
    end
    
    %Creates a suraces plot of the variables
    surf(volt,temp,curr)
    xlabel('Voltage (V)'), ylabel('Temperature (K)'), zlabel('Current (A)')
    title('Temperature Dependance of an Ideal Diode')
    
elseif choice==2
    
    run("diode_exported_Bernstein"); %Code for GUI and plots
    
else
    
    
    choice2=menu('Which Diode?','Diode X','Diode Y','Diode Z','All Three');
        
    if choice2==1
        
        for i=1:length(VoltX)-3
            xin=[VoltX(i),VoltX(i+1),VoltX(i+2)];
            yin=[CurrX(i),CurrX(i+1),CurrX(i+2)];
            yi(i)=intrpf(VoltX(i),xin,yin);
        end
       
        for i=length(VoltX)-3:length(VoltX)
            yi(i)=CurrX(i);
        end
        plot(VoltX,CurrX,'x',VoltX,yi,'red')
        title('Interpolation of I-V curve for one diode')
        xlabel('Voltage (V)'), ylabel('Current (A)')
        
        
    elseif choice2==2
        
        for i=1:length(VoltY)-3
            xin=[VoltY(i),VoltY(i+1),VoltY(i+2)];
            yin=[CurrY(i),CurrY(i+1),CurrY(i+2)];
            yi(i)=intrpf(VoltY(i),xin,yin);
        end
        
        for i=length(VoltY)-3:length(VoltY)
            yi(i)=CurrY(i);
        end
        plot(VoltY,CurrY,'o',VoltY,yi,'red')
        title('Interpolation of I-V curve for one diode')
        xlabel('Voltage (V)'), ylabel('Current (A)')
    elseif choice2==3
        
        for i=1:length(VoltZ)-3
            xin=[VoltZ(i),VoltZ(i+1),VoltZ(i+2)];
            yin=[CurrZ(i),CurrZ(i+1),CurrZ(i+2)];
            yi(i)=intrpf(VoltZ(i),xin,yin);
        end
        for i=length(VoltZ)-3:length(VoltZ)
            yi(i)=CurrZ(i);
        end
        plot(VoltZ,CurrZ,'square',VoltZ,yi,'red')
        title('Interpolation of I-V curve for one diode')
        xlabel('Voltage (V)'), ylabel('Current (A)')
    else
        
        for i=1:length(VoltX)-3
            xin=[VoltX(i),VoltX(i+1),VoltX(i+2)];
            yin=[CurrX(i),CurrX(i+1),CurrX(i+2)];
            yi1(i)=intrpf(VoltX(i),xin,yin);
        end
       
        for i=length(VoltX)-3:length(VoltX)
            yi1(i)=CurrX(i);
        end
        
        for i=1:length(VoltY)-3
            xin=[VoltY(i),VoltY(i+1),VoltY(i+2)];
            yin=[CurrY(i),CurrY(i+1),CurrY(i+2)];
            yi2(i)=intrpf(VoltY(i),xin,yin);
        end
        
        for i=length(VoltY)-3:length(VoltY)
            yi2(i)=CurrY(i);
        end
        
        for i=1:length(VoltZ)-3
            xin=[VoltZ(i),VoltZ(i+1),VoltZ(i+2)];
            yin=[CurrZ(i),CurrZ(i+1),CurrZ(i+2)];
            yi3(i)=intrpf(VoltZ(i),xin,yin);
        end
        for i=length(VoltZ)-3:length(VoltZ)
            yi3(i)=CurrZ(i);
        end
        
        plot(VoltX,CurrX,'x',VoltX,yi1,'red',VoltY,CurrY,'o',VoltY,yi2,'red',VoltZ,CurrZ,'square',VoltZ,yi3,'red')
        title('Interpolation of I-V curve for three diodes')
        xlabel('Voltage (V)'), ylabel('Current (A)')
    end
    
    
end

end
